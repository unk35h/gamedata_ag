slot0 = class("MatrixSelectView", ReduxView)
slot1 = {
	AI = "AI",
	CAPTAIN = "CAPTAIN",
	AFFIX = "AFFIX",
	BEACON = "BEACON",
	DIFFICULTY = "DIFFICULTY"
}

function slot0.UIName(slot0)
	return "UI/Matrix/Prepare/MatrixSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.MAXSELECT = 2
	slot0.viewState = uv0.DIFFICULTY
	slot0.openDifficultyLv = -1

	for slot4, slot5 in ipairs(MatrixTerminalLevelCfg.all) do
		if table.indexof(MatrixTerminalLevelCfg[slot5].difficulty_open_list, 2) then
			slot0.openDifficultyLv = slot5

			break
		end
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.viewStateController_ = ControllerUtil.GetController(slot0.m_viewStateController, "state")
	slot0.tHero = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.tHero, slot0.m_hero)

	slot0.tDifficulty = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.tDifficulty, slot0.m_difficulty)

	slot0.tBeacon = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.tBeacon, slot0.m_beacon)

	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.tHero.m_heroList, MatrixSelectHeroItem)
	slot0.difficultyList_ = LuaList.New(handler(slot0, slot0.IndexDifficultyItem), slot0.tDifficulty.m_difficultyList, MatrixSelectDifficultyItem)
	slot0.selectAfiifxView = MatrixSelectAffixView.New(slot0.m_affix)
	slot0.beaconList_ = LuaList.New(handler(slot0, slot0.IndexBeaconItem), slot0.tBeacon.m_list, MatrixSelectBeaconItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.tHero.m_confirmBtn, nil, function ()
		if uv0.CAPTAIN == uv1.viewState then
			if uv1.captainId == 0 then
				return
			end

			if uv1:HaveLoneWolf() then
				if uv1.selectDifficulty == 1 then
					uv1:StartMatrix()
				else
					uv1.viewState = uv0.AFFIX

					uv1:Refresh()
				end
			else
				uv1.viewState = uv0.AI

				uv1:Refresh()
			end
		else
			if uv1.captainId == 0 or #uv1.selectHeroList ~= 2 then
				return
			end

			if uv1.selectDifficulty == 1 then
				uv1:StartMatrix()
			else
				uv1.viewState = uv0.AFFIX

				uv1:Refresh()
			end
		end
	end)
	slot0:AddBtnListener(slot0.tDifficulty.m_okBtn, nil, function ()
		uv0.viewState = uv1.BEACON

		uv0:Refresh()
	end)
	slot0:AddBtnListener(slot0.selectAfiifxView.m_okBtn, nil, function ()
		uv0:StartMatrix()
	end)
	slot0:AddBtnListener(slot0.tBeacon.m_okBtn, nil, function ()
		if #uv0.selectBeaconList == 0 then
			ShowTips(GetTips("MATRIX_SELECT_BEACON"))

			return
		end

		uv0.viewState = uv1.CAPTAIN

		uv0:Refresh()
	end)
end

function slot0.HaveLoneWolf(slot0)
	return table.indexof(slot0.selectBeaconList, 10)
end

function slot0.StartMatrix(slot0)
	table.insert(clone(slot0.selectHeroList), 1, slot0.captainId)
	MatrixAction.QueryStartMatrix(slot1, slot0.selectDifficulty, slot0.selectDifficulty == 1 and {} or slot0.selectAfiifxView.customData, slot0.selectBeaconList)
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.AI == uv1.viewState then
			uv1.viewState = uv0.CAPTAIN
			uv1.selectHeroList = {}

			uv1:Refresh()
		elseif uv0.CAPTAIN == uv1.viewState then
			uv1.viewState = uv0.BEACON

			uv1:Refresh()
		elseif uv0.AFFIX == uv1.viewState then
			if uv1:HaveLoneWolf() then
				uv1.viewState = uv0.CAPTAIN
			else
				uv1.viewState = uv0.AI
			end

			uv1:Refresh()
		elseif uv0.BEACON == uv1.viewState then
			uv1.viewState = uv0.DIFFICULTY

			uv1:Refresh()
		else
			uv1:Back(1)
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0:Refresh()
end

function slot0.OnEnter(slot0)
	MatrixData:SetCacheCustomAffix({})

	slot0.heroData = MatrixData:GetReadyHeroList()
	slot0.viewState = uv0.DIFFICULTY
	slot0.selectDifficulty = -1
	slot0.captainId = 0
	slot0.selectHeroList = {}
	slot0.selectBeaconList = {}

	slot0.selectAfiifxView:Reset()
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0)
	if uv0.CAPTAIN == slot0.viewState then
		slot0.viewStateController_:SetSelectedIndex(0)

		slot0.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM_LEADER")
		slot0.tHero.m_confirmBtn.interactable = slot0.captainId ~= 0

		slot0.heroList_:StartScroll(#slot0.heroData)
	elseif uv0.AI == slot0.viewState then
		slot0.viewStateController_:SetSelectedIndex(0)

		slot0.tHero.m_tip.text = GetTips("MATRIX_SELECT_TEAM")
		slot0.tHero.m_confirmBtn.interactable = #slot0.selectHeroList == 2

		slot0.heroList_:StartScroll(#slot0.heroData)
	elseif uv0.DIFFICULTY == slot0.viewState then
		slot0.viewStateController_:SetSelectedIndex(1)
		slot0.difficultyList_:StartScroll(2)

		slot0.affixCustomData = {}

		if slot0.selectDifficulty == -1 then
			slot0.tDifficulty.m_okBtn.interactable = false
		else
			slot0.tDifficulty.m_okBtn.interactable = true
		end
	elseif uv0.AFFIX == slot0.viewState then
		slot0.viewStateController_:SetSelectedIndex(2)
		slot0.selectAfiifxView:SetData(slot0.selectDifficulty)
	elseif uv0.BEACON == slot0.viewState then
		slot0.viewStateController_:SetSelectedIndex(3)

		slot0.maxBeaconSelect = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].beacon_number
		slot0.beaconData = MatrixData:GetUnlockBeaconList()

		slot0.beaconList_:StartScroll(#slot0.beaconData)

		slot0.tBeacon.m_numLab.text = #slot0.selectBeaconList .. "/" .. slot0.maxBeaconSelect

		if #slot0.selectBeaconList > 0 then
			slot0.tBeacon.m_okBtn.interactable = true
		else
			slot0.tBeacon.m_okBtn.interactable = false
		end
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.heroData[slot1]
	slot4 = 0

	if uv0.CAPTAIN == slot0.viewState then
		if slot3 == slot0.captainId then
			slot4 = 1
		end
	else
		slot4 = slot3 == slot0.captainId and 3 or table.indexof(slot0.selectHeroList, slot3) and 1 or slot0.MAXSELECT > #slot0.selectHeroList and 0 or 2
	end

	slot2:Refresh(slot3, slot4, slot3 == slot0.captainId, slot0.selectDifficulty)
	slot2:RegistCallBack(function ()
		uv0:OnHeroItemClick(uv1)
	end)
end

function slot0.OnHeroItemClick(slot0, slot1)
	if uv0.CAPTAIN == slot0.viewState then
		if slot1 == slot0.captainId then
			slot0.captainId = 0
		else
			slot0.captainId = slot1
		end
	elseif slot1 ~= slot0.captainId then
		if table.indexof(slot0.selectHeroList, slot1) then
			table.remove(slot0.selectHeroList, slot2)
		elseif slot0.MAXSELECT > #slot0.selectHeroList then
			table.insert(slot0.selectHeroList, slot1)
		end
	end

	slot0:Refresh()
end

function slot0.IndexDifficultyItem(slot0, slot1, slot2)
	slot2:Refresh(slot1, slot1 == slot0.selectDifficulty)
	slot2:RegistCallBack(function ()
		uv0:OnDifficultyItemClick(uv1)
	end)
end

function slot0.OnDifficultyItemClick(slot0, slot1)
	if slot1 == 2 then
		if not table.indexof(MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].difficulty_open_list, 2) then
			ShowTips(string.format(GetTips("MATRIX_TERMINAL_LEVEL_UNLOCK"), slot0.openDifficultyLv))

			return
		end

		if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_DIFFICULTY_CONDITION) then
			ShowTips(GetTips("MATRIX_CLEARANCE_DIFFICULTY_UNLOCK"))

			return
		end
	end

	if slot1 == slot0.selectDifficulty then
		return
	else
		slot0.selectDifficulty = slot1
	end

	slot0:Refresh()
end

function slot0.IndexBeaconItem(slot0, slot1, slot2)
	slot3 = slot0.beaconData[slot1]
	slot4 = not not table.indexof(slot0.selectBeaconList, slot3)

	slot2:Refresh(slot3)
	slot2:SetChoice(slot4)
	slot2:SetMask(not slot4 and slot0.maxBeaconSelect <= #slot0.selectBeaconList)
	slot2:RegistCallBack(handler(slot0, slot0.OnBeaconItemClick))
end

function slot0.OnBeaconItemClick(slot0, slot1, slot2)
	if table.indexof(slot0.selectBeaconList, slot1) then
		slot0:UnSelectBeacon(slot1)
	else
		if slot0.maxBeaconSelect <= #slot0.selectBeaconList then
			ShowTips("MATRIX_SELECT_BEACON_MAX")

			return
		end

		slot5 = {}
		slot6 = MatrixData:GetTerminalGift() or {}
		slot7 = ipairs
		slot9 = MatrixBeaconCfg[slot1].require_terminal_list or {}

		for slot10, slot11 in slot7(slot9) do
			if not slot6[slot11] or slot6[slot11] == 0 then
				table.insert(slot5, slot11)
			end
		end

		if #slot5 > 0 then
			slot7 = ""

			for slot11, slot12 in ipairs(slot5) do
				slot13 = MatrixTerminalGiftCfg[slot12]
				slot7 = (slot11 ~= 1 or slot13.name) and slot13.name .. "," .. slot13.name
			end

			ShowMessageBox({
				content = string.format(GetTips("ERROR_MATRIX_NOT_EFFECTIVE"), slot4.name, slot7),
				OkCallback = function ()
					uv0:SelectBeacon(uv1)
				end
			})

			return
		end

		slot0:SelectBeacon(slot1)
	end
end

function slot0.SelectBeacon(slot0, slot1)
	table.insert(slot0.selectBeaconList, slot1)

	slot2 = #slot0.selectBeaconList
	slot0.tBeacon.m_numLab.text = slot2 .. "/" .. slot0.maxBeaconSelect

	slot0.beaconList_:Refresh()

	if slot2 > 0 then
		slot0.tBeacon.m_okBtn.interactable = true
	else
		slot0.tBeacon.m_okBtn.interactable = false
	end
end

function slot0.UnSelectBeacon(slot0, slot1)
	table.remove(slot0.selectBeaconList, table.indexof(slot0.selectBeaconList, slot1))

	slot3 = #slot0.selectBeaconList
	slot0.tBeacon.m_numLab.text = slot3 .. "/" .. slot0.maxBeaconSelect

	slot0.beaconList_:Refresh()

	if slot3 > 0 then
		slot0.tBeacon.m_okBtn.interactable = true
	else
		slot0.tBeacon.m_okBtn.interactable = false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.heroList_:Dispose()
	slot0.difficultyList_:Dispose()
	slot0.beaconList_:Dispose()
	slot0.selectAfiifxView:Dispose()
end

function slot0.OnMatrixSystemOverdue(slot0)
	slot0:Back()
end

return slot0
