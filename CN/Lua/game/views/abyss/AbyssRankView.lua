slot0 = class("AbyssRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AbyssUI/AbyssRankUI"
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

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveGuildController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveGuild")
	slot0.rankList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AbyssRankItemView)
	slot0.toggleList_ = {
		slot0.clubToggle_,
		slot0.allToggle_
	}
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.dataList_[slot1], slot0.curPage_ == 1)
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggleList_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)
			end
		end)
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_RANK_UPDATE, function ()
		if not uv0.isInit_ then
			uv0:SwitchPage(2)

			uv0.isInit_ = true
			uv0.toggleList_[2].isOn = true
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.SwitchPage(slot0, slot1)
	slot0.curPage_ = slot1
	slot0.dataList_ = slot0:GetListFromIndex(slot1)

	slot0:UpdateView()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.isInit_ = false

	slot0:AddEventListeners()
	AbyssAction.GetRankData(1, 100)

	slot1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		slot1 = false
	end

	slot0.haveGuildController_:SetSelectedState(slot1 and "true" or "false")

	if slot1 then
		AbyssAction.GetGuildRankInfo()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.GetListFromIndex(slot0, slot1)
	if slot1 == 1 then
		return AbyssData:GetGuildRankList()
	else
		return AbyssData:GetRankList()
	end
end

function slot0.UpdateView(slot0)
	slot0.rankList_:StartScroll(#slot0.dataList_)

	slot0.myHeadIcon_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().portrait)
	slot0.myHeadFrame_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().icon_frame)

	if AbyssData:GetMyRankData(slot0.curPage_ == 1) == nil or slot1.rank == 0 then
		slot0.myRankLabel_.text = GetTips("MATRIX_RANK_NO_RANK")
		slot0.myScoreLabel_.text = GetTips("MATRIX_RANK_NO_INFO")
	elseif slot1.rank >= 1 and slot1.rank <= 100 then
		slot0.myRankLabel_.text = slot1.rank
		slot0.myScoreLabel_.text = slot1.score
	else
		slot0.myRankLabel_.text = string.format("%.2f", slot1.rank / AbyssData:GetRankTotal() * 100) .. "%"
		slot0.myScoreLabel_.text = slot1.score
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.rankList_ then
		slot0.rankList_:Dispose()

		slot0.rankList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
