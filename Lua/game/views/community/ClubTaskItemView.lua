slot0 = class("ClubTaskItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:TryToSubmitTask(uv0.taskID_)
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(uv0.taskCfg_.source)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.info_ = TaskData:GetTask(slot0.taskID_)
	slot0.taskCfg_ = AssignmentCfg[slot0.taskID_]
	slot0.title_.text = slot0.taskCfg_.desc

	slot0:RefreshType()
	slot0:RefreshProgress()
	slot0:RefreshReward()
end

function slot0.RefreshType(slot0)
	if slot0.info_ == nil or slot0.info_.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("finish")
	elseif slot0.info_.progress < slot0.taskCfg_.need then
		slot0.stateCon_:SetSelectedState("incomplete")
	elseif slot0.taskCfg_.need <= slot0.info_.progress then
		slot0.stateCon_:SetSelectedState("complete")
	else
		print("未确定的状态")
	end
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.taskCfg_.reward) do
		if slot6[1] == 52003 then
			break
		end

		if slot0.rewardItems_[slot5] == nil then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardTemplate_, slot0.rewardParent_, true)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	slot0.progressBar_.fillAmount = slot0.info_.progress / slot0.taskCfg_.need
	slot0.progressTxt_.text = string.format("%s/%s", slot0.taskCfg_.need < slot0.info_.progress and slot0.taskCfg_.need or slot0.info_.progress, slot0.taskCfg_.need)
end

function slot0.OnExit(slot0)
	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:Dispose()

		slot0.rewardItems_[slot4] = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
