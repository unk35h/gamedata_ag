slot1 = manager.net

slot1:Bind(31207, function (slot0)
	CommunityData:SetWelfareType(slot0.state)
	CommunityAction:RefreshRedPoint()
end)

slot1 = manager.net

slot1:Bind(31209, function (slot0)
	CommunityData:RefreshCurrencyA(slot0.num)
	CommunityData:SetWealfareExchangeCnt(slot0.special_reward_remain_time)
end)

return {
	OpenWelfare = function (slot0)
		manager.net:SendWithLoadingNew(31200, {}, 31201, handler(slot0, slot0.OnOpenWelfare))
	end,
	OnOpenWelfare = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("CLUB_WELFARE_OPEN")
			CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.RECEIVE)
			slot0:RefreshRedPoint()
		else
			ShowTips(slot1.result)
		end
	end,
	BuySpecialWelfare = function (slot0, slot1)
		manager.net:SendWithLoadingNew(31202, {
			num = slot1
		}, 31203, handler(slot0, slot0.OnBuySpecialWelfare))
	end,
	OnBuySpecialWelfare = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			manager.notify:CallUpdateFunc(COMMUNITY_BUY_SPECIAL_WELFARE)
		else
			ShowTips(slot1.result)
		end
	end,
	ReceiveWelfare = function (slot0)
		manager.net:SendWithLoadingNew(31204, {}, 31205, handler(slot0, slot0.OnReceiveWelfare))
	end,
	OnReceiveWelfare = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			slot3 = {}
			slot4 = ipairs
			slot6 = slot1.give_items or {}

			for slot7, slot8 in slot4(slot6) do
				table.insert(slot3, {
					slot8.id,
					slot8.num
				})
			end

			getReward(slot3)
			CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.FINISH)
			slot0:RefreshRedPoint()
			manager.notify:CallUpdateFunc(COMMUNITY_RECEIVE_WELFARE)
		else
			ShowTips(slot1.result)
		end
	end,
	RefreshCurrencyA = function (slot0)
		manager.net:SendWithLoadingNew(31208, {}, 31209)
	end,
	RefreshRedPoint = function (slot0)
		slot0:RefreshWelfare()
	end,
	RefreshWelfare = function (slot0)
		manager.redPoint:setTip(RedPointConst.CLUB_WELFARE, CommunityData:GetWelfareType() == CommunityConst.WELFARE_TYPE.RECEIVE and 1 or 0)
		manager.notify:CallUpdateFunc(COMMUNITY_REFRESH_WELFARE)
	end
}
