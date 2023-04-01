slot0 = class("TaskDemonChallengeItemView", ReduxView)
slot1 = import("game.tools.JumpTools")
slot2 = 0
slot3 = 1
slot4 = 2

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.popType_ = POP_ITEM

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemListGo_, CommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.receiveHandler = handler(slot0, slot0.OnReceiveReward)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.rewardCfg_ = getRewardFromDropCfg(slot1, true)
	slot0.rewardIndex_ = slot2
	slot0.levelIndex_ = slot3

	slot0:GetRewardState()
	slot0:RefreshUI()
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.rewardState_ == uv1 then
			DemonChallengeAction.RequireReceive(DemonChallengeData:GetStageId(uv0.levelIndex_, uv0.rewardIndex_), uv0.receiveHandler)
		end
	end)
end

function slot0.OnReceiveReward(slot0, slot1)
	slot2 = slot0.rewardState_

	if isSuccess(slot1.result) then
		DemonChallengeData:SetReceiveList(slot0.rewardIndex_, slot0.levelIndex_)
		slot0:GetRewardState()
		getReward(slot0.rewardCfg_)

		if slot2 == uv0 and slot0.rewardState_ == uv1 then
			slot0:RefreshState()
			manager.notify:Invoke(DEMON_CHALLENGE_RECEIVE_REWARD)
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.GetRewardState(slot0)
	slot0.completed_ = DemonChallengeData:IsCompleted(slot0.levelIndex_, slot0.rewardIndex_)
	slot2 = nil
	slot0.rewardState_ = not slot0.completed_ and uv0 or table.keyof(DemonChallengeData:GetReceiveList(slot0.levelIndex_), slot0.rewardIndex_) and uv1 or uv2
end

function slot0.RefreshUI(slot0)
	slot2 = ""
	slot0.Desctext_.text = (slot0.rewardIndex_ ~= 1 or GetTips("CLEAR_NORMAL_DIFFICULTY")) and (slot1 ~= 2 or GetTips("CLEAR_DIFFICULTY")) and GetTips("CLEAR_EXTREME_DIFFICULTY")
end

function slot0.RefreshState(slot0)
	slot0.controller_:SetSelectedState(tostring(slot0.rewardState_))
end

function slot0.RefreshItem(slot0)
	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot2:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)
	slot2:Show(true)
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
