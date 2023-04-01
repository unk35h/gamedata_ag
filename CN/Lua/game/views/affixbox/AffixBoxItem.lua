slot0 = class("AffixBoxItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0.icon_ = slot0:FindCom(typeof(Image), "icon")
	slot0.text_ = slot0:FindCom(typeof(Text), "text")
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.icon_.sprite = getAffixSprite(slot1)
	slot0.text_.text = string.format("%s\n%s", getAffixName(slot1), getAffixDesc(slot1))

	slot0:SetActive(true)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
