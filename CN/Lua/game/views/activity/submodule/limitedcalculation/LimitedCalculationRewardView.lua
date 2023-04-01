slot0 = class("LimitedCalculationRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerIntegralRewardPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, LimitedCalculationRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.getAllBtn_, nil, function ()
		LimitedCalculationAction:GetAllRewardAction(uv0.activityID_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshScore()
	slot0:RefreshList()
end

function slot0.RefreshScore(slot0)
	slot0.score_ = LimitedCalculationData:GetScore(slot0.activityID_)
	slot0.title_.text = slot0.score_
end

function slot0.RefreshList(slot0)
	slot0.list_ = {}
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = nil

	for slot9, slot10 in ipairs(LimitedCalculationData:GetRewardList(slot0.activityID_)) do
		slot4 = ActivityPointRewardCfg[slot10.id].need

		if slot10.complete_flag <= 0 then
			if slot4 <= slot0.score_ then
				table.insert(slot1, slot10)
			else
				table.insert(slot2, slot10)
			end
		else
			table.insert(slot3, slot10)
		end
	end

	function slot6(slot0, slot1)
		return slot0.id < slot1.id
	end

	table.sort(slot1, slot6)
	table.sort(slot2, slot6)
	table.sort(slot3, slot6)

	if slot1[1] == nil then
		SetActive(slot0.getAllBtn_.gameObject, false)
	else
		SetActive(slot0.getAllBtn_.gameObject, true)
	end

	table.insertto(slot0.list_, slot1)
	table.insertto(slot0.list_, slot2)
	table.insertto(slot0.list_, slot3)
	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnReceivePointReward(slot0)
	slot0:RefreshList()
end

function slot0.OnExit(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
