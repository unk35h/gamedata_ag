slot0 = class("ActivityMatrixProcessView", MatrixProcessView)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.eventList_ = LuaList.New(handler(slot0, slot0.indexEventItem), slot0.m_eventList, ActivityMatrixProcessEventItem)
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.indexRewardItem), slot0.m_rewardList, ActivityMatrixProcessRewardItem)
	slot0.incidentList_ = LuaList.New(handler(slot0, slot0.indexIncidentItem), slot0.m_incidentList, MatrixProcessIncidentItem)
	slot0.phaseController_ = ControllerUtil.GetController(slot0.m_phaseController, "phase")
	slot0.hasGiveUpRewadController_ = ControllerUtil.GetController(slot0.m_phaseController, "hasGiveUpRewad")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardCommon, nil, function ()
		ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {})
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
				ActivityMatrixAction.QueryMatrixGiveUp(uv0.matrix_activity_id)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_incidentBtn, nil, function ()
		if uv0.selectItemIndex == -1 then
			return
		end

		ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
			uv0.incidentData[uv0.selectItemIndex]
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
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, slot0.matrix_activity_id)
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.OnEventAction(slot0)
	if slot0.selectItemIndex == -1 then
		return
	end

	if not ActivityMatrixEventTemplateCfg[slot0.phasesParams[slot0.selectItemIndex]] then
		print("ActivityMatrixEventTemplateCfg cant find event by id :" .. slot1)

		return
	end

	slot4 = slot0:GetMatrixPhaseData():GetPhase()

	if MatrixConst.EVENT_TYPE.SHOP == slot2.event_type or MatrixConst.EVENT_TYPE.INCIDENT == slot2.event_type then
		if slot4 == 2 then
			ActivityMatrixAction.DoEvent(slot0.matrix_activity_id)
		else
			ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1
			})
		end
	else
		JumpTools.OpenPageByJump("/sectionSelectHeroActivityMatrix", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX,
			section = slot2.params[1],
			eventId = slot1,
			matrix_activity_id = slot0.matrix_activity_id,
			activityID = slot0.matrix_activity_id
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
			JumpTools.OpenPageByJump("activityMatrixProcessAstrolabeReplace", {
				heroId = slot4,
				astrolabeId = slot1,
				callback = function (slot0)
					ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						slot0,
						uv2:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
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
				JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
					heroId = slot5,
					equipId = slot1,
					callback = function (slot0)
						ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
							uv1,
							slot0,
							uv2:GetStandardId()
						})
					end
				})
			else
				ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
					slot1,
					0,
					slot6:GetStandardId()
				})
			end
		else
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = slot1
			})
		end
	elseif MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot3 then
		slot5 = slot0:GetMatrixHeroTeam()

		if MatrixTools.GetWeaponSpecHero(slot2.params[1]) == 0 and #slot5 == 1 then
			slot4 = slot5[1]
		end

		if slot4 == 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessSelectHero", {
				id = slot1
			})
		elseif slot0:GetHeroData(slot4):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
				heroId = slot4,
				weaponId = slot1,
				callback = function ()
					ActivityMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						uv2,
						uv3:GetStandardId()
					})
				end
			})
		else
			ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1,
				0,
				slot6:GetStandardId()
			})
		end
	else
		ActivityMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
			slot1
		})
	end
end

function slot0.indexRewardItem(slot0, slot1, slot2)
	slot2:SetMatrixActivityId(slot0.matrix_activity_id)
	uv0.super.indexRewardItem(slot0, slot1, slot2)
end

function slot0.indexEventItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnEvengtItemClick))
	slot2:Refresh(slot0.phasesParams[slot1], slot1, slot0.matrix_activity_id)
	slot2:SetSelected(slot1 == slot0.selectItemIndex)
end

function slot0.GetGameState(slot0)
	return ActivityMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetAstrolabeMaxCount(slot0)
	return ActivityMatrixData:GetAstrolabeMaxCount(slot0.matrix_activity_id)
end

function slot0.GetMatrixPhaseData(slot0)
	return ActivityMatrixData:GetMatrixPhaseData(slot0.matrix_activity_id)
end

function slot0.GetDifficulty(slot0)
	return 1
end

function slot0.GetTierID(slot0)
	return ActivityMatrixData:GetTierID(slot0.matrix_activity_id)
end

function slot0.GetTierDes(slot0)
	slot2 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(slot0.matrix_activity_id)]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

function slot0.GetMatrixHeroTeam(slot0)
	return ActivityMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot0.GetHeroEquipMaxCount(slot0)
	return ActivityMatrixData:GetHeroEquipMaxCount(slot0.matrix_activity_id)
end

return slot0
