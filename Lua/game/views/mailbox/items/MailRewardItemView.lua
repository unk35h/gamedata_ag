slot0 = class("MailRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onResize_ = slot2

	slot0:InitUI()

	slot0.rewardItemList_ = {}
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

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.data_.reward_item) do
		if slot0.rewardItemList_[slot4] == nil then
			slot0.rewardItemList_[slot4] = RewardItem.New(slot0.item_, slot0.gameObject_)

			slot0.rewardItemList_[slot4]:UpdateCommonItemAni()
		end

		slot0.rewardItemList_[slot4]:SetData({
			slot5.id,
			slot5.num
		})
	end

	SetActive(slot0.gameObject_, true)

	if slot0.onResize_ ~= nil then
		slot0.onResize_()
	end
end

function slot0.GetHeight(slot0)
	return slot0.transform_.rect.height
end

return slot0
