slot0 = class("MythicFinalRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rewardItemList_ = {}

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.selftrans_, "name")

	slot0:AddListeners()
end

function slot0.Init(slot0, slot1)
	slot0.index_ = MythicData:GetRealIndex(slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receivebtn_, nil, function ()
		if MythicData:GetFinalIsReward() == 0 then
			ShowMessageBox({
				content = GetTips("MYTHIC_REWARD_LOACK_DIFFICULTY"),
				OkCallback = function ()
					MythicAction:GetFinalReward(uv0.index_)
				end
			})
		else
			MythicAction:GetFinalReward(uv0.index_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0:Init(slot1)
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshData(slot0)
	slot0.rewradCfg_ = MythicFinalCfg[slot0.index_].reward_list
end

function slot0.RefreshUI(slot0)
	slot0.itemtext_.text = string.format(GetTips("MYTHIC_FINAL_REWARD_TIPS"), slot0.index_)
end

function slot0.RefreshState(slot0)
	if MythicData:GetPassHotLevel() < slot0.index_ then
		slot0.controller_:SetSelectedState("false")
	elseif MythicData:GetFinalRewardStateByHotLevel(slot0.index_) then
		slot0.controller_:SetSelectedState("get")
	else
		slot0.controller_:SetSelectedState("true")
	end
end

function slot0.RefreshItem(slot0)
	for slot5, slot6 in pairs(slot0.rewradCfg_) do
		if slot5 > 6 then
			return
		end

		if slot0.rewardItemList_[slot5] then
			slot0.rewardItemList_[slot5]:SetData(slot6)
		else
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.rewardPanel_, slot6, true)
		end
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot5]:Show(false)
	end
end

return slot0
