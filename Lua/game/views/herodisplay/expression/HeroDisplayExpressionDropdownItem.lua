slot0 = class("HeroDisplayExpressionDropdownItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(HERO_DISPLAY_EXPRESSION_ITEM, uv0.index_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.text_.text = slot2

	slot0:Show(true)
end

function slot0.SetSelect(slot0, slot1)
	SetActive(slot0.goSelect_, slot1)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
