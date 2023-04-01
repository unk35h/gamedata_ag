slot0 = class("RewardPoolItem", ReduxView)

function slot0.GetItemPath(slot0)
	if slot0.isSmall_ then
		return "UI/Common/CommonItemSmall"
	else
		return "UI/Common/CommonItem"
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.isSmall_ = slot3
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)

	slot0.commonItemGo_ = manager.objectPool:Get(slot0:GetItemPath())
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)

	slot0:SetParent()
	slot0.commonItem_:ResetTransform()

	slot0.clickCallback_ = slot5
	slot0.popType_ = slot4 or POP_ITEM

	slot0:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
	slot0:SetData(slot2, true)
end

function slot0.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.transform_)
end

function slot0.SetData(slot0, slot1, slot2)
	slot3 = slot0.commonItem_

	slot3:RefreshData(formatReward(slot1))

	slot3 = slot0.commonItem_

	slot3:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
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
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.commonItemGo_, slot1)
end

function slot0.HideNum(slot0)
	slot0.commonItem_:HideNum()
	slot0.commonItem_:HideServantTxt()
end

function slot0.ShowFloor(slot0, slot1)
	slot0.commonItem_:ShowFloor(slot1)
end

function slot0.HideServantTxt(slot0)
	slot0.commonItem_:HideServantTxt()
end

function slot0.Dispose(slot0)
	slot0.commonItem_.mainAni_.speed = 1

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
	slot5 = true
	slot1 = slot0.commonItemGo_:GetComponentsInChildren(typeof(Animator), slot5)
	slot6 = slot1

	for slot5, slot6 in pairs(slot1.ToTable(slot6)) do
		slot6.enabled = true
	end

	slot6 = true
	slot2 = slot0.commonItemGo_:GetComponentsInChildren(typeof(CanvasGroup), slot6)
	slot7 = slot2

	for slot6, slot7 in pairs(slot2.ToTable(slot7)) do
		slot7.alpha = 1
	end

	manager.objectPool:Return(slot0:GetItemPath(), slot0.commonItemGo_)
	uv0.super.Dispose(slot0)
end

function slot0.SetSiblingIndex(slot0, slot1)
	slot0.commonItem_:SetIndex(slot1)
end

return slot0
