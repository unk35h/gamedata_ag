slot0 = class("WeaponServantWakeUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponServantWakeUp"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		ServantAction.ServantMerge(uv0.servantID_, {
			uv0.uid_
		})
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnServantMergeResult(slot0, slot1, slot2)
	slot0:Go("/weaponServantMergeResultView", {
		servantID = slot0.servantID_,
		uid = tonumber(slot1.servant_uid),
		backThrice = slot0.backThrice_
	})
end

function slot0.OnEnter(slot0)
	slot0.servantID_ = slot0.params_.servantID
	slot0.uid_ = slot0.params_.uid
	slot0.backThrice_ = slot0.params_.backThrice
	slot1 = ServantTools.GetServantSpecHero(slot0.servantID_)
	slot0.characterImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot1)
	slot0.heronameText_.text = HeroCfg[slot1].name
	slot0.servantnameText_.text = ItemCfg[slot0.servantID_].name

	slot0:UpdateImg()
	slot0:UpdateTips()
end

function slot0.UpdateImg(slot0)
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("Textures/WeaponServant/Portrait/" .. slot0.servantID_)
end

function slot0.UpdateTips(slot0)
	slot3 = GameSetting.weapon_promote_max.value[WeaponServantCfg[slot0.servantID_].starlevel] + 1
	slot4 = 0
	slot5 = 0

	if WeaponServantData:GetServantSByID(slot0.servantID_) then
		for slot9, slot10 in pairs(slot1) do
			if slot4 < WeaponServantData:GetServantDataByUID(slot9).stage then
				slot4 = slot11.stage
			end

			slot5 = slot5 + 1
		end
	end

	slot4 = slot4 + slot5 - 1

	if slot5 > 0 then
		SetActive(slot0.tipsGo_, true)

		if slot3 < slot4 then
			slot4 = slot3 or slot4
		end

		slot0.tipsText_.text = string.format(GetTips("SERVANT_TRANSCEND_PROMPT"), tostring(slot4))
	else
		SetActive(slot0.tipsGo_, false)
	end
end

function slot0.OnExit(slot0)
end

return slot0
