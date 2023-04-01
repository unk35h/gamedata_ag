slot0 = class("GuildRecommendView", ReduxView)
slot1 = 10

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.recommendUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, GuildRecommendItem)
	slot0.recommendClickHandler_ = handler(slot0, slot0.ClickRecommendItem)

	manager.notify:RegistListener(GUILD_RECOMMEND_CLICK, slot0.recommendClickHandler_)

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnExit(slot0)
	slot0:StopRefreshStamptime()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(GUILD_RECOMMEND_CLICK, slot0.recommendClickHandler_)

	slot0.recommendClickHandler_ = nil

	if slot0.recommendUIList_ then
		slot0.recommendUIList_:Dispose()

		slot0.recommendUIList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSearch_, nil, function ()
		if uv0.inputField_.text == "" then
			return
		end

		if tonumber(uv0.inputField_.text) == nil or slot0 < 0 then
			uv0.inputField_.text = ""

			return ShowTips("ERROR_CLUB_NOT_EXIST")
		end

		GuildAction.SearchGuild(tonumber(uv0.inputField_.text), function (slot0)
			if isSuccess(slot0.result) then
				ShowTips(slot0.result)

				uv0.searchFlag_ = true
				uv0.inputField_.text = ""

				uv0:RefreshScroll()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonRefresh_, nil, function ()
		uv0:ClickRefreshBtn()
	end)
	slot0:AddBtnListener(slot0.btnRefresh1_, nil, function ()
		uv0:ClickRefreshBtn()
	end)
	slot0:AddBtnListener(slot0.buttonJoin_, nil, function ()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.JOIN_CLUB) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		slot0 = uv0

		GuildAction.GuildRequestJoin(slot0:GetItemData()[uv0.selectIndex_].id, function (slot0)
		end)
	end)
end

function slot0.ClickRefreshBtn(slot0)
	if manager.time:GetServerTime() < GuildData:GetRecommendRefreshStamptime() + uv0 then
		return
	end

	GuildAction.RequiredGuildRecommendList(function (slot0)
		if isSuccess(slot0.result) then
			GuildData:SetRecommendRefreshStamptime()

			uv0.searchFlag_ = false

			uv0:AddRefreshStamptime()
			uv0:RefreshScroll()
		else
			ShowTips(slot0.result)
		end
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:AddRefreshStamptime()
		slot0:RefreshScroll()
	else
		slot0:StopRefreshStamptime()
	end
end

function slot0.RefreshScroll(slot0)
	slot0.selectIndex_ = 1

	if #slot0:GetItemData() <= 0 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end

	slot0.recommendUIList_:StartScroll(#slot1, slot0.selectIndex_)

	if #slot1 <= 0 then
		SetActive(slot0.goInfoPanel_, false)
	else
		SetActive(slot0.goInfoPanel_, true)
	end

	slot0:RefreshInfo()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0:GetItemData()[slot1], slot1 == slot0.selectIndex_)
end

function slot0.ClickRecommendItem(slot0, slot1)
	slot0.selectIndex_ = slot1

	slot0:RefreshInfo()
end

function slot0.RefreshInfo(slot0)
	if slot0:GetItemData()[slot0.selectIndex_] == nil then
		return
	end

	slot0.textName_.text = slot2.name
	slot0.textMember_.text = string.format("%s/%s", slot2.member, slot2.maxMemberCnt)
	slot0.textLevel_.text = slot2.level
	slot0.textContribute_.text = slot2.contribute
	slot0.textID_.text = slot2.id
	slot0.textNotice_.text = slot2.notice
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot2.icon].icon_bg)
end

function slot0.GetItemData(slot0)
	if slot0.searchFlag_ then
		return GuildData:GetSearchList()
	else
		return GuildData:GetRecommendList()
	end
end

function slot0.AddRefreshStamptime(slot0)
	slot0:RefreshCDText()
	slot0:StopRefreshStamptime()

	slot0.refreshTimer_ = Timer.New(function ()
		uv0:RefreshCDText()
	end, 1, -1)

	slot0.refreshTimer_:Start()
end

function slot0.RefreshCDText(slot0)
	slot2 = GetTips("CLUB_REFRES_TEXT")

	if GuildData:GetRecommendRefreshStamptime() + uv0 - manager.time:GetServerTime() > 0 then
		slot0.textRefresh_.text = string.format("%s(%sS)", slot2, slot3)
		slot0.textRefresh1_.text = string.format("%s(%sS)", slot2, slot3)
	else
		slot0:StopRefreshStamptime()

		slot0.textRefresh_.text = slot2
		slot0.textRefresh1_.text = slot2
	end
end

function slot0.StopRefreshStamptime(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

return slot0
