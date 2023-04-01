slot0 = class("HeroInteractView ", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormInteractionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.touchController = ControllerUtil.GetController(slot0.touchbtnBtn_.gameObject.transform, "lock")
	slot0.gameController = ControllerUtil.GetController(slot0.gameBtn_.gameObject.transform, "lock")
	slot0.replaceController = ControllerUtil.GetController(slot0.replacebtnBtn_.gameObject.transform, "lock")
	slot0.feedController = ControllerUtil.GetController(slot0.feedfoodbtnBtn_.gameObject.transform, "lock")
	slot0.giftController = ControllerUtil.GetController(slot0.giftbtnBtn_.gameObject.transform, "lock")
end

function slot0.OnEnter(slot0)
	Dorm.DormEntityManager.EnablePlayerInput = false
	slot0.heroEID = slot0.params_.heroEID
	slot0.canInteractFlag = true
	slot0.heroID = CanteenAIFunction:GetEntityData(slot0.heroEID).cfgID
	slot0.archiveID = DormData:GetHeroArchiveID(slot0.heroID)
	slot0.heroInfo = DormData:GetHeroInfo(slot0.archiveID)

	slot0:RefreshView()
	slot0:RegisterEvent()
end

function slot0.OnExit(slot0)
	Dorm.DormEntityManager.EnablePlayerInput = true
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DORM_FEED_FOOD_HERO, function ()
		uv0:RefreshView()
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_INTERACT_FINISH, function ()
		uv0.canInteractFlag = true
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.giftbtnBtn_, nil, function ()
		if not DormitoryData:GetDormIDViaArchive(uv0.archiveID) then
			ShowTips(GetTips("DORM_HERO_NOT_SET"))

			return
		end

		JumpTools.OpenPageByJump("/dormHeroGiftView", {
			archiveID = uv0.archiveID,
			heroEID = uv0.heroEID
		})
	end)
	slot0:AddBtnListenerScale(slot0.touchbtnBtn_, nil, function ()
		if uv0.canInteractFlag then
			if DormData:GetDormLevelByHeroID(uv0.archiveID) < GameSetting.dorm_menu_touch_unlock.value[1] then
				return
			end

			if uv0.heroInfo then
				uv0.canInteractFlag = false

				uv0.heroInfo:TouchHero(uv0.heroEID)
			end
		else
			ShowTips(GetTips("HERO_CANT_INTERACT"))
		end
	end)
	slot0:AddBtnListenerScale(slot0.replacebtnBtn_, nil, function ()
	end)
	slot0:AddBtnListenerScale(slot0.feedfoodbtnBtn_, nil, function ()
		if uv0.canInteractFlag then
			if DormData:GetDormLevelByHeroID(uv0.archiveID) < GameSetting.dorm_menu_feed_unlock.value[1] then
				return
			end

			if GameSetting.dorm_feed_max.value[1] <= DormData:GetHeroTemplateInfo(uv0.heroID).feed_times then
				ShowTips(GetTips("DORM_FEED_MAX"))

				return
			end

			uv0.canInteractFlag = false

			DormAction:GiftFoodToHero(uv0.heroID, uv0.heroEID)
		else
			ShowTips(GetTips("HERO_CANT_INTERACT"))
		end
	end)
	slot0:AddBtnListenerScale(slot0.closebtnBtn_, nil, function ()
		DormLuaBridge.ChangeCameraMode(0, false)
		manager.notify:Invoke(DORM_RESET_HERO_AI, uv0.heroEID)
		Dorm.DormEntityManager.SetPlayerEntityFaceToCam(uv0.heroEID, false)
		JumpTools.OpenPageByJump("/dorm")

		slot4 = DormCharacterManager.EIdNamespace(DormEnum.CharacterType.DormNormalHero)
		slot5 = pairs

		for slot4, slot5 in Dorm.storage:ForeachData(slot4, slot5) do
			if slot5 ~= uv0.heroEID then
				Dorm.DormEntityManager.ClearFadeOutPoint(slot5)
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.gameBtn_, nil, function ()
	end)
end

function slot0.RefreshView(slot0)
	slot0.giftController:SetSelectedState("normal")
	slot0.touchController:SetSelectedState("normal")
	slot0.gameController:SetSelectedState("normal")
	slot0.replaceController:SetSelectedState("normal")
	slot0.feedController:SetSelectedState("normal")

	if DormData:GetDormLevelByHeroID(slot0.archiveID) == 0 then
		slot0.giftController:SetSelectedState("lock")
	end

	if slot1 < GameSetting.dorm_menu_feed_unlock.value[1] then
		slot0.feedController:SetSelectedState("lock")
	end

	if slot1 < GameSetting.dorm_menu_touch_unlock.value[1] then
		slot0.touchController:SetSelectedState("lock")
	end

	slot0.gameController:SetSelectedState("lock")
	slot0.replaceController:SetSelectedState("lock")

	slot0.maxFatigue.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.curFaitigue.text = slot0.heroInfo:GetFatigue()
	slot0.coverNum.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), slot0.heroInfo:GetRecoverFatigueNum())
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
