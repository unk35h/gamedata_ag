slot1 = class("SkinTrialSelect113", import("game.views.skinTrialActivity.Factory.SkinTrialSelect110"))

function slot1.UIName(slot0)
	return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot1.GetRewardItem(slot0)
	return CommonItem
end

function slot1.GetCommonItem(slot0, slot1)
	return slot1
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot4 = slot0:GetCommonItem(slot2)

	slot4:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot4:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)

	if slot0.receivedControllerList_[slot1] == nil then
		slot0.receivedControllerList_[slot1] = ControllerUtil.GetController(slot4.transform_, "received")
	end

	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.receivedControllerList_[slot1]:SetSelectedState("true")
	end
end

return slot1
