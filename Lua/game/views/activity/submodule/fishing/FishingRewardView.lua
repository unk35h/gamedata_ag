slot0 = class("FishingRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingRewardUI"
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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, FishingRewardItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetId(slot0.rewardIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FISHING_SCORE_REWARD_CHANGE, function ()
		uv0:SortData()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(RARE_FISH_CHANGE, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.rewardIdList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]

	slot0:SortData()
	slot0:UpdateView()
end

function slot0.SortData(slot0)
	slot1 = 0

	if FishingData:GetActivityData() then
		slot1 = slot2.score
	end

	slot3 = FishingData
	slot3 = slot3:GetActivityData().received_award_list

	table.sort(slot0.rewardIdList_, function (slot0, slot1)
		slot5 = table.indexof(uv0, ActivityPointRewardCfg[slot1].id) or 0

		if ((table.indexof(uv0, ActivityPointRewardCfg[slot0].id) or 0) == 0 or slot5 == 0) and slot4 ~= slot5 then
			return slot4 < slot5
		end

		if (slot2.need <= uv1 and 1 or 0) ~= (slot3.need <= uv1 and 1 or 0) then
			return slot7 < slot6
		end

		return slot0 < slot1
	end)
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.rewardIdList_)

	slot1 = 0

	if FishingData:GetActivityData() then
		slot1 = slot2.score
	end

	slot0.currentLabel_.text = slot1
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
