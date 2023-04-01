FactorySkinTrialRewardItem = import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem")
slot0 = class("DreamSkinTrialRewardItem", ReduxView)

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.popType_ = slot2
	slot4 = slot0.commonItem_

	slot4:RefreshData(formatReward(slot1))

	slot4 = slot0.commonItem_

	slot4:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)

	if slot0.receivedControllerList_ == nil then
		slot0.receivedControllerList_ = ControllerUtil.GetController(slot0.commonItem_.transform_, "received")
	end

	if SkinTrialData:IsCompleted(slot3) then
		slot0.receivedControllerList_:SetSelectedState("true")
	else
		slot0.receivedControllerList_:SetSelectedState("false")
	end

	slot0.commonItem_:Show(true)
end

return slot0
