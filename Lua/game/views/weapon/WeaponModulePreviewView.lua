slot0 = class("WeaponModulePreviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/HeroModuleUI/HeroModulePreviewPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attributeItems_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID
	slot0.nameText_.text = WeaponModuleCfg[slot0.params_.heroID].name
	slot0.levelText_.text = HeroData:GetModuleMaxLevel(slot0.heroID_)

	slot0:RefreshDes()
end

function slot0.RefreshDes(slot0)
	slot2, slot3, slot4, slot5 = HeroTools.GetModuleAllDes(HeroData:GetAllModulePowersByHeroID(slot0.heroID_), slot0.heroID_)

	if slot2 == nil then
		SetActive(slot0.attrGo_, false)
	else
		SetActive(slot0.attrGo_, true)
		slot0:RefreshAttriItems(slot2)
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.attrGo_.transform)
	end

	if slot3 == nil then
		SetActive(slot0.skillGo_, false)
	else
		SetActive(slot0.skillGo_, true)

		slot0.skillText_.text = slot3

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillGo_.transform)
	end

	if slot4 == nil then
		SetActive(slot0.astrolabeGo_, false)
	else
		SetActive(slot0.astrolabeGo_, true)

		slot0.astrolabeText_.text = slot4

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.astrolabeGo_.transform)
	end

	if slot5 == nil then
		SetActive(slot0.servantGo_, false)
	else
		SetActive(slot0.servantGo_, true)

		slot0.servantText_.text = slot5

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.RefreshAttriItems(slot0, slot1)
	slot3 = 1

	for slot7, slot8 in pairs(HeroTools.MergeModuleAttribute(slot1)) do
		if slot0.attributeItems_[slot3] == nil then
			slot0.attributeItems_[slot3] = WeaponModuleAttributeItem.New(GameObject.Instantiate(slot0.attriItemGo_, slot0.attriItemTrans_))
		end

		slot0.attributeItems_[slot3]:SetData(slot7, slot8)

		slot3 = slot3 + 1
	end

	for slot7, slot8 in pairs(slot0.attributeItems_) do
		if slot7 < slot3 then
			slot0.attributeItems_[slot7]:SetIsShow(true)
		else
			slot0.attributeItems_[slot7]:SetIsShow(false)
		end
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attributeItems_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
