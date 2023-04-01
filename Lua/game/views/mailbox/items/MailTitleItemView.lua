slot0 = class("MailTitleItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onResize_ = slot2

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	if slot0.time_ then
		slot0.timt_:Stop()

		slot0.time_ = nil
	end

	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.titleText_ = slot0:FindCom(typeof(Text), "titleText")
	slot0.timeText_ = slot0:FindCom(typeof(Text), "time/text")
	slot0.blueImg_ = slot0:FindCom(typeof(RectTransform), "blueImg")
	slot0.titleTrs_ = slot0:FindCom(typeof(RectTransform), "titleText")
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = slot0.data_.text

	slot0.titleText_:GetComponent(typeof(ContentSizeFitter)):Validate()
	SetActive(slot0.gameObject_, true)

	if slot0.onResize_ ~= nil then
		slot0.onResize_()
	end
end

function slot0.GetHeight(slot0)
	return 1
end

return slot0
