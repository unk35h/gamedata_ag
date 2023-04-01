slot1 = class("RegressionBPRewardItem", import("game.views.common.RewardPoolItem"))

function slot1.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.parentGo_ = Object.Instantiate(slot2, slot1.transform)

	slot0:BindCfgUI(slot0.parentGo_)

	slot0.isSmall_ = slot3
	slot0.gameObject_ = slot0.parentGo_
	slot0.transform_ = slot0.parentGo_.transform

	SetActive(slot0.gameObject_, true)

	slot0.commonItemGo_ = manager.objectPool:Get(slot0:GetItemPath())
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)

	slot0:SetParent()
	slot0.commonItem_:ResetTransform()

	slot0.clickCallback_ = slot5
	slot0.popType_ = slot4 or POP_ITEM

	slot0:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)

	if slot0.receivedMarkGo_ then
		slot0.receivedMarkGo_.transform:SetAsLastSibling()
	end

	slot0.parentGo_.transform.localScale = Vector3.New(0.7, 0.7, 0.7)
	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot1.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.parentGo_.transform)
end

function slot1.SetData(slot0, slot1, slot2, slot3)
	slot4 = slot0.commonItem_

	slot4:RefreshData(formatReward(slot1))

	slot4 = slot0.commonItem_

	slot4:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if not uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)

	if slot2 ~= false then
		slot2 = slot2 or slot0.commonItemGo_.activeSelf == false
	end

	slot0:Show(true)

	if slot2 then
		slot0.commonItem_:UpdateAnimator()
	else
		slot0.commonItem_:StopAnimator()
	end

	if slot3 == nil or slot3 >= 1 then
		SetActive(slot0.lockGo_, false)
	else
		SetActive(slot0.lockGo_, true)
	end

	slot0.commonItem_:HideNum()

	slot0.numText_.text = slot1[2]
end

function slot1.Dispose(slot0)
	slot0.commonItem_:ResetTransform()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.parentGo_)

	slot0.parentGo_ = nil
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.parentGo_, slot1)
	uv0.super.Show(slot0, slot1)
end

function slot1.RefreshStatus(slot0, slot1)
	slot0.statusController_:SetSelectedIndex(slot1)
end

return slot1
