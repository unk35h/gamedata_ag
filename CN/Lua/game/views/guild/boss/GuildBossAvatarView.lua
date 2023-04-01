slot0 = class("GuildBossAvatarView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.playable_ = slot0:FindCom(typeof(PlayableDirector), "")
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0:InitBackScene()
end

function slot0.OnExit(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end

	slot0:Finish()
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
	slot2 = GameDisplayCfg.club_boss_bg_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], slot2[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot4 = GameDisplayCfg.club_boss_bg_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot4[1], slot4[2], slot4[3])
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.clubBoss.pictureName)
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
