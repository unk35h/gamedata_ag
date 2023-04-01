slot0 = class("MatrixProcessView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/Matrix/Process/MatrixProcessUI"
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

	slot0.eventList_ = LuaList.New(handler(slot0, slot0.indexEventItem), slot0.m_eventList, MatrixProcessEventItem)
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.m_rewardList, MatrixProcessRewardItem)
	slot0.incidentList_ = LuaList.New(handler(slot0, slot0.indexIncidentItem), slot0.m_incidentList, MatrixProcessIncidentItem)
	slot0.phaseController_ = ControllerUtil.GetController(slot0.m_phaseController, "phase")
	slot0.hasGiveUpRewadController_ = ControllerUtil.GetController(slot0.m_phaseController, "hasGiveUpRewad")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardCommon, nil, function ()
		MatrixAction.QueryNextProgress({})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		uv0:OnRewardAction()
	end)
	slot0:AddBtnListener(slot0.m_eventBtn, nil, function ()
		uv0:OnEventAction()
	end)
	slot0:AddBtnListener(slot0.m_giveUpBtn, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function ()
				MatrixAction.QueryMatrixGiveUp(function (slot0)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_incidentBtn, nil, function ()
		if uv0.selectItemIndex == -1 then
			return
		end

		MatrixAction.QueryNextProgress({
			uv0.incidentData[uv0.selectItemIndex]
		})
	end)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function slot0.OnEnter(slot0)
	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.phaseData = slot0:GetMatrixPhaseData()
	slot0.phasesParams = clone(slot0.phaseData:GetParams())
	slot0.matrixGiveUpItemId = slot0.phaseData:GetGiveUpItemId()
	slot0.incidentData = {}
	slot0.selectItemIndex = -1
	slot0.m_rewardBtn.interactable = false
	slot0.m_eventBtn.interactable = false
	slot0.m_incidentBtn.interactable = false

	if slot0.phaseData:GetPhase() == 1 then
		slot0.phaseController_:SetSelectedIndex(1)
		slot0.eventList_:StartScroll(#slot0.phasesParams)
	elseif slot1 == 2 then
		if MatrixConst.EVENT_TYPE.INCIDENT == MatrixEventCfg[slot0.phasesParams[1]].event_type then
			slot0.incidentData = {}

			for slot9, slot10 in ipairs(MatrixChanceCfg.get_id_list_by_title_id[slot0.phaseData:GetData()]) do
				table.insert(slot0.incidentData, MatrixChanceCfg[slot10].option)
			end

			slot0.m_incidentTitle.text = MatrixDescCfg[slot4] and MatrixDescCfg[slot4].desc or ""

			slot0.phaseController_:SetSelectedIndex(3)
			slot0.incidentList_:StartScroll(#slot0.incidentData)
		else
			slot0.phaseController_:SetSelectedIndex(1)
			slot0.eventList_:StartScroll(#slot0.phasesParams)
		end
	elseif slot1 == 3 then
		if slot0.matrixGiveUpItemId and slot0.matrixGiveUpItemId ~= 0 then
			slot0.hasGiveUpRewadController_:SetSelectedIndex(1)

			if MatrixConst.ITEM_TYPE.ITEM == MatrixItemCfg[slot0.matrixGiveUpItemId].matrix_item_type and #slot2.params > 0 then
				slot4 = slot2.params[1][2]

				if slot2.params[1][1] == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
					slot4 = slot4 * (1 + slot0:GetGiveUpRewardAddition())
				end

				slot0.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), slot4, GetI18NText(slot2.name))
			else
				slot0.m_rewardCommonText.text = slot2.desc
			end
		else
			slot0.hasGiveUpRewadController_:SetSelectedIndex(0)
		end

		slot0.phaseController_:SetSelectedIndex(2)
		slot0.rewardList_:StartScroll(#slot0.phasesParams)
	else
		slot0.phaseController_:SetSelectedIndex(0)
	end

	if slot0:GetDifficulty() == 1 then
		slot0.m_difficultyLab.text = GetTips("HARDLEVEL_EASY")
	elseif slot2 == 3 then
		slot0.m_difficultyLab.text = GetTips("HARDLEVEL_SINGULARITY")
	else
		slot0.m_difficultyLab.text = GetTips("HARDLEVEL_HARD")
	end

	slot0.m_tierLab.text = slot0:GetTierDes()
end

function slot0.indexEventItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnEvengtItemClick))
	slot2:Refresh(slot0.phasesParams[slot1], slot1)
	slot2:SetSelected(slot1 == slot0.selectItemIndex)
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnRewardItemClick))
	slot2:Refresh(slot0.phasesParams[slot1], slot1)
	slot2:SetSelected(slot1 == slot0.selectItemIndex)
end

function slot0.indexIncidentItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnIncidentItemClick))
	slot2:Refresh(slot0.incidentData[slot1], slot1)
	slot2:SetSelected(slot1 == slot0.selectItemIndex)
end

function slot0.OnEvengtItemClick(slot0, slot1)
	if slot1 == slot0.selectItemIndex then
		return
	end

	slot0.selectItemIndex = slot1

	for slot6, slot7 in pairs(slot0.eventList_:GetItemList()) do
		slot7:SetSelected(slot7:GetIndex() == slot0.selectItemIndex)
	end

	slot0.m_eventBtn.interactable = true
end

function slot0.OnRewardItemClick(slot0, slot1, slot2)
	if slot1 == slot0.selectItemIndex then
		return
	end

	slot0.selectItemIndex = slot1

	for slot7, slot8 in pairs(slot0.rewardList_:GetItemList()) do
		slot8:SetSelected(slot8:GetIndex() == slot0.selectItemIndex)
	end

	slot0.m_rewardBtn.interactable = true
end

function slot0.OnIncidentItemClick(slot0, slot1)
	if slot1 == slot0.selectItemIndex then
		return
	end

	slot0.selectItemIndex = slot1

	for slot6, slot7 in pairs(slot0.incidentList_:GetItemList()) do
		slot7:SetSelected(slot7:GetIndex() == slot0.selectItemIndex)
	end

	slot0.m_incidentBtn.interactable = true
end

function slot0.OnEventAction(slot0)
	if slot0.selectItemIndex == -1 then
		return
	end

	if not MatrixEventCfg[slot0.phasesParams[slot0.selectItemIndex]] then
		print("MatrixEventCfg cant find event by id :" .. slot1)

		return
	end

	slot4 = slot0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == slot2.event_type or MatrixConst.EVENT_TYPE.INCIDENT == slot2.event_type then
		if slot4 == 2 then
			MatrixAction.DoEvent()
		else
			MatrixAction.QueryNextProgress({
				slot1
			})
		end
	else
		JumpTools.OpenPageByJump("/sectionSelectHeroMatrix", {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX,
			section = slot2.params[1],
			eventId = slot1
		})
	end
end

function slot0.OnRewardAction(slot0)
	if slot0.selectItemIndex == -1 then
		return
	end

	if not (slot0.phasesParams[slot0.selectItemIndex] and MatrixItemCfg[slot1]) then
		print("MatrixItemCfg cant find item by id :" .. slot1)

		return
	end

	if MatrixConst.ITEM_TYPE.ASTROLABE == slot2.matrix_item_type then
		slot5 = slot0:GetHeroData(math.floor(slot2.params[1] / 1000))
		slot6 = slot5:GetAstrolabeList()

		if slot5:GetAstrolabeNum(slot2.params[1]) >= 3 then
			ShowTips("MATRIX_NOT_GET_ASTROLABEL")

			return
		end

		if slot0:GetAstrolabeMaxCount() <= #slot6 then
			JumpTools.OpenPageByJump("matrixProcessAstrolabeReplace", {
				heroId = slot4,
				astrolabeId = slot1,
				callback = function (slot0)
					MatrixAction.QueryNextProgress({
						uv0,
						slot0,
						uv1:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				slot1,
				0,
				slot5:GetStandardId()
			})
		end

		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3 then
		JumpTools.OpenPageByJump("matrixProcessSelectHero", {
			id = slot1
		})
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		if MatrixTools.GetWeaponSpecHero(slot2.params[1]) == 0 then
			JumpTools.OpenPageByJump("matrixProcessSelectHero", {
				id = slot1
			})
		elseif slot0:GetHeroData(slot4):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = slot4,
				weaponId = slot1,
				callback = function ()
					MatrixAction.QueryNextProgress({
						uv0,
						uv1,
						uv2:GetStandardId()
					})
				end
			})
		else
			MatrixAction.QueryNextProgress({
				slot1,
				0,
				slot5:GetStandardId()
			})
		end
	else
		MatrixAction.QueryNextProgress({
			slot1
		})
	end
end

function slot0.Dispose(slot0)
	if slot0.eventList_ then
		slot0.eventList_:Dispose()
	end

	if slot0.rewardList_ then
		slot0.rewardList_:Dispose()
	end

	if slot0.incidentList_ then
		slot0.incidentList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnMatrixUserUpdate(slot0)
	if MatrixConst.STATE_TYPE.STARTED == slot0:GetGameState() then
		slot0:Refresh(true)
	end
end

function slot0.GetGameState(slot0)
	return MatrixData:GetGameState()
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return MatrixData:GetAstrolabeMaxCount()
end

function slot0.GetMatrixPhaseData(slot0)
	return MatrixData:GetMatrixPhaseData()
end

function slot0.GetDifficulty(slot0)
	return MatrixData:GetDifficulty()
end

function slot0.GetGiveUpRewardAddition(slot0)
	return MatrixData:GetGiveUpRewardAddition()
end

function slot0.GetTierDes(slot0)
	slot2 = MatrixTierCfg[MatrixData:GetTierID()]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

return slot0
