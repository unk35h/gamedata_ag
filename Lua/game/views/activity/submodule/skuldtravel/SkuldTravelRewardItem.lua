slot0 = class("SkuldTravelRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listgo_, CommonItem)
	slot0.statucontroller_ = ControllerUtil.GetController(slot0.transform_, "reward")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardlist_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.rewardlist_[uv1])
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.statu_ == 1 then
			SkuldTravelAction:GetTravelReward(uv0.rewardid_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.rewardid_ = slot1
	slot0.desctext_.text = SkuldTravelData:GetTaskTextByTaskId(slot0.rewardid_)
	slot0.statu_ = SkuldTravelData:GetTaskStatuByTaskId(slot0.rewardid_)

	slot0.statucontroller_:SetSelectedState(SkuldTravelData:GetTaskControllerStatu(slot0.statu_))

	slot0.rewardlist_ = TravelSkuldRewardCfg[slot0.rewardid_].reward_item_list

	slot0.list_:StartScroll(#slot0.rewardlist_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
