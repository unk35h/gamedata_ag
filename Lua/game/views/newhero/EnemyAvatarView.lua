slot0 = class("EnemyAvatarView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.playable_ = slot0:FindCom(typeof(PlayableDirector), "")
	slot0.backGo_ = slot0:FindGo("back")
end

function slot0.AddUIListener(slot0)
	slot0:AddDragListener(slot0.backGo_, function ()
		if uv0.bossModel_ then
			uv0.startRot_ = uv0.rotaNote_.localEulerAngles
		else
			uv0.startRot_ = Vector3.zero
		end

		uv0.lastDeltaX_ = 0
	end, function (slot0, slot1)
		if uv0.bossModel_ then
			if (uv0.lastRotateY_ or uv0.rotaNote_.localEulerAngles.y) > 180 then
				slot2 = slot2 - 360
			end

			slot4 = slot2 + (slot0 - (uv0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - slot2
			slot5 = slot4

			if slot4 < -HeroConst.MAX_RORATE_ANGLE then
				slot5 = -HeroConst.MAX_RORATE_ANGLE
			elseif HeroConst.MAX_RORATE_ANGLE < slot4 then
				slot5 = HeroConst.MAX_RORATE_ANGLE
			end

			if slot2 + slot5 < uv0.rot_limit_[1] then
				slot3 = uv0.rot_limit_[1]
			elseif uv0.rot_limit_[2] < slot3 then
				slot3 = uv0.rot_limit_[2]
			end

			uv0.lastRotateY_ = slot3
			uv0.lastDeltaX_ = slot0
			uv0.rotaNote_.localRotation = Quaternion.RotateTowards(uv0.rotaNote_.localRotation, Quaternion.Euler(uv0.startRot_.x, slot3, uv0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:InitBackScene()
end

function slot0.OnExit(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end

	slot0:Finish()

	slot0.lastRotateY_ = nil
end

function slot0.SetBossID(slot0, slot1)
	if slot0.bossID_ == slot1 then
		return
	end

	slot0:Finish()
	slot0:LoadModel(slot1)

	slot0.bossID_ = slot1
end

function slot0.ShowBossModel(slot0, slot1)
	if slot0.bossModel_ then
		SetActive(slot0.bossModel_, slot1)
	end
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2, slot3 = nil
	slot2 = GameDisplayCfg.collect_monster_background_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], slot2[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot4 = GameDisplayCfg.collect_monster_background_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot4[1], slot4[2], slot4[3])
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

function slot0.Finish(slot0)
	if slot0.animator_ then
		if slot0.playable_ then
			slot0.playable_:Stop()
		end

		if slot0.animator_.gameObject:GetComponent("LipSync") then
			slot1:ResetEmotion(0)
		end
	end

	slot0.bossID_ = nil

	if slot0.bossModel_ then
		manager.resourcePool:DestroyOrReturn(slot0.bossModel_, ASSET_TYPE.TPOSE)

		slot0.bossModel_ = nil
		slot0.animator_ = nil
		slot0.actionTimer_ = nil
		slot0.actioning_ = false
	end
end

function slot0.InitModel(slot0, slot1, slot2)
	slot0.bossModel_ = slot1
	slot0.rotaNote_ = slot1.transform
	slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot0.bossModel_.transform)

	if slot0.animator_ == nil then
		-- Nothing
	end
end

function slot0.LoadModel(slot0, slot1)
	slot2 = BossChallengeUICfg[slot1]
	slot3 = manager.resourcePool:Get("Char/" .. slot2.model_name[1], ASSET_TYPE.TPOSE)
	slot4, slot5, slot6 = nil
	slot4 = slot2.model_pos[1]
	slot5 = slot2.model_rot[1]
	slot6 = slot2.model_scale[1]
	slot0.rot_limit_ = slot2.model_rot_limit or {
		-180,
		180
	}
	slot3.transform.localPosition = Vector3(slot4[1], slot4[2], slot4[3])
	slot3.transform.localEulerAngles = Vector3(slot5[1], slot5[2], slot5[3])
	slot3.transform.localScale = Vector3(slot6[1], slot6[2], slot6[3])

	slot0:InitModel(slot3, slot2.id)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:Finish()
	uv0.super.Dispose(slot0)
end

return slot0
