slot0 = class("AlphaRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupPhaseActivityUI"
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

	slot0.rewardList_ = {}
	slot0.itemPool_ = Pool.New(slot0.rewardItemTemplate_, slot0.rewardItemParent_, 0)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.rewardItemScroll_, AlphaRewardItem)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	for slot4 = 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:OnEnter()
	end

	slot0.generalTaskList_ = slot0:GetTaskList()

	slot0.scrollHelper_:StartScroll(#slot0.generalTaskList_)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshReward(slot0.generalTaskList_[slot1])
end

function slot0.GetTaskList(slot0)
	slot1 = {}
	slot5 = TaskConst.TASK_TYPE.ALPHA

	for slot5, slot6 in pairs(AssignmentCfg.get_id_list_by_type[slot5]) do
		if not slot1[AssignmentCfg[slot6].phase] and AssignmentCfg[slot6].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[slot6].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
			slot1[slot7] = slot6
		end
	end

	return slot1
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardList_ do
		slot0.rewardList_[slot4]:Dispose()

		slot0.rewardList_[slot4] = nil
	end

	slot0.rewardList_ = nil

	slot0.itemPool_:Dispose()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
