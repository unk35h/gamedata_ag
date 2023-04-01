RewardPoolItem = import("game.views.common.RewardPoolItem")
slot0 = class("RewardPoolFactoryItem", RewardPoolItem)

function slot0.GetParentItemPath(slot0)
	return "UI/MardukUI/MardukCommonItem"
end

function slot0.GetItemPath(slot0)
	return "UI/Common/CommonItem"
end

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.parentGo_ = Object.Instantiate(Asset.Load(slot0:GetParentItemPath()), slot1.transform)

	slot0:BindCfgUI(slot0.parentGo_)
	uv0.super.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5)

	if slot3 then
		slot0.commonItem_:SetScale(Vector3(0.55, 0.569, 1))
	end
end

function slot0.SetParent(slot0)
	slot0.commonItemGo_.transform:SetParent(slot0.parentGo_.transform)
end

function slot0.SetData(slot0, slot1, slot2)
	uv0.super.SetData(slot0, slot1, slot2)
	slot0:RefreshText(slot1[2])
end

function slot0.RefreshText(slot0, slot1)
	slot0:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	slot0.commonItem_:HideNum()

	slot0.cntText_.text = slot1
end

function slot0.Dispose(slot0)
	slot0.commonItem_:ResetTransform()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.parentGo_)

	slot0.parentGo_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.parentGo_, slot1)
	uv0.super.Show(slot0, slot1)
end

return slot0
