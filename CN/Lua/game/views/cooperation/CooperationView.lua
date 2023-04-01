slot0 = class("CooperationView", ReduxView)
slot1 = {
	{
		position = Vector3(500, 0, 0),
		rotation = Vector3(0, 0, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(502, 0, -2.5),
		rotation = Vector3(0, -16.419, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(498, 0, -2.5),
		rotation = Vector3(0, 9.932, 0),
		scale = Vector3(1, 1, 1)
	}
}

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Cooperation/CooperationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.friendController = ControllerUtil.GetController(slot0.m_friendEffectController, "friendEffect")
	slot0.raceController = ControllerUtil.GetController(slot0.m_raceEffectController, "raceEffect")
	slot0.roomAvailableController = ControllerUtil.GetController(slot0.m_roomAvailabelController, "swich")
	slot0.btnController = ControllerUtil.GetController(slot0.m_btnController, "btn")
	slot4 = "talk"
	slot0.talkController = ControllerUtil.GetController(slot0.m_talkController, slot4)
	slot0.playerComList = {}

	for slot4 = 1, 3 do
		table.insert(slot0.playerComList, CooperationPlayer.New(slot0["m_hero" .. slot4], slot4))
	end

	slot0.heroModel = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_startBtn, function ()
		slot0 = PlayerData:GetPlayerInfo().userID
		slot1 = uv0.roomData:GetSelfHero()

		for slot6, slot7 in ipairs(uv0.roomData:GetRoomPlayerIdList()) do
			slot8 = uv0.roomData:GetRoomPlayerData(slot7)

			if slot7 ~= slot0 and slot8.heroList[1].id == slot1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end

			slot9 = slot8.is_master == 1
			slot10 = slot8.is_ready == 1

			if slot8 and not slot9 and not slot10 then
				ShowTips("COOPERATION_SOMEONE_UNREADY")

				return
			end
		end

		BattleController.GetInstance():LaunchCooperationBattle()
	end)
	slot0:AddBtnListener(nil, slot0.m_prepareBtn, function ()
		slot0 = PlayerData:GetPlayerInfo().userID
		slot1 = uv0.roomData:GetSelfHero()

		for slot6, slot7 in ipairs(uv0.roomData:GetRoomPlayerIdList()) do
			if slot7 ~= slot0 and uv0.roomData:GetRoomPlayerData(slot7).heroList[1].id == slot1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end
		end

		CooperationAction.GetReady()
	end)
	slot0:AddBtnListener(nil, slot0.m_cancelBtn, function ()
		CooperationAction.CancelReay()
	end)
	slot0:AddBtnListener(nil, slot0.m_roomAvailableBtn, function ()
		if CooperationData:GetIsMaster() then
			if uv0.roomData:IsAvailable() == 1 then
				CooperationAction.ChangeRoomAvailable(2)
			else
				CooperationAction.ChangeRoomAvailable(1)
			end
		else
			ShowTips("ERROR_COORDINATOR_NOT_OWNER")
		end
	end)
	slot0:AddBtnListener(slot0.m_talkLongBtn, nil, function ()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	slot0:AddBtnListener(slot0.m_talkShortBtn, nil, function ()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function slot0.OnTop(slot0)
	slot1 = manager.ui

	slot1:SetMainCamera("battleHeroSelect")

	slot1 = manager.ui

	slot1:AdaptUIByFOV()

	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		ShowMessageBox({
			content = GetTips("COOPERATION_LEAVE_ROOM_CONFIRM"),
			OkCallback = function ()
				CooperationAction.LeaveRoom()
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()

	slot0.roomData = CooperationData:GetRoomData()

	slot0:Refresh()
	slot0:NewMessage()
	slot0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(slot0, slot0.NewMessage))

	slot4 = 1

	FriendsAction:TryToRefreshFriendsView(slot4)

	for slot4 = 1, 3 do
		slot9, slot10 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.transform_, manager.ui.mainCameraCom_:WorldToScreenPoint(uv0[slot4].position), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

		print(slot10.x)

		slot0["m_hero" .. slot4].transform.localPosition = Vector3.New(slot10.x, 10, 0)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:DestroyHeroModels()

	slot0.playerList = nil
end

function slot0.Refresh(slot0)
	if not slot0.roomData then
		return
	end

	slot0.m_stageLab.text = slot0.roomData and slot0.roomData.room_id or ""
	slot0.playerIdList = slot0.playerIdList or {}
	slot1 = {}
	slot2 = slot0.roomData:GetRoomPlayerIdList()

	for slot6 = 1, 3 do
		if slot6 == 1 then
			slot7 = PlayerData:GetPlayerInfo().userID

			table.remove(slot2, table.indexof(slot2, slot7))

			slot1[1] = slot7
		elseif slot0.playerIdList[slot6] and table.indexof(slot2, slot7) then
			slot1[slot6] = slot2[slot8]

			table.remove(slot2, slot8)
		end
	end

	for slot6 = 1, 3 do
		if not slot1[slot6] then
			slot7 = false

			for slot11, slot12 in ipairs(slot2) do
				if slot0.roomData:GetRoomPlayerData(slot12).is_master == 1 then
					table.remove(slot2, slot11)

					slot1[slot6] = slot12
					slot7 = true

					break
				end
			end

			if not slot7 then
				slot1[slot6] = table.remove(slot2, 1)
			end
		end
	end

	slot0.playerIdList = slot1
	slot0.cacheHeroTeam_ = {}

	for slot6, slot7 in pairs(slot0.playerIdList) do
		slot0.cacheHeroTeam_[slot6] = slot0.roomData:GetRoomPlayerData(slot7).heroList[1].id
	end

	slot0:LoadHeroModelsInOrder(1)
	slot0:RefreshRoom()
	slot0:RefreshPlayerState()
	slot0:RefreshEffct()
end

function slot0.RefreshRoom(slot0)
	slot0.roomAvailableController:SetSelectedIndex(slot0.roomData:IsAvailable() == 1 and 0 or 1)

	slot5 = slot3.is_ready == 1

	if slot0.roomData:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID).is_master == 1 then
		slot0.btnController:SetSelectedIndex(0)
	elseif slot5 then
		slot0.btnController:SetSelectedIndex(2)
	else
		slot0.btnController:SetSelectedIndex(1)
	end
end

function slot0.RefreshPlayerState(slot0)
	for slot4 = 1, 3 do
		slot0.playerComList[slot4]:SetData(slot0.roomData, slot0.playerIdList[slot4])
	end
end

function slot0.RefreshEffct(slot0)
	slot1, slot2 = slot0:GetRaceEffect()
	slot0.m_raceEffect2Des.text = GetTips("NO_CORRECTOR_BUFF")
	slot0.m_raceEffect3Des.text = GetTips("NO_BATTLE_BUFF")

	if slot2 == 2 then
		slot3 = RaceEffectCfg[slot1]
		slot0.m_raceEffectName.text = slot3.name
		slot0.m_raceEffectIcon.sprite = getSprite("Atlas/CampItem", slot3.icon)
		slot0.m_raceEffect2Des.text = slot3.desc

		slot0.raceController:SetSelectedIndex(1)
	elseif slot2 == 3 then
		slot3 = RaceEffectCfg[slot1]
		slot0.m_raceEffectName.text = slot3.name
		slot0.m_raceEffectIcon.sprite = getSprite("Atlas/CampItem", slot3.icon)
		slot0.m_raceEffect2Des.text = slot3.desc
		slot0.m_raceEffect3Des.text = slot3.battle_desc

		slot0.raceController:SetSelectedIndex(2)
	else
		slot0.raceController:SetSelectedIndex(0)
	end

	slot3 = 0

	for slot8, slot9 in ipairs(slot0.roomData:GetRoomPlayerIdList()) do
		if false then
			slot3 = slot3 + 1
		end
	end

	if slot3 > 0 then
		slot0.friendController:SetSelectedIndex(0)

		slot0.m_friendEffectDes.text = ""
	else
		slot0.friendController:SetSelectedIndex(1)

		slot0.m_friendEffectDes.text = ""
	end
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0

	for slot7, slot8 in pairs(slot0.cacheHeroTeam_) do
		if slot8 ~= 0 then
			slot1[slot9] = (slot1[HeroCfg[slot8].race] or 0) + 1

			if slot1[slot9] == 2 then
				slot2 = slot9
			end
		end
	end

	return slot2, slot1[slot2] or 1
end

function slot0.LoadHeroModelsInOrder(slot0, slot1)
	if slot1 > 3 then
		for slot5, slot6 in pairs(slot0.heroModel) do
			SetActive(slot6.model, true)
		end

		return
	end

	slot2 = slot0.cacheHeroTeam_[slot1]

	if slot0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(slot0.loadAsyncIndex)
	end

	if slot0.heroModel[slot1] then
		if slot2 == slot0.heroModel[slot1].id then
			slot3 = slot0.heroModel[slot1].model
			slot4 = slot1
			slot3.transform.localEulerAngles = uv0[slot4].rotation
			slot3.transform.localPosition = uv0[slot4].position
			slot3.transform.localScale = uv0[slot4].scale

			slot0:LoadHeroModelsInOrder(slot1 + 1)

			return
		else
			manager.resourcePool:DestroyOrReturn(slot0.heroModel[slot1].model, ASSET_TYPE.TPOSE)

			slot0.heroModel[slot1] = nil
		end
	end

	if slot2 then
		slot4 = manager.resourcePool
		slot0.loadAsyncIndex = slot4:AsyncLoad("Char/" .. SkinCfg[slot2].ui_modelId, ASSET_TYPE.TPOSE, function (slot0)
			uv0.heroModel[uv1] = {
				model = slot0,
				id = uv2
			}
			slot1 = uv1
			slot0.transform.localEulerAngles = uv3[slot1].rotation
			slot0.transform.localPosition = uv3[slot1].position
			slot0.transform.localScale = uv3[slot1].scale

			SetActive(slot0, false)
			TimeTools.StartAfterSeconds(0.0333, function ()
				uv0:LoadHeroModelsInOrder(uv1 + 1)
			end, {})
		end)
	else
		slot0:LoadHeroModelsInOrder(slot1 + 1)
	end
end

function slot0.DestroyHeroModels(slot0)
	if slot0.heroModel then
		for slot4, slot5 in pairs(slot0.heroModel) do
			manager.resourcePool:DestroyOrReturn(slot5.model, ASSET_TYPE.TPOSE)
		end
	end

	if slot0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(slot0.loadAsyncIndex)
	end

	slot0.loadAsyncIndex = nil
	slot0.heroModel = {}
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.playerComList) do
		slot5:Dispose()
	end

	slot0.playerComList = {}

	uv0.super.Dispose(slot0)
end

function slot0.NewMessage(slot0)
	if #ChatCooperationData:GetCacheContent() > 0 then
		slot3 = slot1[#slot1].content or ""

		if slot2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			slot3 = string.format("[%s]", ChatStickerCfg[tonumber(slot2.content)].name)
		end

		slot6 = slot0.m_chatLab

		if slot0.m_chatLab.transform.rect.width < slot6.cachedTextGenerator:GetPreferredWidth(string.format("%s:%s", slot2.nick, slot3), slot6:GetGenerationSettings(slot0.m_chatLab.transform.rect.size)) * 1 / slot6.pixelsPerUnit then
			SetActive(slot0.m_chatLabEx, true)
		else
			SetActive(slot0.m_chatLabEx, false)
		end

		slot6.text = slot4

		slot0.talkController:SetSelectedIndex(1)
	else
		slot0.m_chatLab.text = ""

		slot0.talkController:SetSelectedIndex(0)
	end
end

function slot0.OnCooperationRoomInit(slot0)
	slot0:Refresh()
end

function slot0.OnCooperationRoomUpdate(slot0)
	slot0:Refresh()
end

function slot0.OnFriendsListChange(slot0, slot1)
	slot0:RefreshPlayerState()
end

return slot0
