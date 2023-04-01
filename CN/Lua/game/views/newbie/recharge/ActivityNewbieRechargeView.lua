slot0 = class("ActivityNewbieRechargeView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot6 = slot1.transform
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieRechargeUI"), slot6)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.rechargeItemList_ = {}
	slot5 = ActivityNewbieData
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetRechargeTemplate(slot7)) do
		slot0.rechargeItemList_[slot6] = ActivityNewbieRechargeItem.New(slot0[string.format("button%s_", slot6)], slot6)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.rechargeItemList_) do
		slot5:Dispose()
	end

	slot0.rechargeItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		for slot5, slot6 in pairs(slot0.rechargeItemList_) do
			slot6:RefreshUI()
		end
	end
end

return slot0
