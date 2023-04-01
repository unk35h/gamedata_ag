slot0 = class("MatrixRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Main/MatrixRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rankTypeController = ControllerUtil.GetController(slot0.m_rankTypeController, "toggle")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixRankItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_guildBtn, nil, function ()
		uv0:SelectRankType(MatrixConst.MatirxRankType.GUILD)
	end)
	slot0:AddBtnListener(slot0.m_allBtn, nil, function ()
		uv0:SelectRankType(MatrixConst.MatirxRankType.ALL)
	end)
end

function slot0.SelectRankType(slot0, slot1)
	if slot0.rankType == slot1 then
		return
	end

	if slot0.initCache[slot1] and slot0.initCache[slot1][slot0.subType] then
		slot0:Refresh(slot1, slot0.subType)
	elseif slot1 == MatrixConst.MatirxRankType.GUILD then
		MatrixAction.QueryGuildRankList(slot0.subType)
	else
		MatrixAction.QueryRankList(slot0.subType)
	end
end

function slot0.SelectSubType(slot0, slot1)
	if slot1 == slot0.subType then
		return
	end

	if slot0.initCache[slot0.rankType] and slot0.initCache[slot0.rankType][slot1] then
		slot0:Refresh(slot0.rankType, slot1)
	elseif slot0.rankType == MatrixConst.MatirxRankType.GUILD then
		MatrixAction.QueryGuildRankList(slot1)
	else
		MatrixAction.QueryRankList(slot1)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnUpdate(slot0)
	slot0:Refresh(slot0.params_.type, slot0.params_.subType)
end

function slot0.OnEnter(slot0)
	slot0.initCache = {}

	slot0:RefreshGuildRankGo()
	slot0:Refresh(slot0.params_.type, slot0.params_.subType)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.initCache[slot1] = slot0.initCache[slot1] or {}
	slot0.initCache[slot1][slot2] = true
	slot0.rankType = slot1
	slot0.subType = slot2

	if slot0.rankType == MatrixConst.MatirxRankType.ALL then
		slot0.rankList = MatrixData:GetRankList(slot0.subType)
		slot0.curRank = MatrixData:GetCurRank(slot0.subType)
	else
		slot0.rankList = MatrixData:GetGuildRankList(slot0.subType)
		slot0.curRank = MatrixData:GetGuildCurRank(slot0.subType)
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot0.curRank then
		slot0:RefreshRank()
	else
		slot0:RefreshNone()
	end

	slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot3.portrait)
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot3 and slot3.icon_frame)

	slot0.rankTypeController:SetSelectedIndex(slot0.rankType - 1)
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
		slot3 = slot0.rankType == MatrixConst.MatirxRankType.ALL and (MatrixData:GetRankTotalPeople(slot0.subType) or 1) or GuildData:GetGuildInfo().memberCnt or 1
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
		SetActive(slot0.m_guildGo, false)
	else
		SetActive(slot0.m_guildGo, true)
	end
end

return slot0
