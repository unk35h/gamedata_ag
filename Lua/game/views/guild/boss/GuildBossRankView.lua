slot0 = class("GuildBossRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.myRank_ = 0
	slot0.myRankData_ = nil

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, GuildBossRankItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rankDataList_[slot1])
end

function slot0.InitData(slot0)
	slot1 = GuildData
	slot0.rankDataList_ = slot1:GetRankList()

	function slot4(slot0, slot1)
		if slot0.score ~= slot1.score then
			return slot1.score < slot0.score
		end

		if slot0.timestamp ~= slot1.timestamp then
			return slot0.timestamp < slot1.timestamp
		end

		return slot0.id < slot1.id
	end

	table.sort(slot0.rankDataList_, slot4)

	for slot4, slot5 in ipairs(slot0.rankDataList_) do
		if slot5.id == tostring(PlayerData:GetPlayerInfo().userID) then
			slot0.myRankData_ = slot5
			slot0.myRank_ = slot4

			break
		end
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_RANK_UPDATE, function ()
		uv0:InitData()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	GuildAction.GuildBossGetRankInfo(GuildData:GetGuildInfo().id)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.rankDataList_)

	if slot0.myRank_ > 0 then
		slot0.m_rank.text = slot0.myRank_
	else
		slot0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	end

	if slot0.myRankData_ ~= nil then
		slot0.m_score.text = slot0.myRankData_.score
	else
		slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
	end

	slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().portrait)
	slot0.m_frame.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().icon_frame)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
