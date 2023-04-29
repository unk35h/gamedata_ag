RED_POINT_ID = {
	SHOP_TAOBAO = 14,
	ACTIVITY = 13,
	RECHARGE = 400,
	FORUM = 1,
	BATTLE_EQUIP = 301
}
slot1 = manager.net

slot1:Bind(56001, function (slot0)
	RedPointData:InitRedPointS(slot0.red_dot)
	RedPointData:InitClientRedPoint(slot0.client_finished_red_dot)
end)

slot1 = manager.net

slot1:Bind(56003, function (slot0)
	if isSuccess(slot0.result) then
		if whereami == "battle" or whereami == "battleResult" then
			ShowTips("EXCHANGE_CODE_ALERT2")
		else
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("EXCHANGE_CODE_ALERT1"),
				OkCallback = function ()
				end
			})
		end
	else
		ShowTips(slot0.result)
	end
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, function (slot0)
	uv0.OnActivityMainToggleClick(slot0)
end)

return {
	HandleRedPoint = function (slot0)
		manager.net:Push(56002, {
			red_dot = slot0
		})
		RedPointData:SetRedPointOpen(slot0, true)
	end,
	HandleNeedRedPoint = function (slot0)
		manager.net:Push(56002, {
			red_dot = slot0
		})
		RedPointData:SetNeedRedPointOpen(slot0, false)
	end,
	OnActivityMainToggleClick = function (slot0)
		if slot0 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
			RedPointData:SetJsonCacheRedPoint(RedPointConst.WARCHESS_CHINESE .. "_" .. ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE)
			RedPointData:UpdateRedPoint(slot0)
		end
	end,
	UpdateSDKRedPoint = function ()
		slot0 = {
			activity = 9910,
			forum = 9904,
			shop = 9911,
			attention = 9908,
			suggest = 9902,
			psq = 9907
		}
		slot1 = {}
		slot3 = PlayerData:GetPlayerInfo().userLevel

		if table.keyof(OperationData:GetOperationOpenList(), OperationConst.SUGGEST) ~= nil and not JumpTools.IsSystemLocked(slot0.suggest) then
			table.insert(slot1, RedPointConst.CUSTOMER_SERVICE_UNREAD)
		end

		if table.keyof(slot2, OperationConst.FORUM) ~= nil and not JumpTools.IsSystemLocked(slot0.forum) then
			table.insert(slot1, RedPointConst.FORUM_PLATFORM)
		end

		if table.keyof(slot2, OperationConst.QUESTIONNAIRE) ~= nil and not JumpTools.IsSystemLocked(slot0.psq) then
			table.insert(slot1, RedPointConst.SURVEY)
		end

		if table.keyof(slot2, OperationConst.ATTENTION) ~= nil and not JumpTools.IsSystemLocked(slot0.attention) then
			table.insert(slot1, RedPointConst.FOLLOW_GIFT)
		end

		if table.keyof(slot2, OperationConst.ACTIVITY) ~= nil and not JumpTools.IsSystemLocked(slot0.activity) then
			table.insert(slot1, RedPointConst.OPERATION_ACTIVITY)
		end

		if table.keyof(slot2, OperationConst.SHOP_TAOBAO) ~= nil and not JumpTools.IsSystemLocked(slot0.shop) then
			table.insert(slot1, RedPointConst.SHOP_TAOBAO)
		end

		for slot7, slot8 in ipairs(slot1) do
			if manager.redPoint:getTipValue(slot8) > 0 then
				manager.redPoint:setTip(RedPointConst.MAIN_HOME_SDK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.MAIN_HOME_SDK, 0)
	end
}
