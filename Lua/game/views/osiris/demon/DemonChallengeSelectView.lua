slot0 = class("DemonChallengeSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUIselectDifficultyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.levelIndex_ = slot0.params_.levelIndex
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "selectDifficulty")

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.completedUIController_1 = ControllerUtil.GetController(slot0.Level1Btn_.transform, "completed")
	slot0.completedUIController_2 = ControllerUtil.GetController(slot0.Level2Btn_.transform, "completed")
	slot0.completedUIController_3 = ControllerUtil.GetController(slot0.Level3Btn_.transform, "completed")
	slot0.completedUIController_ = {
		slot0.completedUIController_1,
		slot0.completedUIController_2,
		slot0.completedUIController_3
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityData(ActivityConst.OSIRIS_DEMON):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		DemonChallengeData:SetSelectDifficultyIndex(uv0.levelIndex_, uv0.difficultyIndex_)
		uv0:GetStageId()
		uv0:Go("/sectionSelectHero", {
			section = uv0.curStageId_,
			sectionType = BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
		})
	end)
	slot0:AddBtnListener(slot0.Level1Btn_, nil, function ()
		uv0:RefreshDifficult(1)
	end)
	slot0:AddBtnListener(slot0.Level2Btn_, nil, function ()
		uv0:RefreshDifficult(2)
	end)
	slot0:AddBtnListener(slot0.Level3Btn_, nil, function ()
		uv0:RefreshDifficult(3)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:UpdateData()
	slot0:RefreshUI()
end

function slot0.UpdateData(slot0)
	slot0.levelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex()
	slot0.difficultyIndex_ = DemonChallengeData:GetSelectDifficultyIndex(slot0.levelIndex_)

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshCompletedUI()
	slot0:RefreshSelectedUI()
	slot0:RefreshDesc()
end

function slot0.RefreshCompletedUI(slot0)
	slot1 = DemonChallengeData:GetCompletedList(slot0.levelIndex_)

	for slot5, slot6 in ipairs(slot0.completedUIController_) do
		if table.keyof(slot1, slot5) ~= nil then
			slot6:SetSelectedState("true")
		else
			slot6:SetSelectedState("false")
		end
	end
end

function slot0.RefreshDesc(slot0)
	slot1 = ""

	if slot0.difficultyIndex_ ~= nil then
		slot1 = DemonChallengeData:GetDifficultyDes(slot0.levelIndex_, slot0.difficultyIndex_)
	end

	slot0.descText_.text = slot1
end

function slot0.RefreshSelectedUI(slot0)
	if slot0.difficultyIndex_ == nil then
		slot0.selectController_:SetSelectedState("4")

		slot0.startBtn_.interactable = false
	else
		slot0.selectController_:SetSelectedState(tostring(slot0.difficultyIndex_))

		slot0.startBtn_.interactable = true
	end
end

function slot0.RefreshDifficult(slot0, slot1)
	slot0.difficultyIndex_ = slot1

	DemonChallengeData:SetSelectDifficultyIndex(slot0.levelIndex_, slot0.difficultyIndex_)
	slot0:RefreshUI()
	slot0:GetStageId()
end

function slot0.GetStageId(slot0)
	slot0.curStageId_ = DemonChallengeData:GetStageId(slot0.levelIndex_, slot0.difficultyIndex_)
end

return slot0
