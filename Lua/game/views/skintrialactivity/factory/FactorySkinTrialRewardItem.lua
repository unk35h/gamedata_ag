slot0 = class("FactorySkinTrialRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.GetCommonItem(slot0)
	return slot0.commonItem_
end

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
	slot0:RefreshText()
end

function slot0.RefreshText(slot0)
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	slot0.commonItem_:HideNum()

	slot0.cntText_.text = slot0.data_[2]
end

return slot0
