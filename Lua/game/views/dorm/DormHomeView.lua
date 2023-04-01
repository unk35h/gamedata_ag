slot0 = class("DormHomeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormitoryUI"
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

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()
	slot0.subtitleBubbleView:OnEnter()

	slot0.sceneID_ = DormData:GetCurrectSceneID()

	if slot0.sceneID_ > 1000 then
		slot0.stateController:SetSelectedState("visit")

		if DormitoryData:GetCurVisitPlayerType() == 1 then
			slot0.friendController:SetSelectedState("false")
		elseif slot1 == 2 then
			slot0.friendController:SetSelectedState("true")
		end
	else
		slot0.stateController:SetSelectedState("room")

		if slot0.sceneID_ == DormitoryData:GetCurTemplateExhibit() then
			slot0.exhibitController:SetSelectedState("true")
		else
			slot0.exhibitController:SetSelectedState("false")
		end
	end

	if BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.PublicDorm or BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot0.roomName.text = GetTips("DORM_LOBBY_NAME")

		slot0.publicTextController:SetSelectedState("false")
	elseif BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.PrivateDorm or BackHomeCfg[slot0.sceneID_].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot0.publicTextController:SetSelectedState("true")

		if HeroRecordCfg.get_id_list_by_hero_id[DormitoryData:GetDormSceneData(slot0.sceneID_).archiveIDList[1]][1] then
			if HeroRecordCfg[slot2].name then
				slot0.roomName.text = string.format(GetTips("DORM_HERO_ROOM_NAME"), slot3)
			end

			slot0:RefreshRoomLevel()
		end
	end

	slot0:RefreshRedPonit()
	slot0:RefreshBar()

	slot0.uiShow = true
end

function slot0.RefreshRedPonit(slot0)
	manager.redPoint:bindUIandKey(slot0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)

	slot4 = slot0.fureidbtnBtn_.transform

	manager.redPoint:bindUIandKey(slot4, RedPointConst.DORM_FURNITURE)

	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		DormitoryData:UpdataDormFurRedPoint(slot0.sceneID_, slot4)
	end
end

function slot0.RefreshBar(slot0)
	if slot0.sceneID_ < 1000 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})

		if #GameSetting.dorm_info_describe.value > 0 then
			manager.windowBar:SetGameHelpKey({
				view = "/gameHelpPro",
				type = "jump",
				params = {
					hideHomeBtn = 1,
					pages = slot1
				}
			})
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.sceneID_ < 1000 then
			DormitoryData.GetInstance():Dispose()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/backHomeEnterView")
		else
			DormTools:VisitFlag(true)
			DormitoryData:ClearVisitRoomData()
			DormAction:CheckToEnterDormScene(DormConst.PUBLIC_DORM_ID)
		end
	end)

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		DormitoryData.GetInstance():Dispose()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.positionBtn_.transform, RedPointConst.DORM_PLACEMENT)
	manager.redPoint:unbindUIandKey(slot0.fureidbtnBtn_.transform, RedPointConst.DORM_FURNITURE)
	slot0.menuController:SetSelectedState("off")

	slot0.menuState = false

	slot0:RemoveAllEventListener()
	slot0.subtitleBubbleView:OnExit()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.cacheRoles = {}
	slot0.menuState = false
	slot0.menuController = ControllerUtil.GetController(slot0.btn_menuGo_.transform, "menu")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.exhibitController = ControllerUtil.GetController(slot0.exhib.transform, "state")
	slot0.publicTextController = ControllerUtil.GetController(slot0.transform_, "public")
	slot0.subtitleBubbleView = SubtitleBubbleView.New(slot0.subtitleView)

	slot0.subtitleBubbleView:Init()

	slot0.showUiController = ControllerUtil.GetController(slot0.btn_hideGo_.transform, "btn")
	slot0.friendController = ControllerUtil.GetController(slot0.transform_, "addFriend")
	slot0.menuAnimator = slot0:FindCom(typeof(Animator), "", slot0.menu_listTrs_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.positionBtn_, nil, function ()
		DormitoryData:UpdataDormRedPoint(false)
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	slot0:AddBtnListenerScale(slot0.characterplacebtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormHeroDeployView")
	end)
	slot0:AddBtnListenerScale(slot0.templateBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormTemplateView", {
			pos = 1
		})
	end)
	slot0:AddBtnListenerScale(slot0.fureidbtnBtn_, nil, DormTools.EnterFurnitureEdit)
	slot0:AddBtnListenerScale(slot0.dormlevelBtn_, nil, function ()
		if BackHomeCfg[uv0.sceneID_].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
			return
		end

		if DormitoryData:GetArchiveIDViaRoomID(uv0.sceneID_)[1] then
			JumpTools.OpenPageByJump("/dormLevelInfoView", {
				archiveID = slot0
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_storeBtn_, nil, function ()
		slot0 = {}
		slot1 = ShopListCfg[20].display_group

		for slot5, slot6 in ipairs(ShopListCfg.all) do
			if ShopListCfg[slot6].display_group == slot1 then
				table.insert(slot0, slot6)
			end
		end

		JumpTools.GoToSystem("/shop", {
			shopId = 20,
			hideHomeBtn = 1,
			showShops = slot0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListenerScale(slot0.btn_menuBtn_, nil, function ()
		if uv0.menuState then
			uv0.menuController:SetSelectedState("off")

			uv0.menuState = false
		else
			uv0.menuController:SetSelectedState("on")

			uv0.menuState = true

			uv0.menuAnimator:Play("DormitoryUI_menu_list")
		end
	end)
	slot0:AddBtnListenerScale(slot0.exhibBtn_, nil, function ()
		if not DormitoryData:GetCurTemplateExhibit() or uv0.sceneID_ ~= slot0 then
			DormAction:SetFurTemplateExhibit(uv0.sceneID_)
		else
			ShowTips(GetTips("DORM_DISPLAY_ALREADY"))
		end
	end)
	slot0:AddBtnListenerScale(slot0.collectBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormTemplateView", {
			pos = 1,
			canPreview = false
		})
	end)
	slot0:AddBtnListenerScale(slot0.addFriendBtn_, nil, function ()
		if DormitoryData:GetVisitUserID() then
			FriendsAction:TryToRequestToFriend(slot0)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btn_hideBtn_, nil, function ()
		if uv0.uiShow then
			uv0.showUiController:SetSelectedState("off")

			uv0.uiShow = false
			Dorm.DormEntityManager.EnablePlayerInput = false

			manager.windowBar:HideBar()
		else
			uv0.uiShow = true

			uv0.showUiController:SetSelectedState("on")

			Dorm.DormEntityManager.EnablePlayerInput = true

			uv0:RefreshBar()
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(ON_PLAYER_CLICK_INTERACT, function (slot0)
		if uv0.sceneID_ > 1000 then
			return
		end

		Dorm.DormEntityManager.EnablePlayerInput = false

		Timer.New(function ()
			JumpTools.OpenPageByJump("/heroInteractView", {
				heroEID = uv0
			})
		end, DormConst.CHARACTER_INTERACT_CAMERA_MOVE_TIME, 1):Start()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.InteractCam)

		slot5 = DormCharacterManager.EIdNamespace(DormEnum.CharacterType.DormNormalHero)
		slot6 = pairs

		for slot5, slot6 in Dorm.storage:ForeachData(slot5, slot6) do
			if slot6 ~= slot0 then
				Dorm.DormEntityManager.FadeOutNearPoint(slot6, UnityEngine.Camera.main.transform, DormLuaBridge.GetCamFadeOtherCharaParam(nil, ))
			end
		end
	end)
	slot0:RegistEventListener(DORM_REFRESH_EXIBIT, function ()
		if uv0.sceneID_ == DormitoryData:GetCurTemplateExhibit() then
			ShowTips(GetTips("DORM_DISPLAY_SET_SUCCESS"))
			uv0.exhibitController:SetSelectedState("true")
		else
			uv0.exhibitController:SetSelectedState("false")
		end
	end)
	slot0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function ()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
		uv0:RefreshRoomLevel()
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_STARTED, function ()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_RELEASED, function ()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)
	end)
end

function slot0.UnregisterEvents(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RefreshRoomLevel(slot0)
	if DormitoryData:GetDormLevel(slot0.sceneID_) then
		slot0.roomLevel.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot1)
	end
end

function slot0.UpdateView(slot0)
	slot0.attractiveLabel_.text = DormData:GetSceneAttractiveValue(DormData:GetCurrectSceneID())
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
