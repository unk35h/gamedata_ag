slot0 = class("SuitItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")

	slot0.recommendController_ = ControllerUtil.GetController(slot0.transform_, "recommend")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot3 = EquipRecommendCfg[slot1] and EquipRecommendCfg[slot1].suit_list or {}
	slot0.data = slot2
	slot0.ids = {}

	if slot2 == "recommend" then
		slot0.typeController_:SetSelectedIndex(1)
		slot0.recommendController_:SetSelectedIndex(0)

		slot0.name_.text = GetTips("TIP_RECOMMEND")

		if slot3[1] then
			slot4 = slot3[1]

			SetSpriteWithoutAtlasAsync(slot0.leftIcon_, SpritePathCfg.EquipIcon.path .. EquipSuitCfg[slot4].equip_skill_icon)
			table.insert(slot0.ids, slot4)
		else
			slot0.leftIcon_.sprite = nil
		end

		if slot3[2] then
			slot4 = slot3[2]

			SetSpriteWithoutAtlasAsync(slot0.rightIcon_, SpritePathCfg.EquipIcon.path .. EquipSuitCfg[slot4].equip_skill_icon)
			table.insert(slot0.ids, slot4)
		else
			slot0.rightIcon_.sprite = nil
		end
	elseif slot2 == 0 then
		slot0.typeController_:SetSelectedIndex(0)
		slot0.recommendController_:SetSelectedIndex(0)

		slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", "sifting_all")
		slot0.name_.text = GetTips("ALL")

		table.insert(slot0.ids, 0)
	else
		slot0.typeController_:SetSelectedIndex(0)

		if table.indexof(slot3, slot2) then
			slot0.recommendController_:SetSelectedIndex(1)
		else
			slot0.recommendController_:SetSelectedIndex(0)
		end

		slot4 = EquipSuitCfg[slot2]

		SetSpriteWithoutAtlasAsync(slot0.icon_, SpritePathCfg.EquipIcon.path .. slot4.equip_skill_icon)

		slot0.name_.text = slot4.name

		table.insert(slot0.ids, slot2)
	end
end

function slot0.RefreshPos(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.ids) do
		slot2 = slot2 + EquipTools.GetSuitEquipNum(slot7, nil, slot1)
	end

	slot0:SetBottomText(slot2)
end

function slot0.SetBottomText(slot0, slot1)
	slot0.num_.text = slot1

	if slot0.maskGo_ then
		SetActive(slot0.maskGo_, slot1 == 0)
	end
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.data, slot0.ids)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
