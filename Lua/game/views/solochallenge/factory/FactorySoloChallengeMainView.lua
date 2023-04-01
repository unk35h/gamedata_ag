slot1 = class("FactorySoloChallengeMainView", import("game.views.soloChallenge.SoloChallengeMainView"))

function slot1.UIName(slot0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeMain"
end

function slot1.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchItemList_ = {}
	slot0.rewardItemList_ = {}
	slot0.onClickHandler_ = handler(slot0, slot0.OnClick)
	slot4 = "SelfAdaptImage"
	slot0.adaptImg_ = slot0:FindCom(slot4, nil, slot0.roleTras_)
	slot0.difficultyStateList_ = {}

	for slot4 = 1, 3 do
		slot0.difficultyStateList_[slot4] = ControllerUtil.GetController(slot0["diffcultyState_" .. slot4], "complete")
	end

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot1.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("FACTORY_ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeReward", {
			activityID = uv0.selectActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
			activityID = uv0.selectActivityID_
		})
	end)
end

function slot1.OnExit(slot0)
	slot0:UnbindRewardRedPoint()
	uv0.super.OnExit(slot0)
end

function slot1.RefreshUI(slot0)
	slot0.subActivityList_ = ActivityCfg[slot0.activityID_].sub_activity_list
	slot1 = SoloChallengeData:GetSelectActivityID(slot0.activityID_) or slot0.subActivityList_[1]

	slot0:BindRewardRedPoint(slot1)

	slot0.selectActivityID_ = slot1

	if slot0.selectActivityID_ == nil then
		return
	end

	slot0.selectController_:SetSelectedState(tostring(table.indexof(slot0.subActivityList_, slot0.selectActivityID_) or 1))
	SoloChallengeData:SetSelectActivityID(slot0.activityID_, slot0.selectActivityID_)
	slot0:RefreshSwitchItem()
	slot0:RefreshRoleImage()
	slot0:RefreshDesc()
	slot0:RefreshDifficultyState()
end

function slot1.RefreshDifficultyState(slot0)
	slot1 = SoloChallengeData:GetCompletedActivityList()[slot0.selectActivityID_]

	for slot5, slot6 in ipairs(slot0.difficultyStateList_) do
		if table.keyof(slot1, slot5) ~= nil then
			slot6:SetSelectedState("true")
		else
			slot6:SetSelectedState("false")
		end
	end
end

function slot1.RefreshActivityDesc(slot0)
	slot0.activityDescText_.text = GetTips("FACTORY_ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function slot1.BindRewardRedPoint(slot0, slot1)
	slot2 = SoloChallengeData:GetCompletedActivityList()[slot1]
	slot3 = SoloChallengeData:GetReceivedActivityList()[slot1]
	slot4 = nil

	if slot0.boundRedPoint_ == true and slot0.selectActivityID_ ~= slot1 then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0.activityID_, slot0.selectActivityID_))
	end

	if #slot2 > #slot3 then
		manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0.activityID_, slot1))

		slot0.boundRedPoint_ = true
	else
		slot0.boundRedPoint_ = false
	end
end

function slot1.UnbindRewardRedPoint(slot0)
	if slot0.boundRedPoint_ then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot0.activityID_, slot0.selectActivityID_))
	end
end

function slot1.RefreshRoleImage(slot0)
end

function slot1.GetSwitchItemClass(slot0)
	return FactorySoloChallengeSwitchItem
end

return slot1
