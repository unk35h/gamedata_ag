slot0 = class("StrategyMatrixProcessView", MatrixProcessView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatrixProcessUI"
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.m_rewardList, StrategyMatrixProcessRewardItem)
	slot0.incidentList_ = LuaList.New(handler(slot0, slot0.indexIncidentItem), slot0.m_incidentList, MatrixProcessIncidentItem)
	slot0.phaseController_ = ControllerUtil.GetController(slot0.m_phaseController, "phase")
	slot0.hasGiveUpRewadController_ = ControllerUtil.GetController(slot0.m_phaseController, "hasGiveUpRewad")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardCommon, nil, function ()
		StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		uv0:OnRewardAction()
	end)
	slot0:AddBtnListener(slot0.m_giveUpBtn, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_MATRIX"),
			OkCallback = function ()
				StrategyMatrixAction.QueryMatrixGiveUp(uv0.matrix_activity_id)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_incidentBtn, nil, function ()
		if uv0.selectItemIndex == -1 then
			return
		end

		StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
			uv0.incidentData[uv0.selectItemIndex]
		})
	end)
	slot0:AddBtnListener(slot0.m_infoBtn, nil, function ()
		JumpTools.OpenPageByJump("/strategyMatrixHero", {
			matrix_activity_id = uv0.matrix_activity_id,
			heroId = StrategyMatrixData:GetMatrixHeroTeam(uv0.matrix_activity_id)[1]
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(slot0.matrix_activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")

	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function slot0.Refresh(slot0, slot1)
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
	elseif slot2 == 2 then
		if MatrixConst.EVENT_TYPE.INCIDENT == StrategyMatrixEventTemplateCfg[slot0.phasesParams[1]].event_type then
			slot0.incidentData = {}

			for slot10, slot11 in ipairs(StrategyMatrixChanceCfg.get_id_list_by_title_id[slot0.phaseData:GetData()]) do
				table.insert(slot0.incidentData, StrategyMatrixChanceCfg[slot11].option)
			end

			slot0.m_incidentTitle.text = MatrixDescCfg[slot5] and MatrixDescCfg[slot5].desc or ""

			slot0.phaseController_:SetSelectedIndex(3)
			slot0.incidentList_:StartScroll(#slot0.incidentData)
		elseif not slot1 then
			slot0.phaseController_:SetSelectedIndex(0)
		end
	elseif slot2 == 3 then
		if slot0.matrixGiveUpItemId and slot0.matrixGiveUpItemId ~= 0 then
			slot0.hasGiveUpRewadController_:SetSelectedIndex(1)

			if MatrixConst.ITEM_TYPE.ITEM == MatrixItemCfg[slot0.matrixGiveUpItemId].matrix_item_type and #slot3.params > 0 then
				slot5 = slot3.params[1][2]

				if slot3.params[1][1] == CurrencyConst.CURRENCY_TYPE_MATRIX_COIN then
					slot5 = slot5 * (1 + slot0:GetGiveUpRewardAddition())
				end

				slot0.m_rewardCommonText.text = string.format(GetTips("MATRIX_GET"), slot5, slot3.name)
			else
				slot0.m_rewardCommonText.text = slot3.desc
			end
		else
			slot0.hasGiveUpRewadController_:SetSelectedIndex(0)
		end

		slot0.phaseController_:SetSelectedIndex(2)
		slot0.rewardList_:StartScroll(#slot0.phasesParams)
	else
		slot0.phaseController_:SetSelectedIndex(0)
	end

	slot0.m_difficultyLab.text = slot0:GetDifficulty() == 1 and GetTips("HARDLEVEL_EASY") or GetTips("HARDLEVEL_HARD")
	slot0.m_tierLab.text = slot0:GetTierDes()
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
			JumpTools.OpenPageByJump("strategyMatrixProcessAstrolabeReplace", {
				heroId = slot4,
				astrolabeId = slot1,
				callback = function (slot0)
					StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						slot0,
						uv2:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1,
				0,
				slot5:GetStandardId()
			})
		end

		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3 then
		if #slot0:GetMatrixHeroTeam() == 1 then
			if slot0:GetHeroEquipMaxCount() <= #slot0:GetHeroData(slot4[1]):GetEquipList() then
				JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
					heroId = slot5,
					equipId = slot1,
					callback = function (slot0)
						StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
							uv1,
							slot0,
							uv2:GetStandardId()
						})
					end
				})
			else
				StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
					slot1,
					0,
					slot6:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = slot1
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		slot5 = slot0:GetMatrixHeroTeam()

		if MatrixTools.GetWeaponSpecHero(slot2.params[1]) == 0 and #slot5 == 1 then
			slot4 = slot5[1]
		end

		if slot4 == 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessSelectHero", {
				id = slot1
			})
		elseif slot0:GetHeroData(slot4):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
				heroId = slot4,
				weaponId = slot1,
				callback = function ()
					StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						uv2,
						uv3:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1,
				0,
				slot6:GetStandardId()
			})
		end
	else
		StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
			slot1
		})
	end
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot2:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.indexRewardItem(slot0, slot1, slot2)
end

function slot0.GetGameState(slot0)
	return StrategyMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot0.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return StrategyMatrixData:GetAstrolabeMaxCount(slot0.matrix_activity_id)
end

function slot0.GetMatrixPhaseData(slot0)
	return StrategyMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

function slot0.GetDifficulty(slot0)
	return 1
end

function slot0.GetTierID(slot0)
	return StrategyMatrixData:GetTierID(slot0.matrix_activity_id)
end

function slot0.GetTierDes(slot0)
	slot2 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(slot0.matrix_activity_id)]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

function slot0.GetMatrixHeroTeam(slot0)
	return StrategyMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot0.GetHeroEquipMaxCount(slot0)
	return StrategyMatrixData:GetHeroEquipMaxCount(slot0.matrix_activity_id)
end

function slot0.GetGiveUpRewardAddition(slot0)
	return StrategyMatrixData:GetGiveUpRewardAddition(slot0.matrix_activity_id)
end

return slot0
