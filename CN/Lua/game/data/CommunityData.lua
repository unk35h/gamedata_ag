slot0 = singletonClass("CommunityData")
slot1 = {
	welfareType = 0,
	currenyA = 0
}

function slot0.Init(slot0)
	uv0 = {
		welfareType = 0,
		currenyA = 0
	}
	slot0.welfareExchangeCnt_ = 0
end

function slot0.RefreshCurrencyA(slot0, slot1)
	uv0.currenyA = slot1

	manager.notify:Invoke(CURRENCY_UPDATE, CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function slot0.GetIdentity(slot0)
	return GuildData:GetGuildInfo().post or 1
end

function slot0.SetWelfareType(slot0, slot1)
	uv0.welfareType = slot1
end

function slot0.GetWelfareType(slot0)
	return uv0.welfareType
end

function slot0.GetCurrenyA(slot0)
	return uv0.currenyA
end

function slot0.SetWealfareExchangeCnt(slot0, slot1)
	slot0.welfareExchangeCnt_ = slot1

	manager.notify:Invoke(GUILD_WELFRE_CNT_REFRESH)
end

function slot0.GetWelfareExchangeCnt(slot0)
	return slot0.welfareExchangeCnt_
end

function slot0.CommunityExit(slot0)
	slot0:SetWelfareType(CommunityConst.WELFARE_TYPE.CLOSE)
	CommunityAction:RefreshRedPoint()
end

return slot0
