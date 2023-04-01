slot0 = class("ActivityMatrixSelectAffixView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityMatrixSelectAffixUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.affixCustomList_ = LuaList.New(handler(slot0, slot0.IndexAffixOptionalItem), slot0.m_optionalList, MatrixAffixLongItem)
	slot0.affixRegularList_ = LuaList.New(handler(slot0, slot0.IndexAffixWeekItem), slot0.m_weekList, MatrixAffixLongItem)
	slot0.affixGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupItem), slot0.m_list, MatrixAffixGroupItem)
	slot0.affixHeroGroupList_ = LuaList.New(handler(slot0, slot0.IndexGroupHeroIitem), slot0.m_heroList, MatrixAffixGroupItem)
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.customData = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		ActivityMatrixAction.QueryStartMatrix(uv0.params_.select_hero_list, uv0.matrix_activity_id, uv0.customData)
	end)
end

function slot0.Reset(slot0)
	slot0.customData = {}
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function slot0.OnEnter(slot0)
	slot0.customData = {}
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.regularData = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(ActivityMatrixCfg[slot0.matrix_activity_id].custom_affix) do
		slot10 = MatrixAffixCfg[slot9].affix
		slot11 = slot10[1]

		if slot10[3] == 3 then
			if not slot3[slot11] then
				slot3[slot11] = {}
			end

			table.insert(slot3[slot11], slot9)
		else
			if not slot2[slot11] then
				slot2[slot11] = {}
			end

			table.insert(slot2[slot11], slot9)
		end
	end

	for slot8, slot9 in ipairs(slot0.regularData) do
		slot10 = MatrixAffixCfg[slot9].affix
		slot11 = slot10[1]

		if slot10[3] == 3 then
			if not slot3[slot11] then
				slot3[slot11] = {}
			end

			table.insert(slot3[slot11], slot9)
		else
			if not slot2[slot11] then
				slot2[slot11] = {}
			end

			table.insert(slot2[slot11], slot9)
		end
	end

	slot0.chooseData = {}
	slot0.chooseData_hero = {}

	for slot8, slot9 in pairs(slot2) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData, {
			id = slot8,
			list = slot9
		})
	end

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot9, function (slot0, slot1)
			return slot1 < slot0
		end)
		table.insert(slot0.chooseData_hero, {
			id = slot8,
			list = slot9
		})
	end

	slot0:Refresh(true)
	slot0.lockController:SetSelectedIndex(0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0, slot1)
	if slot1 then
		slot0.affixRegularList_:StartScroll(#slot0.regularData)
		slot0.affixCustomList_:StartScroll(#slot0.customData)
		slot0.affixGroupList_:StartScroll(#slot0.chooseData)
		slot0.affixHeroGroupList_:StartScroll(#slot0.chooseData_hero)
	else
		slot0.affixRegularList_:StartScrollByPosition(#slot0.regularData, slot0.affixRegularList_:GetScrolledPosition())
		slot0.affixCustomList_:StartScrollByPosition(#slot0.customData, slot0.affixCustomList_:GetScrolledPosition())
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
	slot0.affixCustomList_:Dispose()
	slot0.affixRegularList_:Dispose()
	slot0.affixGroupList_:Dispose()
	slot0.affixHeroGroupList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
