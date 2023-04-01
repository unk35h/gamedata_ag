slot0 = class("ActivityNoobSignView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.contentTrans_ = slot1
	slot0.contenViewList_ = {}
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.contenViewList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	if slot0.curView_ then
		slot0.curView_:SetActive(slot1)
	end
end

function slot0.SetData(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot0.curView_ then
		slot0.curView_:SetActive(false)
	end

	if not slot0.contenViewList_[slot1] then
		slot0.contenViewList_[slot1] = ActivityNoobSignContentView.New(slot0.contentTrans_, slot1)
	end

	slot0.curView_ = slot0.contenViewList_[slot1]

	slot0.curView_:SetData(slot1)
	slot0.curView_:SetActive(true)
end

return slot0
