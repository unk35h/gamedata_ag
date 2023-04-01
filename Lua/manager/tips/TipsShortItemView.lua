slot0 = class("TipsShortItemView")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = Object.Instantiate(slot2, slot3.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()

	slot0.isFree_ = false
end

function slot0.InitUI(slot0)
	slot0.text_ = slot0.transform_:Find("Text"):GetComponent("Text")
	slot0.levelImg_ = slot0.transform_:Find("levelImg"):GetComponent("Image")
	slot0.levelImgGo_ = slot0.transform_:Find("levelImg").gameObject
	slot0.levelText_ = slot0.transform_:Find("levelText"):GetComponent("Text")
	slot0.levelTextGo_ = slot0.transform_:Find("levelText").gameObject
	slot0.icon_ = slot0.transform_:Find("icon"):GetComponent("Image")
	slot0.iconGo_ = slot0.transform_:Find("icon").gameObject
end

function slot0.IsFree(slot0)
	return slot0.isFree_
end

function slot0.SetFree(slot0, slot1)
	slot0.isFree_ = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0:SetFree(false)

	slot0.text_.text = slot1

	slot0:RefreshTips(slot2, slot3)
	SetActive(slot0.gameObject_, true)
	slot0.transform_:SetAsLastSibling()

	slot0.transform_.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(slot0.gameObject_, Vector3(1.5, 0.1, 1), 0.1)
	LeanTween.scale(slot0.gameObject_, Vector3.one, 0.1):setDelay(0.1)
	slot0:EndDisplay()
end

function slot0.EndDisplay(slot0)
	slot1 = LeanTween.scale(slot0.gameObject_, Vector3(1, 0.1, 1), 0.1)

	slot1:setDelay(1.5)

	slot1 = nil
	slot2 = LeanTween.scale(slot0.gameObject_, Vector3.zero, 0.1)
	slot2 = slot2:setDelay(1.6)
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

function slot0.RefreshTips(slot0, slot1, slot2)
	if TipsCfg[slot1].type == 2 then
		slot0.levelText_.text = ""

		SetActive(slot0.iconGo_, false)
		SetActive(slot0.levelImgGo_, true)
		SetActive(slot0.levelTextGo_, false)

		slot0.levelImg_.sprite = getSprite("Atlas/Tips", slot3.pic1)

		slot0.levelImg_:SetNativeSize()
	elseif TipsCfg[slot1].type == 3 then
		slot0.levelText_.text = slot2 or ""
		slot4 = slot3.pic1 ~= ""

		SetActive(slot0.iconGo_, true)
		SetActive(slot0.levelImgGo_, slot4)
		SetActive(slot0.levelTextGo_, true)

		if slot4 then
			slot0.levelImg_.sprite = getSprite("Atlas/Tips", slot3.pic1)

			slot0.levelImg_:SetNativeSize()
		end

		slot0.icon_.sprite = getSprite("Atlas/Tips", slot3.pic2)

		slot0.icon_:SetNativeSize()
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.levelText_ = nil
	slot0.levelImg_ = nil
	slot0.text_ = nil
	slot0.iconGo_ = nil
	slot0.icon_ = nil
	slot0.levelTextGo_ = nil
	slot0.levelImgGo_ = nil
end

return slot0
