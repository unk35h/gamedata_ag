slot0 = class("BulletinRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("bulletinID", slot2)
	slot0:SetViewProp("contentIndex", slot3)
	slot0:InitUI()

	slot0.rewardItemList_ = {}

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4 = #slot0.rewardItemList_, 1, -1 do
		slot0.rewardItemList_[slot4]:Dispose()

		slot0.rewardItemList_[slot4] = nil
	end

	slot0.rewardItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.item_ = slot0:FindGo("CommonItem")
end

function slot0.RefreshUI(slot0)
	slot6 = slot0
	slot5 = slot0.GetViewProp

	for slot5, slot6 in ipairs(slot0:GetContent(slot0.GetViewProp(slot6, "bulletinID"), slot5(slot0, "contentIndex")).rewardList) do
		if slot0.rewardItemList_[slot5] == nil then
			slot0.rewardItemList_[slot5] = RewardItem.New(slot0.item_, slot0.gameObject_)

			slot0.rewardItemList_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItemList_[slot5]:SetData(slot6)
	end

	SetActive(slot0.gameObject_, true)
end

function slot0.GetContent(slot0, slot1, slot2)
	for slot6, slot7 in pairs(BulletinData.GetBulletinPageList()) do
		if slot7.id == slot1 then
			return slot7.content[slot2]
		end
	end
end

return slot0
