slot1 = class("CapsuleToysRewardItem", import("game.views.common.RewardPoolItem"))

function slot1.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.parentGo_ = Object.Instantiate(slot2, slot1.transform, false)

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

	slot0:ShowFloor(ItemConst.ITEM_FLOOR.LONG)

	slot0.parentGo_.transform.localScale = Vector3.one

	if slot0.soldOutGo_ then
		slot0.soldOutGo_.transform:SetAsLastSibling()
	end
end

function slot1.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.parentGo_.transform)
end

function slot1.SetData(slot0, slot1)
	slot0.rewardID_ = slot1
	slot2 = RegressionCapsuleToysCfg[slot1]
	slot4 = 0

	if RegressionData:GetCapsuleToysStatus()[slot1] then
		slot4 = slot3.remain_num
	end

	slot0.progressText_.text = string.format(GetTips("VERIFY_ASSETS_PROCESSING_RATE"), slot4, slot2.total)

	if slot0.soldOutGo_ then
		SetActive(slot0.soldOutGo_, slot4 == 0)
	end

	uv0.super.SetData(slot0, RegressionCapsuleToysCfg[slot0.rewardID_].reward)
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

return slot1
