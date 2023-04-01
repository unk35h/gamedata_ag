slot0 = class("MatrixSelectAffixView", ReduxView)
slot1 = {}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.affixRegularList_ = LuaList.New(handler(slot0, slot0.IndexAffixWeekItem), slot0.m_weekList, MatrixAffixLongItem)
	slot0.affixGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupItem), slot0.m_list, MatrixAffixGroupItem)
	slot0.affixHeroGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupHeroIitem), slot0.m_heroList, MatrixAffixGroupItem)
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.customData = {}
end

function slot0.Reset(slot0)
	slot0.customData = {}

	slot0:ClearItems()
end

function slot0.SetData(slot0, slot1)
	slot2 = MatrixData:GetReadyDifficultyData(slot1)
	slot0.regularData = slot2:GetRegularAffix()
	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(slot2:GetAllCustomAffix()) do
		slot11 = MatrixAffixCfg[slot10].affix
		slot12 = slot11[1]

		if slot11[3] == 3 then
			if not slot4[slot12] then
				slot4[slot12] = {}
			end

			table.insert(slot4[slot12], slot10)
		else
			if not slot3[slot12] then
				slot3[slot12] = {}
			end

			table.insert(slot3[slot12], slot10)
		end
	end

	for slot9, slot10 in ipairs(slot0.regularData) do
		slot11 = MatrixAffixCfg[slot10].affix
		slot12 = slot11[1]

		if slot11[3] == 3 then
			if not slot4[slot12] then
				slot4[slot12] = {}
			end

			table.insert(slot4[slot12], slot10)
		else
			if not slot3[slot12] then
				slot3[slot12] = {}
			end

			table.insert(slot3[slot12], slot10)
		end
	end

	slot0.chooseData = {}
	slot0.chooseData_hero = {}

	for slot9, slot10 in pairs(slot3) do
		table.sort(slot10, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData, {
			id = slot9,
			list = slot10
		})
	end

	for slot9, slot10 in pairs(slot4) do
		table.sort(slot10, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData_hero, {
			id = slot9,
			list = slot10
		})
	end

	slot0:Refresh(true)

	if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_CUSTOM_AFFIX_CONDITION) then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.Refresh(slot0, slot1)
	if slot1 then
		slot0.affixRegularList_:StartScroll(#slot0.regularData)
		slot0.affixGroupList_:StartScroll(#slot0.chooseData)
		slot0.affixHeroGroupList_:StartScroll(#slot0.chooseData_hero)
	else
		slot0.affixRegularList_:StartScrollByPosition(#slot0.regularData, slot0.affixRegularList_:GetScrolledPosition())
		slot0.affixGroupList_:Refresh()
		slot0.affixHeroGroupList_:Refresh()
	end

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(slot0.regularData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	for slot7, slot8 in ipairs(slot0.customData) do
		slot9 = MatrixAffixCfg[slot8]
		slot2 = slot2 + slot9.point
		slot3 = slot3 + slot9.multiple
	end

	slot0.m_scoreLab.text = "" .. slot2
	slot0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), slot3 / 10 .. "%")

	if not slot1 then
		slot0:RefreshItems()
	end
end

function slot0.IndexAffixWeekItem(slot0, slot1, slot2)
	slot2:Refresh(MatrixAffixCfg[slot0.regularData[slot1]].affix, 2)
end

function slot0.IndexAffixOptionalItem(slot0, slot1, slot2)
	slot2:Refresh(MatrixAffixCfg[slot0.customData[slot1]].affix, 2)
end

function slot0.IndexGroupItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.chooseData[slot1], slot0.regularData, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.IndexGroupHeroIitem(slot0, slot1, slot2)
	slot2:Refresh(slot0.chooseData_hero[slot1], slot0.regularData, slot0.customData)
	slot2:RegistCallBack(handler(slot0, slot0.OnChooseCallBack))
end

function slot0.OnChooseCallBack(slot0, slot1)
	slot3 = MatrixAffixCfg[slot1].affix[1]

	for slot7, slot8 in ipairs(slot0.regularData) do
		if slot3 == MatrixAffixCfg[slot8].affix[1] then
			return
		end
	end

	slot4 = false

	for slot8, slot9 in ipairs(slot0.customData) do
		if slot9 == slot1 then
			table.remove(slot0.customData, slot8)

			slot4 = true

			break
		end

		if slot3 == MatrixAffixCfg[slot9].affix[1] then
			slot0.customData[slot8] = slot1
			slot4 = true

			break
		end
	end

	if not slot4 then
		table.insert(slot0.customData, 1, slot1)
	end

	slot0:Refresh()
end

function slot0.Dispose(slot0)
	slot0.affixRegularList_:Dispose()
	slot0.affixGroupList_:Dispose()
	slot0.affixHeroGroupList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.StartScroll(slot0)
end

function slot0.StartScrollByPosition(slot0)
end

function slot0.RefreshItems(slot0)
	slot1 = slot0.m_content.childCount

	print(slot1)

	for slot5 = 0, slot1 - 1 do
		slot0.m_content:GetChild(slot5).gameObject:SetActive(false)
	end

	print(slot1)

	slot3 = nil

	if slot1 < #slot0.customData then
		for slot7 = 1, slot2 - slot1 do
			Object.Instantiate(slot0.m_item.gameObject, slot0.m_content.transform):SetActive(true)
		end
	end

	slot4 = 0
	slot5 = nil

	for slot9, slot10 in pairs(slot0.customData) do
		slot3 = slot0.m_content:GetChild(slot4).gameObject
		slot4 = slot4 + 1

		slot3:SetActive(true)
		MatrixAffixLongItem.New(slot3):Refresh(MatrixAffixCfg[slot10].affix, 2)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content:GetComponent("RectTransform"))

	for slot9 = 0, slot1 - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content:GetChild(slot9))
	end
end

function slot0.ClearItems(slot0)
	slot1 = slot0.m_content.childCount

	print(slot1)

	for slot5 = 0, slot1 - 1 do
		slot0.m_content:GetChild(slot5).gameObject:SetActive(false)
	end
end

return slot0
