slot1 = class("NewHeroTransitionSkillItem", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))

function slot1.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.scrollView_ = slot3

	slot0:Init()
	slot0:Show(true)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.contentSizeFitter_ = slot0.desc_:GetComponent("ContentSizeFitter")
end

function slot1.AddUIListeners(slot0)
end

function slot1.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.itemData_ = slot1
	slot0.heroID_ = slot3
	slot0.index_ = slot2
	slot0.isAdd_ = slot4

	slot0:SetText()
	slot0:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.itemRect_)
end

function slot1.SetText(slot0)
	slot2 = slot0.itemData_.level + slot0.isAdd_
	slot3 = EquipSkillCfg[slot0.itemData_.id]

	if slot0.isAdd_ > 0 then
		slot0.level_.text = GetTips("LEVEL") .. "<color=#ffbb66>" .. slot2 .. "</color>"
	else
		slot0.level_.text = GetTips("LEVEL") .. slot2
	end

	slot0.name_.text = slot3.name
	slot0.icon_.sprite = getEquipSkillSprite(slot1)
	slot0.desc_.text = EquipTools.GetSkillDescWithoutNext(slot1, slot2, slot0.heroID_)
end

function slot1.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot1.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot1
