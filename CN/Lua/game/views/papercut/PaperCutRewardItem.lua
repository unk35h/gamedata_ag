slot0 = class("PaperCutRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemListGo_, CommonItem)
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.activityID_ = ActivityPointRewardCfg[slot1].activity_id

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutAction.RequireReceive(uv0.taskID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivityPointRewardCfg[uv0.taskID_].reward_item_list)
				PaperCutData:SetReceivedList(uv0.activityID_, uv0.taskID_)
				uv0:RefreshState()

				if uv0.onReceived_ ~= nil then
					uv0.onReceived_()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.descText_.text = string.format(GetTips("ACTIVITY_CUT_POINT_REWARD"), PaperCutCfg[slot0.activityID_].name, ActivityPointRewardCfg[slot0.taskID_].need)

	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshState(slot0)
	slot4 = table.keyof(PaperCutData:GetReceivedList(slot0.activityID_), slot0.taskID_) ~= nil

	if not (ActivityPointRewardCfg[slot0.taskID_].need <= PaperCutData:GetScore(slot0.activityID_)) then
		slot0.rewardState_:SetSelectedState("uncompleted")
	elseif not slot4 then
		slot0.rewardState_:SetSelectedState("unreceived")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.taskID_].reward_item_list

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	slot0.onReceived_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetReveivedHandler(slot0, slot1)
	slot0.onReceived_ = slot1
end

return slot0
