slot0 = class("TipsLongItemView")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = Object.Instantiate(slot2, slot3.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()

	slot0.isFree_ = false
end

function slot0.InitUI(slot0)
	slot0.text_ = slot0.transform_:Find("Text"):GetComponent("Text")
end

function slot0.IsFree(slot0)
	return slot0.isFree_
end

function slot0.SetFree(slot0, slot1)
	slot0.isFree_ = slot1
end

function slot0.RefreshUI(slot0, slot1)
	slot0:SetFree(false)

	slot0.text_.text = slot1

	SetActive(slot0.gameObject_, true)
	slot0.transform_:SetAsLastSibling()

	slot0.transform_.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(slot0.gameObject_, Vector3(1.5, 0.1, 1), 0.1)
	LeanTween.scale(slot0.gameObject_, Vector3.one, 0.1):setDelay(0.1)
	slot0:EndDisplay()
end

function slot0.EndDisplay(slot0)
	slot1 = LeanTween.scale(slot0.gameObject_, Vector3(1, 0.1, 1), 0.1)

	slot1:setDelay(1)

	slot1 = nil
	slot2 = LeanTween.scale(slot0.gameObject_, Vector3.zero, 0.1)
	slot2 = slot2:setDelay(1.1)
	slot1 = slot2:setOnComplete(System.Action(function ()
		uv0:FinishAction()
		uv1:setOnComplete(nil)
	end))
end

function slot0.FinishAction(slot0)
	slot0.data_:Finish()
	SetActive(slot0.gameObject_, false)
end

function slot0.FastFinish(slot0)
	LeanTween.cancel(slot0.gameObject_)
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
