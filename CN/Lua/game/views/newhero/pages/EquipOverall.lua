slot0 = class("EquipOverall", ReduxView)
slot1 = {
	HeroConst.HERO_ATTRIBUTE.ATK,
	HeroConst.HERO_ATTRIBUTE.ARM,
	HeroConst.HERO_ATTRIBUTE.STA,
	HeroConst.HERO_ATTRIBUTE.CRITICAL
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeNameS_ = {
		[1.0] = "suit",
		[2.0] = "skill"
	}
	slot0.skillIndex_ = 0
	slot0.skillItems_ = {}
	slot0.suitIndex_ = 0
	slot0.suitItems_ = {}
end

function slot0.AddUIListener(slot0)
	slot0.toggle_ = {}

	for slot4, slot5 in pairs(slot0.typeNameS_) do
		slot0.toggle_[slot4] = slot0[slot5 .. "Tgl_"]

		slot0:AddToggleListener(slot0.toggle_[slot4], function (slot0)
			if slot0 then
				uv0:RefreshToggleSelect(uv1)
			end
		end)
		slot0:SetListener(slot0.toggle_[slot4].onValueChanged)
	end

	slot0:AddBtnListener(slot0.equipEffectBtn_, nil, function ()
		JumpTools.OpenPageByJump("equipMoreAttribute", {
			heroID = uv0.heroID_,
			equipList = uv0.equipList_,
			isAdd = uv0.isAdd_
		})
	end)
end

function slot0.ChangeShowView(slot0, slot1, slot2)
	slot0.selectId_ = slot1

	SetActive(slot0[slot0.typeNameS_[slot1] .. "PanelGo_"], slot2)
end

function slot0.SetInfo(slot0, slot1)
	slot0.heroInfo_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshHeroInfo(slot0, slot1, slot2, slot3)
	slot0.extra_ = slot3
	slot0.isForeign_ = slot3 and slot3.isForeign
	slot0.isTemp_ = slot3 and slot3.isTemp
	slot0.isPolyhedron_ = slot3 and slot3.isPolyhedron
	slot4 = slot2 and slot2 or slot1.equip

	if slot0.isPolyhedron_ then
		for slot11, slot12 in ipairs(EquipTools.GetConstructVirtualEquips(PolyhedronHeroCfg[slot1.id].standard_id)) do
			slot12.pos = slot11
		end
	end

	slot5 = slot1.id

	slot0:RefreshAttr(slot4, slot5)
	slot0:RefreshSkill(slot4, slot1, slot5)
	slot0:RefreshSuit(slot4, HeroTools.GetIsSuitNumCut(slot1), slot5)
	slot0:RefreshToggleSelect()

	slot10 = 0
	slot0.skillPanelTrs_.anchoredPosition = Vector3(slot10, 0, 0)

	for slot10 = 1, #slot0.suitList_ do
		slot0.suitItems_[slot10]:RefreshLayout()
	end

	slot0.heroID_ = slot1.id

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitPanelTrs_)
end

function slot0.RefreshAttr(slot0, slot1, slot2)
	slot3 = nil

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot3 = ForeignInfoData:CalHeroEquipAttribute(slot2)
		elseif slot0.isTemp_ then
			slot3 = TempHeroData:CalHeroEquipAttribute(slot0.extra_.tempHeroList, slot2)
		elseif slot0.isPolyhedron_ then
			slot3 = {
				0,
				0,
				0,
				0,
				0
			}
		end
	else
		slot3 = EquipTools.CalHeroEquipAttribute(slot1, slot2)
	end

	for slot7 = 1, 4 do
		slot9 = slot0[string.format("attr%dText_", slot7)]
		slot10 = slot0[string.format("name%dText_", slot7)]
		slot11 = slot0[string.format("icon%dImg_", slot7)]
		slot12, slot13, slot14 = nil

		if slot3[uv0[slot7]] then
			slot12, slot13, slot14 = SkillTools.GetAttr({
				slot8,
				slot3[slot8]
			})
		else
			slot12, slot13, slot14 = SkillTools.GetAttr({
				slot8,
				0
			})
		end

		slot15 = PublicAttrCfg[slot8]
		slot10.text = slot12
		slot11.sprite = slot14
		slot16 = nil

		if (not slot3[slot8] and 0 or math.floor(slot3[slot8])) == 0 then
			slot9.color = Color.New(0.5019, 0.5019, 0.5019, 1)
			slot9.text = "--"
		else
			slot9.color = Color.New(0.2117, 0.2274, 0.2588, 1)

			if slot15.percent == 1 then
				slot9.text = slot16 / 10 .. "%"
			else
				slot9.text = slot16
			end
		end
	end
end

function slot0.RefreshSkill(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot0.extra_ then
		if slot0.isForeign_ then
			for slot8 = 1, 6 do
				if ForeignInfoData:GetEquipInfo(slot2.id, slot8) then
					table.insert(slot4, slot9)
				end
			end
		elseif slot0.isTemp_ then
			for slot8 = 1, 6 do
				if TempHeroData:GetEquipInfo(slot0.extra_.tempHeroList, slot2.id, slot8) then
					table.insert(slot4, slot9)
				end
			end
		elseif slot0.isPolyhedron_ then
			slot4 = EquipTools.GetConstructVirtualEquips(PolyhedronHeroCfg[slot2.id].standard_id)
		end
	else
		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4, EquipData:GetEquipList()[slot9.equip_id])
		end
	end

	slot5, slot0.isAdd_ = EquipTools.CountHeroTotalSkill(slot4, slot2)
	slot0.equipList_ = slot4
	slot0.skillList_ = {}

	for slot10, slot11 in pairs(slot5) do
		table.insert(slot0.skillList_, {
			unlockLevel = 0,
			level = 10,
			id = slot10,
			num = slot11,
			isAdd = slot6
		})
	end

	slot7 = HeroCfg[slot3].equip_skill

	table.sort(slot0.skillList_, function (slot0, slot1)
		slot3 = table.indexof(uv0, slot1.id)

		if table.indexof(uv0, slot0.id) and slot3 then
			return slot2 < slot3
		end

		return slot0.id < slot1.id
	end)

	for slot12 = 1, #slot0.skillList_ do
		if slot0.skillIndex_ < slot12 then
			slot0.skillItems_[slot12] = EquipNewSkillItem.New(slot0, Object.Instantiate(slot0.skillItemGo_, slot0.skillPanelTrs_), slot0.skillList_[slot12])
			slot0.skillIndex_ = slot0.skillIndex_ + 1
			slot14 = slot0.skillItems_[slot12]

			slot14:RegistCallBack(function (slot0)
				uv0:SkillClick(uv0.skillItems_[uv1], slot0)
			end)
		end

		slot0.skillItems_[slot12]:RefreshData(slot0, slot0.skillList_[slot12])
	end

	SetActive(slot0.skillNullGo_, slot8 == 0)

	for slot12, slot13 in ipairs(slot0.skillItems_) do
		slot13:Show(slot12 <= slot8)
	end
end

function slot0.RefreshSuit(slot0, slot1, slot2, slot3)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.suitList_ = ForeignInfoData:CountActiveSuit(slot3)
		elseif slot0.isTemp_ then
			slot0.suitList_ = TempHeroData:CountActiveSuit(slot0.extra_.tempHeroList, slot3)
		elseif slot0.isPolyhedron_ then
			slot0.suitList_ = EquipTools.CountActiveSuit(slot1, {
				isPolyhedron = true
			})
		end
	else
		slot0.suitList_ = EquipTools.CountActiveSuit(slot1)
	end

	for slot7 = #slot0.suitList_, 1, -1 do
		if slot0.suitList_[slot7].num < EquipTools.GetSuitNeedNum(slot0.suitList_[slot7].id, slot2) then
			table.remove(slot0.suitList_, slot7)
		end
	end

	for slot8 = 1, #slot0.suitList_ do
		if slot0.suitIndex_ < slot8 then
			slot0.suitItems_[slot8] = EquipNewSuitItem.New(slot0, Object.Instantiate(slot0.suitItemGo_, slot0.suitPanelTrs_), slot0.suitList_[slot8])
			slot0.suitIndex_ = slot0.suitIndex_ + 1
			slot10 = slot0.suitItems_[slot8]

			slot10:RegistCallBack(function (slot0)
				uv0:SuitClick(uv0.suitItems_[uv1], slot0)
			end)
		end

		slot0.suitItems_[slot8]:RefreshData(slot0, slot0.suitList_[slot8])
	end

	SetActive(slot0.suitNullGo_, slot4 == 0)

	for slot8, slot9 in ipairs(slot0.suitItems_) do
		slot9:Show(slot8 <= slot4)
	end

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitPanelTrs_)
	end
end

function slot0.RegistSkillClick(slot0, slot1)
	slot0.SkillClickFunc_ = slot1
end

function slot0.SkillClick(slot0, slot1, slot2)
	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	if slot0.lastHeroSkillSelect_ then
		slot0.lastHeroSkillSelect_:ShowSelect(false)
	end

	slot0.lastSkillSelect_ = slot1

	slot1:ShowSelect(true)
	slot0.SkillClickFunc_(slot2)
end

function slot0.Deselect(slot0)
	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	if slot0.lastHeroSkillSelect_ then
		slot0.lastHeroSkillSelect_:ShowSelect(false)
	end
end

function slot0.OnEnter(slot0)
	slot0:RefreshToggleSelect()
end

function slot0.RefreshToggleSelect(slot0, slot1)
	if slot1 == nil then
		slot1 = 1
	end

	for slot5, slot6 in pairs(slot0.typeNameS_) do
		slot0.toggle_[slot5] = slot0[slot6 .. "Tgl_"]
		slot7 = slot5 == slot1

		SetActive(slot0[slot6 .. "UnselectGo_"], not slot7)
		SetActive(slot0[slot6 .. "SelectGo_"], slot7)
		slot0:ChangeShowView(slot5, slot7)
	end

	slot0.toggle_[slot1] = true
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.skillItems_ then
		for slot4, slot5 in ipairs(slot0.skillItems_) do
			slot5:Dispose()
		end

		slot0.skillItems_ = nil
	end

	if slot0.suitItems_ then
		for slot4, slot5 in ipairs(slot0.suitItems_) do
			slot5:Dispose()
		end

		slot0.suitItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
