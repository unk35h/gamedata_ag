slot0 = class("ActivityNoobFirstRechargeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1.gameObject
	slot0.transform_ = slot1
	slot0.contentTrans_ = slot1
	slot0.contentViewList_ = {}
	slot0.type_ = slot2
	slot0.contentClasss_ = {
		ActivityNoobFirstRechargeView_1,
		ActivityNoobFirstRechargeView_2
	}
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.contentViewList_) do
		slot5:Dispose()
	end

	slot0.contentViewList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	if slot0.curView_ then
		slot0.curView_:SetActive(slot1)
	end
end

function slot0.SetType(slot0, slot1)
	slot0.type_ = slot1
end

function slot0.SetData(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot0.curView_ then
		slot0.curView_:SetActive(false)
	end

	if not slot0.contentViewList_[slot1] then
		slot0.contentViewList_[slot1] = slot0.contentClasss_[slot1].New(slot0.contentTrans_, slot0.type_)
	end

	slot0.curView_ = slot0.contentViewList_[slot1]

	slot0.curView_:SetData(slot1)
	slot0.curView_:SetActive(true)
end

return slot0
