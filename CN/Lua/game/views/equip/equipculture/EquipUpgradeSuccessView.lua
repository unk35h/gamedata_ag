slot0 = class("EquipUpgradeSuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipUpgradeSuccessUI"
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

	slot0.attrIcon_ = {}
	slot0.attrName_ = {}
	slot0.attrOld_ = {}
	slot0.attrNew_ = {}

	for slot4 = 1, 2 do
		slot5 = slot0["attritem" .. slot4]
		slot0.attrIcon_[slot4] = slot0:FindCom(typeof(Image), "icon", slot5)
		slot0.attrName_[slot4] = slot0:FindCom(typeof(Text), "text", slot5)
		slot0.attrOld_[slot4] = slot0:FindCom(typeof(Text), "ori", slot5)
		slot0.attrNew_[slot4] = slot0:FindCom(typeof(Text), "after", slot5)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = slot0.params_.newEquip

	if not slot0.params_.oldEquip or not slot2 then
		return
	end

	slot0.maxLevelText_.text = "" .. slot2:GetMaxLv()
	slot5 = EquipTools.CountEquipAttribute(slot2)
	slot6 = 1

	for slot10, slot11 in pairs(EquipTools.CountEquipAttribute(slot1)) do
		slot13 = math.floor(slot11)
		slot14 = math.floor(slot5[slot10])

		if PublicAttrCfg[slot10].percent and slot12.percent == 1 then
			slot13 = slot11 / 10 .. "%"
			slot14 = slot5[slot10] / 10 .. "%"
		end

		slot0.attrName_[slot6].text = slot12.name
		slot0.attrIcon_[slot6].sprite = getSprite("Atlas/Common", slot12.icon)
		slot0.attrOld_[slot6].text = slot13
		slot0.attrNew_[slot6].text = slot14
		slot6 = slot6 + 1
	end
end

return slot0
