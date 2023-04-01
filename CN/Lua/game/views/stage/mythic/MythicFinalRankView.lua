slot0 = class("MythicFinalRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rankTypeConst_ = MythicData:GetRankTypeConst()

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MythicFinalRankItem)
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.m_allToggle, function (slot0)
		if slot0 then
			MythicData:SetCurRankType(uv0.rankTypeConst_.ALL)

			if not uv0.initedAllRank_ then
				MythicAction.QueryRankList()
			end

			uv0:Refresh()
		end
	end)
	slot0:AddToggleListener(slot0.m_guildToggle, function (slot0)
		if slot0 then
			MythicData:SetCurRankType(uv0.rankTypeConst_.GUILD)

			if not uv0.initedGuildRank_ then
				MythicAction.QueryRankList(handler(uv0, uv0.Refresh))
			else
				uv0:Refresh()
			end
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.initedAllRank_ = false
	slot0.initedGuildRank_ = false

	slot0:RefreshGuildRankGo()
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	MythicData:SetCurRankType(slot0.rankTypeConst_.ALL)

	slot0.initedAllRank_ = true
	slot0.m_allToggle.isOn = true
end

function slot0.Refresh(slot0)
	if MythicData:GetCurRankType() == slot0.rankTypeConst_.ALL then
		slot0.initedAllRank_ = true
		slot0.rankList = MythicData:GetRankList()
		slot0.curRank = MythicData:GetCurRank()
	else
		slot0.initedGuildRank_ = true
		slot0.rankList = MythicData:GetGuildRankList()
		slot0.curRank = MythicData:GetGuildCurRank()
		slot2 = GuildData:GetGuildInfo()
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot0.curRank then
		slot0:RefreshRank()
	else
		slot0:RefreshNone()
	end

	slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot2.portrait)
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot2 and slot2.icon_frame)
end

function slot0.RefreshRank(slot0)
	slot1 = slot0.curRank.score

	if slot0.curRank.rank == 0 then
		slot0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
		slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	elseif slot2 >= 1 and slot2 <= 100 then
		slot0.m_rank.text = slot2
		slot0.m_score.text = slot1
	else
		slot3 = 1
		slot3 = MythicData:GetCurRankType() == slot0.rankTypeConst_.ALL and (MythicData:GetRankTotalPeople() or 1) or guildInfo.memberCnt or 1
		slot0.m_rank.text = string.format("%.2f", slot2 / slot3 * 100) .. "%"
		slot0.m_score.text = slot1
	end
end

function slot0.RefreshNone(slot0)
	slot0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)

	slot0.refreshGuildHandler_ = nil
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		SetActive(slot0.m_guildToggleGo, false)
	else
		SetActive(slot0.m_guildToggleGo, true)
	end
end

return slot0
