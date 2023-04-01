slot0 = class("HeroAttributeView", ReduxView)
slot1 = {
	BASE = {
		1,
		2,
		3,
		81,
		82
	},
	ELEMENT = {
		151,
		152,
		153,
		158,
		155,
		154,
		157,
		156
	},
	TARGET = {
		201,
		202,
		203,
		221,
		222,
		421
	},
	SKILL = {
		301,
		302,
		303,
		315
	}
}

function slot0.UIName(slot0)
	return "UI/Hero/HeroattributeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.attributeItemList_ = {}

	for slot4, slot5 in pairs(uv0.BASE) do
		slot0.attributeItemList_[slot5] = HeroAttributeItemView.New(slot0.goAttributeItem_, slot0.goBaseAttribute_, slot4, slot5)
	end

	for slot4, slot5 in pairs(uv0.ELEMENT) do
		slot0.attributeItemList_[slot5] = HeroAttributeItemView.New(slot0.goAttributeItem_, slot0.goElementAttribute_, slot4, slot5)
	end

	for slot4, slot5 in pairs(uv0.TARGET) do
		slot0.attributeItemList_[slot5] = HeroAttributeItemView.New(slot0.goAttributeItem_, slot0.goTargetAttribute_, slot4, slot5)
	end

	for slot4, slot5 in pairs(uv0.SKILL) do
		slot0.attributeItemList_[slot5] = HeroAttributeItemView.New(slot0.goAttributeItem_, slot0.goSkillAttribute_, slot4, slot5)
	end
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot0.extra_ = slot0.params_.extra
	slot4 = slot0.extra_
	slot0.attribute_ = HeroTools.GetHeroAllAttribute(slot0.heroID_, slot4)

	for slot4, slot5 in pairs(slot0.attributeItemList_) do
		slot5:SetData(slot0.attribute_[slot4])
	end

	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.attributeItemList_) do
		slot5:Dispose()
	end

	slot0.attributeItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
end

return slot0
