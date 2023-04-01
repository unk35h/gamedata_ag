RewardPoolItem = import("game.views.common.RewardPoolItem")
slot0 = class("HeroTrialRewardItem_2_0", RewardPoolItem)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.parentGo_ = Object.Instantiate(slot2, slot1.transform, slot4)

	slot0:BindCfgUI(slot0.parentGo_)
	uv0.super.OnCtor(slot0, slot1, slot3, slot4, slot5, slot6)
	slot0.receivedMarkGo_.transform:SetAsLastSibling()
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

function slot0.RefreshReceive(slot0, slot1)
	SetActive(slot0.receivedMarkGo_, slot1)
end

return slot0
