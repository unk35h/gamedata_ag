slot0 = class("WeaponAvatarView", ReduxView)
slot1 = {
	weapon = 2,
	hero = 1
}

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
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0, slot1)
	slot0.type_ = slot1

	slot0:InitBackScene(slot1)
end

function slot0.OnExit(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end

	slot0:Finish()
end

function slot0.SetWeaponID(slot0, slot1)
	if slot0.weaponID_ == SkinCfg[slot1].id then
		return
	end

	slot0:Finish()
	slot0:LoadModel(slot2)

	slot0.weaponID_ = slot2
end

function slot0.ShowWeaponModel(slot0, slot1)
	if slot0.weaponModel_ then
		SetActive(slot0.weaponModel_, slot1)
	end
end

function slot0.InitBackScene(slot0, slot1)
	if slot1 == uv0.hero then
		return
	end

	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot3, slot4 = nil

	if slot1 == uv0.weapon then
		slot3 = GameDisplayCfg.weapon_background_pos.value
		slot4 = CameraCfg.weapon.pictureName
	elseif slot1 == uv0.hero then
		slot3 = GameDisplayCfg.hero_modelld_background_pos.value
		slot4 = CameraCfg.hero.pictureName
	end

	slot0.backGroundTrs_.localPosition = Vector3(slot3[1], slot3[2], slot3[3])
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(SpritePathCfg.Bg.path .. slot4)
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

	slot0.weaponID_ = nil

	if slot0.weaponModel_ then
		manager.resourcePool:DestroyOrReturn(slot0.weaponModel_, ASSET_TYPE.TPOSE)

		slot0.weaponModel_ = nil
		slot0.animator_ = nil
		slot0.actionTimer_ = nil
		slot0.actioning_ = false
		slot0.weapomNode_ = nil
		slot0.weapomNode2_ = nil
		slot0.weapomNode3_ = nil
	end
end

function slot0.InitModel(slot0, slot1, slot2)
	slot0.weaponModel_ = slot1
	slot3 = HeroCfg[slot2]
	slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot0.weaponModel_.transform)

	if slot0.animator_ == nil then
		-- Nothing
	end
end

function slot0.LoadModel(slot0, slot1)
	slot3 = manager.resourcePool:Get("Weapon/" .. SkinCfg[slot1].weapon_modelId, ASSET_TYPE.WEAPON)
	slot4, slot5 = nil

	if slot0.type_ == 1 then
		slot4 = GameDisplayCfg.weapon_pos1.value
		slot5 = GameDisplayCfg.weapon_rot1.value
	elseif slot0.type_ == 2 then
		slot4 = GameDisplayCfg.weapon_pos1.value
		slot5 = GameDisplayCfg.weapon_rot1.value
	end

	slot3.transform.localPosition = Vector3(slot4[1], slot4[2], slot4[3])
	slot3.transform.localEulerAngles = Vector3(slot5[1], slot5[2], slot5[3])
	slot3.transform.localScale = Vector3(1, 1, 1)

	slot0:InitModel(slot3, slot2.id)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:Finish()
	uv0.super.Dispose(slot0)
end

return slot0
