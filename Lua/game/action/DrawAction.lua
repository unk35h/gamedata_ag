slot1 = manager.net

slot1:Bind(16015, function (slot0)
	DrawData:InitPool(slot0)
end)

return {
	GoToDraw = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(16010, {
			type = slot1,
			pool = slot0,
			cost = {
				id = slot2,
				num = slot3
			}
		}, 16011, uv0.OnGoToDraw)
	end,
	OnGoToDraw = function (slot0, slot1)
		if slot0.result == 0 then
			slot3 = slot1.cost.num

			if ItemCfg[slot1.cost.id].type == ItemConst.ITEM_TYPE.CURRENCY then
				CurrencyAction.CurrencyModify(slot2, -1 * slot3)
			elseif slot4 == ItemConst.ITEM_TYPE.MATERIAL then
				MaterialAction.MaterialModify(slot2, -1 * slot3)
			end

			slot5 = 0

			if DrawConst.DRAW_TYPE.ONE == slot1.type then
				slot5 = 1

				SendMessageManagerToSDK("roll_complete_1")
			elseif DrawConst.DRAW_TYPE.TEN == slot1.type then
				slot5 = 10

				SendMessageManagerToSDK("roll_complete_10")
			end

			DrawData:UpdatePool(slot1.pool, slot0.ssr_draw_times, slot0.first_ssr_draw_flag)
			AchievementAction.SendMessageForDrawAction(slot0, slot1)
		end

		DrawData:SetDrawRecord(slot1.pool, nil)
		manager.notify:CallUpdateFunc(GO_TO_DRAW, slot0, slot1)
	end,
	BuyTicket = function (slot0, slot1)
		manager.net:SendWithLoadingNew(15014, {
			num = slot0,
			ticket_id = slot1
		}, 15015, uv0.OnBuyTicket)
	end,
	OnBuyTicket = function (slot0, slot1)
		manager.notify:CallUpdateFunc(BUY_TICKET, slot0, slot1)
	end,
	RequestRecord = function (slot0)
		manager.net:SendWithLoadingNew(16012, {
			id = slot0
		}, 16013, uv0.OnRequestRecord)
	end,
	OnRequestRecord = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DrawData:SetDrawRecord(slot1.id, slot0)
			manager.notify:CallUpdateFunc(REQUEST_RECORD, slot0, slot1)
		end
	end,
	SetPollUpID = function (slot0, slot1)
		manager.net:SendWithLoadingNew(16016, {
			id = slot0,
			up = slot1
		}, 16017, uv0.OnSetPollUpID)
	end,
	OnSetPollUpID = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DrawData:SetPollUpID(slot1.id, slot1.up)
			manager.notify:CallUpdateFunc(SET_POLL_UP_ID, slot0, slot1)
		else
			ShowTips(slot0.result)
			JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
		end
	end
}
