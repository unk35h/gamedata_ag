slot0 = class("ActivityView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Sign/ActivityUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.selectIndex = -1
	slot0.allToggles = {
		ActivityDailySignToggle.New(),
		ActivityMonthCardToggle.New()
	}
	slot1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.allToggles, ActivitySevenSignToggle.New(slot6))
	end

	slot0.pages = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggleList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, SignToggleItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.toggles = {}

	for slot4, slot5 in pairs(slot0.allToggles) do
		if slot5:IsActivity() and slot5:GetLimitLevel() <= PlayerData:GetPlayerInfo().userLevel then
			table.insert(slot0.toggles, slot5)
		end
	end

	table.sort(slot0.toggles, function (slot0, slot1)
		return slot1:Order() < slot0:Order()
	end)
	slot0.toggleList:StartScroll(#slot0.toggles)

	if slot0.params_.check then
		slot0:CheckSign()

		slot0.params_.check = nil
	elseif slot0.params_.isBack then
		slot0:SetSelectPage(SignData:GetHistoryIndex() or 1)
	else
		slot0:SetSelectPage(1)
	end
end

function slot0.OnExit(slot0)
	SignData:SetHistoryIndex(slot0.selectIndex)

	slot0.selectIndex = -1

	if slot0.curPage then
		slot0.curPage:SetActive(false)

		slot0.curPage = nil
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.toggles[slot1])
	slot2:SetSelect(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.SetSelectPage))
end

function slot0.SetSelectPage(slot0, slot1)
	if slot1 == slot0.selectIndex then
		return
	end

	if PlayerData:GetPlayerInfo().userLevel < slot0.toggles[math.min(slot1, #slot0.toggles)]:GetLimitLevel() then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot3))

		return
	end

	slot0.selectIndex = slot1

	for slot8, slot9 in ipairs(slot0.toggleList:GetItemList()) do
		slot9:SetSelect(slot0.selectIndex)
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.curPage then
		slot0.curPage:SetActive(false)
	end

	if not slot0.pages[slot0.toggles[slot0.selectIndex]:GetName()] then
		slot0.pages[slot3] = slot2:UIClass().New(slot0, slot0.m_content, slot2:GetParams())
	end

	slot0.curPage = slot0.pages[slot3]

	slot0.curPage:SetActive(true)
end

function slot0.CheckSign(slot0)
	for slot4, slot5 in ipairs(slot0.toggles) do
		if slot5:Check() then
			slot0:SetSelectPage(slot4)
			slot0.curPage:AutoGetReward()

			return
		end
	end

	if not slot0.selectIndex or slot0.selectIndex == -1 then
		slot0:SetSelectPage(1)
	end
end

function slot0.OnSign(slot0, slot1, slot2)
	if slot0.curPage and slot0.curPage.OnSign then
		slot0.curPage:OnSign(slot1)
	end
end

function slot0.OnMonthCardDailyReward(slot0)
	if slot0.curPage and slot0.curPage.OnMonthCardDailyReward then
		slot0.curPage:OnMonthCardDailyReward()
	end

	slot0:CheckSign()
end

function slot0.Dispose(slot0)
	slot0.toggleList:Dispose()

	for slot4, slot5 in pairs(slot0.pages) do
		slot5:Dispose()
	end

	slot0.pages = {}

	uv0.super.Dispose(slot0)
end

return slot0
