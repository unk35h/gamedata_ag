slot0 = class("CooperationPlayer", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = slot2

	slot0:Init()
	slot0.positionController:SetSelectedIndex(slot2 - 1)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.masterController = ControllerUtil.GetController(slot0.transform_, "master")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.playerController = ControllerUtil.GetController(slot0.transform_, "player")
	slot0.infoController = ControllerUtil.GetController(slot0.transform_, "info")
	slot0.positionController = ControllerUtil.GetController(slot0.transform_, "position")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if PlayerData:GetPlayerInfo().userID == uv0.roomPlayerId then
			uv0:Go("/heroTeamInfoCooperation")
		elseif uv0.infoController:GetSelectedState() == "common" then
			if CooperationData:GetIsMaster() then
				uv0.infoController:SetSelectedIndex(2)
			else
				uv0.infoController:SetSelectedIndex(1)
			end
		else
			uv0.infoController:SetSelectedIndex(0)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_playerInfoBtn, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.roomPlayerId)
	end)
	slot0:AddBtnListener(nil, slot0.m_heroInfoBtn, function ()
		slot0 = uv0.roomPlayer.heroList
		slot1 = slot0[1].id

		if slot0[1].trialID and slot2 ~= 0 then
			uv0:Go("/newHero", {
				isEnter = true,
				isTemp = true,
				hid = slot1,
				tempHeroList = {
					slot2
				}
			})
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_addFriendBtn, function ()
		FriendsAction:TryToRequestToFriend(uv0.roomPlayerId)
	end)
	slot0:AddBtnListener(nil, slot0.m_changeMasterBtn, function ()
		CooperationAction.ChangeRoomMaster(uv0.roomPlayerId)
	end)
	slot0:AddBtnListener(nil, slot0.m_kickOutBtn, function ()
		CooperationAction.KickOutRoom(uv0.roomPlayerId)
	end)
	slot0:AddBtnListener(nil, slot0.m_inviteBtn, function ()
		JumpTools.GoToSystem("cooperationInvitation")
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.roomPlayerId = slot2
	slot0.room = slot1

	if slot2 then
		slot0.roomPlayer = slot1:GetRoomPlayerData(slot2)
		slot0.m_heroName.text = slot0.roomPlayer.nick

		slot0.masterController:SetSelectedIndex(slot0.roomPlayer.is_master == 1 and 1 or 0)

		slot5 = slot0.roomPlayer.heroList[1].id

		if slot0.roomPlayer.is_ready == 1 then
			slot0.stateController:SetSelectedIndex(1)
		elseif slot0.room:RepeatHero(slot5) then
			slot0.stateController:SetSelectedIndex(3)
		else
			slot0.stateController:SetSelectedIndex(0)
		end

		slot0.infoController:SetSelectedIndex(0)
		slot0.playerController:SetSelectedIndex(1)

		slot6 = PlayerData:GetPlayerInfo().userID

		if table.indexof(FriendsData:GetList(1), tostring(slot0.roomPlayerId)) then
			slot0.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
			slot0.m_addFriendBtn.interactable = false
		else
			slot0.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
			slot0.m_addFriendBtn.interactable = true
		end
	else
		slot0.playerController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
