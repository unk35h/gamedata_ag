slot0 = class("SettingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Setting/SettingUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeNameS_ = {
		polyhedronAddition = 9,
		intelligence = 2,
		remind = 9,
		sound = 3,
		artifact = 7,
		affix = 5,
		game = 4,
		screen = 1,
		skill = 6,
		operation = 8,
		polyhedronTeamInfo = 10
	}
	slot0.toggle_ = {}
	slot0.toggleSelect_ = {}
	slot0.toggleUnSelect_ = {}

	for slot4, slot5 in pairs(slot0.typeNameS_) do
		slot0.toggle_[slot4] = slot0[slot4 .. "Tgl_"]
		slot0.toggleUnSelect_[slot4] = slot0[slot4 .. "UnselectGo_"]
		slot0.toggleSelect_[slot4] = slot0[slot4 .. "SelectGo_"]
	end

	slot0.viewList_ = {}
	slot0.viewListGo_ = {}
end

function slot0.ChangeShowView(slot0, slot1, slot2)
	if slot2 then
		slot0:RecordStay(slot0.params_.selectType)

		slot0.params_.selectType = slot1
	end

	if slot0.viewListGo_[slot1] then
		SetActive(slot0.viewListGo_[slot1], slot2)
	elseif slot2 then
		if slot1 == "screen" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/GraphicSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = GraphicSettingView.New(slot0, slot0.viewListGo_[slot1])
		elseif slot1 == "intelligence" then
			if slot0.params_.stageData and slot3:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/VariableSettingUI"), slot0.panelTrs_)
				slot0.viewList_[slot1] = MatrixStageSettingView.New(slot0.viewListGo_[slot1], BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX)
			elseif slot3 and (slot3:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot3:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
				slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/VariableSettingUI"), slot0.panelTrs_)
				slot0.viewList_[slot1] = MatrixStageSettingView.New(slot0.viewListGo_[slot1], slot3:GetType(), slot3:GetActivityID())
			else
				slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/IntelligenceUI"), slot0.panelTrs_)
				slot0.viewList_[slot1] = IntelligenceView.New(slot0, slot0.viewListGo_[slot1], slot0.params_)
			end
		elseif slot1 == "sound" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/SoundSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = SoundSettingView.New(slot0, slot0.viewListGo_[slot1])
		elseif slot1 == "game" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/GameSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = GameSettingView.New(slot0, slot0.viewListGo_[slot1], slot0.params_)
		elseif slot1 == "operation" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/GameOperationSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = GameOperationSettingView.New(slot0, slot0.viewListGo_[slot1], slot0.params_)
		elseif slot1 == "affix" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/AffixDescriptionUI"), slot0.panelTrs_)

			if slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE then
				slot0.viewList_[slot1] = SoloChallengeAffixDescriptionView.New(slot0, slot0.viewListGo_[slot1], slot0.dataAffix)
			else
				slot0.viewList_[slot1] = AffixDescriptionView.New(slot0, slot0.viewListGo_[slot1], slot0.dataAffix)
			end
		elseif slot1 == "skill" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/SkillSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = SkillDescriptionView.New(slot0, slot0.viewListGo_[slot1], slot0.params_.stageData)
		elseif slot1 == "artifact" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/InformationSettingUI"), slot0.panelTrs_)

			if slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				slot0.viewList_[slot1] = MatrixArtifactSettingView.New(slot0.viewListGo_[slot1], MatrixData:GetArtifactList())
			elseif slot4:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
				slot0.viewList_[slot1] = MatrixArtifactSettingView.New(slot0.viewListGo_[slot1], ActivityMatrixData:GetArtifactList(slot4:GetActivityID()))
			elseif slot4:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
				slot0.viewList_[slot1] = MatrixArtifactSettingView.New(slot0.viewListGo_[slot1], StrategyMatrixData:GetArtifactList(slot4:GetActivityID()))
			elseif slot4:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
				slot6 = {}

				for slot10, slot11 in pairs(WarChessData:GetArtifactData()) do
					table.insert(slot6, {
						id = slot10
					})
				end

				slot0.viewList_[slot1] = WarChessArtifactSettingView.New(slot0.viewListGo_[slot1], slot6)
			end
		elseif slot1 == "remind" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/Setting/RemindSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = RemindSettingView.New(slot0, slot0.viewListGo_[slot1])
		elseif slot1 == "polyhedronAddition" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/PolyhedronBattle/PolyhedronSettingUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = PolyhedronAdditionSettingView.New(slot0.viewListGo_[slot1])
		elseif slot1 == "polyhedronTeamInfo" then
			slot0.viewListGo_[slot1] = Object.Instantiate(Asset.Load("UI/PolyhedronBattle/PolyhedronRanksUI"), slot0.panelTrs_)
			slot0.viewList_[slot1] = PolyhedronTeamInfoSettingView.New(slot0.viewListGo_[slot1])
		end
	end
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in pairs(slot0.typeNameS_) do
		slot0:AddToggleListener(slot0.toggle_[slot4], function (slot0)
			if slot0 then
				OperationRecorder.Record(uv0.class.__cname, "switch_page_" .. uv1)

				if uv1 == "remind" then
					saveData("setting", "newFunction", 0)
					manager.redPoint:setTip(RedPointConst.SETTING_NEW_FUNCTION, 0)
				end
			end

			SetActive(uv0.toggleUnSelect_[uv1], not slot0)
			SetActive(uv0.toggleSelect_[uv1], slot0)
			uv0:ChangeShowView(uv1, slot0)
		end)
	end

	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		for slot3, slot4 in pairs(uv0.viewList_) do
			slot4:SaveData()
		end

		ShowTips("SAVE_SYSTEM_SETTING")
	end)
	slot0:AddBtnListenerScale(slot0.resetBtn_, nil, function ()
		uv0.viewList_[uv0.params_.selectType]:RecoverTmpData()
	end)
	slot0:AddBtnListenerScale(slot0.quitBattleBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function ()
				gameContext:DestroyCurRoutes()

				if uv0.params_.stageData:GetIsCooperation() then
					CooperationAction.LeaveCooperationBattle(function (slot0)
						BattleInstance.QuitBattle(uv0.params_.stageData, true)
					end)
				else
					LuaExchangeHelper.GameOver(3)
				end
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.continueBtn_, nil, function ()
		if uv0:GetIsContinuousFight() then
			uv0:Back()
		else
			gameContext:DestroyCurRoutes()
		end

		LuaExchangeHelper.ContinueGame()
	end)
	slot0:AddBtnListenerScale(slot0.restartBtn_, nil, function ()
		manager.audio:DestoryCriAtom()
		BattleController.GetInstance():LaunchBattle(uv0.params_.stageData)
	end)
	slot0:AddBtnListenerScale(slot0.polyhedronSettlementBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_BATTLE_GIVE_UP_AND_SETTLE"),
			OkCallback = function ()
				PolyhedronAction.QueryPolyhedronGiveUp(function (slot0)
					if isSuccess(slot0.result) then
						manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.acb")
						DestroyLua()
						LuaExchangeHelper.GoToMain()
						OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
					else
						ShowTips(slot0.result)
					end
				end)
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.polyhedronQuitBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("GIVE_UP_BATTLE"),
			OkCallback = function ()
				manager.audio:PlayBGM("ui_battle", "ui_battle_lose", "ui_battle.acb")
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	end)
end

function slot0.GetIsContinuousFight(slot0)
	if slot0.isSystem_ or slot0.params_.stageData == nil then
		return false
	end

	return slot0.params_.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON
end

function slot0.RefreshSettingType(slot0)
	slot2 = slot0.params_.stageData
	slot0.isSystem_ = (slot0.params_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	SetActive(slot0.screenGo_, slot0.isSystem_)
	SetActive(slot0.saveGo_, slot0.isSystem_)
	SetActive(slot0.resetGo_, slot0.isSystem_)
	SetActive(slot0.remindGo_, slot0.isSystem_)
	SetActive(slot0.quitBattleGo_, not slot0.isSystem_ and not slot0.params_.newbie and slot2:GetType() ~= BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(slot0.continueGo_, not slot0.isSystem_)
	SetActive(slot0.polyhedronSettlementGo_, not slot0.isSystem_ and slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)
	SetActive(slot0.polyhedronQuitGo_, not slot0.isSystem_ and slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON)

	if not slot0.isSystem_ and slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON) then
		SetActive(slot0.restartGo_, true)
	else
		SetActive(slot0.restartGo_, false)
	end

	slot3 = slot2 and not slot0.isSystem_ and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
	slot4 = slot2 and not slot0.isSystem_ and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON

	if not slot0.isSystem_ and not slot3 and not slot4 then
		slot0.dataAffix = {}

		for slot9 = 0, LuaExchangeHelper.GetCurrentAffixInScene().Count - 1 do
			slot10 = slot5[slot9]

			table.insert(slot0.dataAffix, {
				slot10.x,
				slot10.y
			})
		end

		SetActive(slot0.affixGo_, #slot0.dataAffix > 0)
	else
		SetActive(slot0.affixGo_, false)
	end

	if slot2 and not slot0.isSystem_ and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		SetActive(slot0.intelligenceGo_, true)
	else
		SetActive(slot0.intelligenceGo_, false)
	end

	if slot0.isSystem_ or not slot2 or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.SKADI_GAME or table.keyof(GameSetting.setting_need_not_skill_info.value, slot2:GetStageId()) then
		SetActive(slot0.skillGo_, false)
	else
		SetActive(slot0.skillGo_, true)
	end

	if slot2 and not slot0.isSystem_ and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ARTIFACT then
		SetActive(slot0.affixGo_, false)
	end

	if slot2 and not slot0.isSystem_ and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL then
		SetActive(slot0.affixGo_, false)
	end

	if not slot0.isSystem_ then
		if slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS) then
			SetActive(slot0.artifactGo_, true)
			SetActive(slot0.affixGo_, false)
		else
			SetActive(slot0.artifactGo_, false)
		end
	else
		SetActive(slot0.artifactGo_, false)
	end

	if slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		SetActive(slot0.polyhedronAdditionGo_, true)
		SetActive(slot0.polyhedronTeamInfoGo_, true)
	else
		SetActive(slot0.polyhedronAdditionGo_, false)
		SetActive(slot0.polyhedronTeamInfoGo_, false)
	end

	if slot1 == SettingConst.SETTING_TYPE.SYSTEM then
		slot0.toggle_.screen.isOn = true

		slot0:ChangeShowView("screen", true)

		slot0.params_.selectType = "screen"
	elseif slot1 == SettingConst.SETTING_TYPE.BATTLE_MAIN or slot2 and (slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX or slot2:GetType() == BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX) then
		slot0.toggle_.intelligence.isOn = true
		slot0.params_.selectType = "intelligence"
	elseif slot2 and slot2:GetType() == BattleConst.STAGE_TYPE_NEW.POLYHEDRON then
		slot0.toggle_.polyhedronAddition.isOn = true

		slot0:ChangeShowView("polyhedronAddition", true)

		slot0.params_.selectType = "polyhedronAddition"
	else
		slot0.toggle_.sound.isOn = true
		slot0.params_.selectType = "sound"
	end

	slot0:RefreshQuitType()
end

function slot0.RefreshQuitType(slot0)
	if slot0.isSystem_ then
		slot1 = manager.windowBar

		slot1:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			NAVI_BAR
		})

		slot1 = manager.windowBar

		slot1:RegistBackCallBack(function ()
			slot0 = uv0

			slot0:BackFunc(function ()
				uv0:Back()
			end)
		end)

		slot1 = manager.windowBar

		slot1:RegistHomeCallBack(function ()
			slot0 = uv0

			slot0:BackFunc(function ()
				uv0:Go("/home")
			end)
		end)
	end
end

function slot0.BackFunc(slot0, slot1)
	slot2 = false

	for slot6, slot7 in pairs(slot0.viewList_) do
		if slot7:CheckDataChange() then
			slot2 = true
		end
	end

	if slot2 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SETTING_CHANGE"),
			OkCallback = function ()
				for slot3, slot4 in pairs(uv0.viewList_) do
					slot4:SaveData()
				end

				OperationRecorder.Record(uv0.class.__cname, "panel/btn_save")
				uv1()
			end,
			CancelCallback = function ()
				for slot3, slot4 in pairs(uv0.viewList_) do
					slot4:RecoverTmpData()
				end

				OperationRecorder.Record(uv0.class.__cname, "cancel")
				uv1()
			end
		})
	else
		slot1()
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnPicSettingChange(slot0, slot1, slot2)
	if slot0.viewList_.screen then
		slot0.viewList_.screen:OnPicSettingChange(slot1, slot2)
	end
end

function slot0.OnSoundSettingChange(slot0, slot1, slot2)
	if slot0.viewList_.sound then
		slot0.viewList_.sound:OnSoundSettingChange(slot1, slot2)
	end
end

function slot0.OnPushSettingChange(slot0, slot1, slot2)
end

function slot0.OnGameSettingChange(slot0, slot1, slot2)
	if slot0.viewList_.game then
		slot0.viewList_.game:OnGameSettingChange(slot1, slot2)
	end
end

function slot0.OnDownloaded(slot0, slot1)
	if slot0.viewList_.sound then
		slot0.viewList_.sound:OnDownloaded(slot1)
	end
end

function slot0.OnCancalDownload(slot0)
	if slot0.viewList_.sound then
		slot0.viewList_.sound:OnCancalDownload()
	end
end

function slot0.OnLanguagePackageDeleted(slot0)
	if slot0.viewList_.sound then
		slot0.viewList_.sound:OnLanguagePackageDeleted()
	end
end

function slot0.OnRemindChange(slot0, slot1, slot2)
	if slot0.viewList_.remind then
		slot0.viewList_.remind:OnRemindChange(slot1, slot2)
	end
end

function slot0.OnCooperationRestrictUpdate(slot0, slot1, slot2)
	if slot0.viewList_.remind then
		slot0.viewList_.remind:OnCooperationRestrictUpdate()
	end
end

function slot0.OnPolyhedronSwitchHero(slot0)
	if slot0.viewList_.polyhedronTeamInfo then
		slot0.viewList_.polyhedronTeamInfo:OnPolyhedronSwitchHero()
	end
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in pairs(slot0.viewList_) do
		if slot4 == "intelligence" then
			if slot0.params_.stageData and slot6:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
				-- Nothing
			elseif slot6 and slot6:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX then
				-- Nothing
			elseif not slot6 or slot6:GetType() ~= BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX then
				slot5:RefreshData(nil, slot0.params_)
			end
		else
			slot5:OnEnter()
		end
	end

	slot0:RefreshSettingType()
	slot0:BindRedPointUI()
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.toggle_.remind.transform, RedPointConst.SETTING_NEW_FUNCTION)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.toggle_.remind.transform, RedPointConst.SETTING_NEW_FUNCTION)
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPointUI()

	for slot4, slot5 in pairs(slot0.viewList_) do
		slot5:OnExit()
	end

	if slot0.isSystem_ then
		manager.windowBar:HideBar()
	else
		LuaExchangeHelper.ApplyBattleSetting()
	end

	slot0.isSystem_ = nil

	slot0:RecordStay(slot0.params_.selectType)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.viewList_) do
		slot5:Dispose()
	end

	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == "screen" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10201)
	elseif slot1 == "sound" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10202)
	elseif slot1 == "game" then
		OperationRecorder.RecordStayView("STAY_VIEW_SETTING", slot2, 10203)
	elseif slot1 == "skill" then
		slot0:RecordStaySkill(slot0.viewList_.skill and slot0.viewList_.skill.nType or 1)
	end

	slot0:UpdateLastOpenTime()
end

function slot0.RecordStaySkill(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == 1 then
		slot3 = 50201
	elseif slot1 == 2 then
		slot3 = 50202
	end

	OperationRecorder.RecordStayView("STAY_VIEW_SETTING_SKILL", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
