slot0 = class("NewDemonChallengeDifficultySelectView", ReduxView)

function slot0.UIName(slot0)
	return nil
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitGo(slot0, slot1)
	if slot0.gameObject_ then
		slot0:Dispose()
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot1), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

slot1 = 3

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "selectDifficulty"
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.completedUIControllerS_ = {}

	for slot4 = 1, uv0 do
		slot0.completedUIControllerS_[slot4] = ControllerUtil.GetController(slot0[string.format("Level%dBtn_", slot4)].transform, "completed")
	end

	slot0.startImg_ = slot0.startBtn_.gameObject:GetComponent(typeof(Image))
	slot0.affixItemList_ = {}
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.startBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.difficultyIndex_ == nil then
			ShowTips("SELECT_CURRENT")

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = DemonChallengeTools.GetStageId(uv0.activityId_, uv0.difficultyIndex_, true),
			sectionType = BattleConst.STAGE_TYPE_NEW.NEW_DEMON,
			activityID = DemonChallengeTools.GetChildId(uv0.activityId_, uv0.difficultyIndex_, true)
		})
	end)

	for slot4 = 1, uv0 do
		slot0:AddBtnListener(slot0[string.format("Level%dBtn_", slot4)], nil, function ()
			if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
				ShowTips("TIME_OVER")

				return
			end

			uv0:RefreshDifficult(uv1)
		end)
	end
end

function slot0.OnEnter(slot0)
	if not slot0.activityId_ or slot0.params_.selectId ~= slot0.activityId_ then
		slot0.activityId_ = slot0.params_.selectId

		if not slot0.mainActivityId_ or slot0.params_.activityId ~= slot0.mainActivityId_ then
			slot0.mainActivityId_ = slot0.params_.activityId

			slot0:InitGo(DemonChallengeTools.GetDifficultyUIName(slot0.params_.activityId))
		end
	end

	slot0:RefreshCompletedUI()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshSelectedUI()
	slot0:RefreshDesc()

	if NewDemonChallengeData:GetChallengeInfo(slot0.activityId_).challengeInfo then
		slot3 = slot1.challengeInfo[3].hurt_state

		if slot1.challengeInfo[3].challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.FINISHED and slot3 == ActivityConst.DEMON_CHALLENGE_HURT_STATE.NO_HURT then
			slot0.completedUIControllerS_[3]:SetSelectedState("nodamag")
		end
	end
end

function slot0.RefreshCompletedUI(slot0)
	slot1 = NewDemonChallengeData:GetChallengeInfo(slot0.activityId_)

	for slot5 = 1, uv0 do
		if slot1.challengeInfo and slot1.challengeInfo[slot5].challenge_state ~= ActivityConst.DEMON_CHALLENGE_STATE.FINISHED then
			slot0.completedUIControllerS_[slot5]:SetSelectedState("false")
		else
			slot0.completedUIControllerS_[slot5]:SetSelectedState("true")
		end
	end
end

function slot0.RefreshDesc(slot0)
	slot1 = ""

	if slot0.difficultyIndex_ ~= nil and DemonChallengeTools.GetChildId(slot0.activityId_, slot0.difficultyIndex_, true) then
		slot1 = NewDemonChallengeCfg[slot2].difficulty_desc
	end

	if slot0.descText_ then
		slot0.descText_.text = slot1
	end
end

function slot0.RefreshSelectedUI(slot0)
	if slot0.difficultyIndex_ == nil then
		slot0.selectController_:SetSelectedState(tostring(uv0 + 1))

		if slot0.startImg_ then
			manager.effect:SetGrey(slot0.startImg_, true)
		end
	else
		slot0.selectController_:SetSelectedState(tostring(slot0.difficultyIndex_))

		if slot0.startImg_ then
			manager.effect:SetGrey(slot0.startImg_, false)
		end
	end
end

function slot0.RefreshDifficult(slot0, slot1)
	slot0.difficultyIndex_ = slot1

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
