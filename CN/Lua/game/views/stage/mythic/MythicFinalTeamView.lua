slot0 = class("MythicFinalTeamView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicTeamToPrepareUI"
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

	slot0.changehandler_ = handler(slot0, slot0.OnChangeBtnClick)
	slot0.confirmhandler_ = handler(slot0, slot0.OnConfirmBtnClick)
	slot0.changeindex_1 = 0
	slot0.changeindex_2 = 0
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "isBattleIng")
	slot0.heroList_ = LuaList.New(handler(slot0, slot0.indexHeroList), slot0.uilistGo_, MythicFinalTeamViewItem)
end

function slot0.OnChangeBtnClick(slot0, slot1)
	if slot0.changeindex_1 == 0 then
		slot0.changeindex_1 = slot1

		for slot6, slot7 in pairs(slot0.heroList_:GetItemList()) do
			slot7:OnChangeRefreshStatus(slot1)
		end

		SetActive(slot0.btn_resetGo_, false)
		SetActive(slot0.btn_warbeganGo_, false)
	else
		slot0:ResetStatus()
	end
end

function slot0.OnConfirmBtnClick(slot0, slot1)
	slot0.changeindex_2 = slot1

	if slot0.changeindex_1 ~= 0 and slot0.changeindex_2 ~= 0 then
		MythicAction.SwapTeam(slot0.changeindex_1, slot0.changeindex_2, function ()
			uv0.heroList_:StartScroll(uv0.times_)
		end)
	end

	slot0:ResetStatus()
end

function slot0.ResetStatus(slot0)
	slot0.changeindex_1 = 0
	slot0.changeindex_2 = 0

	for slot5, slot6 in pairs(slot0.heroList_:GetItemList()) do
		slot6:ResetState()
	end

	SetActive(slot0.btn_warbeganGo_, true)
	SetActive(slot0.btn_resetGo_, true)
end

function slot0.indexHeroList(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.battleList_[slot1], #slot0.battleList_)
	slot2:RegionHandler(slot0.changehandler_, slot0.confirmhandler_)
end

function slot0.LaunchBattle(slot0)
	if not MythicData:CheckCanEnterMutiBattle(#MythicData:GetCurLevelIdList()) then
		ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

		return
	end

	slot1 = {}

	for slot5 = 1, slot0.times_ do
		slot1[slot5] = BattleMythicFinalTemplate.New(slot0.battleList_[slot5], slot0.activityID_, {
			teamID = slot5,
			teamLength = #slot0.battleList_
		})

		if slot5 > 1 then
			slot1[slot5 - 1]:SetNextStage(slot1[slot5])
		end
	end

	BattleController.GetInstance():LaunchBattle(slot1[1])
end

function slot0.ContinueBattle(slot0)
	slot1 = {}

	for slot5 = 1, slot0.times_ do
		slot1[slot5] = BattleMythicFinalTemplate.New(slot0.battleList_[slot5], slot0.activityID_, {
			teamID = slot5,
			teamLength = #slot0.battleList_
		})

		if slot5 > 1 then
			slot1[slot5 - 1]:SetNextStage(slot1[slot5])
		end
	end

	BattleController.GetInstance():LaunchBattle(slot1[MythicData:GetCurBattleIndex()])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_warbeganBtn_, nil, function ()
		if MythicData:GetIsNew() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("MYTHIC_REFRESH_DATA"),
				OkCallback = function ()
					JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
				end
			})

			return
		end

		MythicAction.SaveAllTeam(handler(uv0, uv0.LaunchBattle))
	end)
	slot0:AddBtnListener(slot0.btn_resetBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("MYTHIC_TEAM_RESET"),
			OkCallback = function ()
				MythicAction.ReSetTeam(function ()
					uv0.heroList_:StartScroll(uv0.times_)
				end)
			end
		})
	end)
	slot0:AddBtnListener(slot0.btn_restart_, nil, function ()
		ShowMessageBox({
			content = GetTips("MYTHIC_PROCESS_RECORD"),
			OkCallback = function ()
				MythicAction.QuitBattle()
			end
		})
	end)
	slot0:AddBtnListener(slot0.btn_continue_, nil, function ()
		if MythicData:GetIsNew() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("MYTHIC_REFRESH_DATA"),
				OkCallback = function ()
					JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
				end
			})

			return
		end

		uv0:ContinueBattle()
	end)
end

function slot0.OnMythicFinalQuitBattle(slot0)
	slot0:RefreshUIStatu()

	slot0.timeText_.text = manager.time:DescCdTime2(MythicData:GetCurTime())
end

function slot0.OnEnter(slot0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function ()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return
	end

	slot0.times_ = #MythicData:GetCurLevelIdList()
	slot0.battleList_ = MythicData:GetCurLevelIdList()
	slot0.activityID_ = ActivityConst.MYTHIC_FINAL
	slot0.timeText_.text = manager.time:DescCdTime2(MythicData:GetCurTime())

	slot0:RefreshUIStatu()
end

function slot0.RefreshUIStatu(slot0)
	if MythicData:GetIsBattleIng() then
		slot0.controller_:SetSelectedState("true")

		slot0.battleText_.text = string.format(GetTips("MYTHIC_FINAL_BASTTLE_TIPS"), MythicData:GetCurHotLevelId()) .. GetTips("TEAM_" .. MythicData:GetCurBattleIndex())
	else
		slot0.controller_:SetSelectedState("false")
	end

	slot0.heroList_:Refresh()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.changeindex_1 ~= 0 then
			uv0:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	slot0.heroList_:StartScroll(slot0.times_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.heroList_ then
		slot0.heroList_:Dispose()

		slot0.heroList_ = nil
	end

	slot0.changehandler_ = nil
	slot0.confirmhandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
