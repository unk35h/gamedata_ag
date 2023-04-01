slot1 = class("RewardPoolNoobItem", import("game.views.common.RewardPoolItem"))

function slot1.GetParentItemPath(slot0)
	return "UI/Activity/NewbieCommonItem"
end

function slot1.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = nil
	slot0.parentGo_ = Object.Instantiate((slot1 ~= nil or Asset.Load(slot0:GetParentItemPath())) and slot1, slot2.transform)

	slot0:BindCfgUI(slot0.parentGo_)
	uv0.super.OnCtor(slot0, slot0.parentGo_, slot3, slot4, slot5, slot6)
end

function slot1.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.parentGo_.transform)
end

function slot1.SetData(slot0, slot1, slot2)
	uv0.super.SetData(slot0, slot1, slot2)
	slot0:RefreshText(slot1[2])
end

function slot1.RefreshText(slot0, slot1)
	slot0:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	slot0.commonItem_:HideNum()

	slot0.cntText_.text = slot1
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

function slot1.SetTextColor(slot0, slot1)
	slot0.cntText_.color = slot1
end

return slot1
