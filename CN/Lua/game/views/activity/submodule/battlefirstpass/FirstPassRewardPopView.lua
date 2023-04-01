slot0 = class("FirstPassRewardPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/Pop/HellaQuestEewardsPop"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, FirstPassRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.activityID_, slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0:RefreshList()
end

function slot0.RefreshList(slot0)
	slot2 = BattleFirstPassData:GetBattleList(slot0.activityID_)

	if BattleFirstPassData:GetBattleFirstPassActivityData(slot0.activityID_).battleInfo == nil then
		return
	end

	slot3 = {}
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = nil

	for slot11, slot12 in ipairs(slot2) do
		if slot1[slot12].battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.UNFINISHED then
			table.insert(slot4, slot7)
		elseif slot7.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.SUCCESS then
			table.insert(slot5, slot7)
		elseif slot7.battleState == ActivityConst.BATTLE_FIRST_PASS_STATE.REWARDED then
			table.insert(slot6, slot7)
		end
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0.battleID < slot1.battleID
	end)
	table.sort(slot5, function (slot0, slot1)
		return slot0.battleID < slot1.battleID
	end)
	table.sort(slot6, function (slot0, slot1)
		return slot0.battleID < slot1.battleID
	end)
	table.insertto(slot3, slot5)
	table.insertto(slot3, slot4)
	table.insertto(slot3, slot6)

	slot0.list_ = slot3

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnFirstReward(slot0)
	slot0:RefreshList()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
