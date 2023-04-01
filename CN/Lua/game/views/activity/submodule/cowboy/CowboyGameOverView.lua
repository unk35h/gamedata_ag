slot0 = class("CowboyGameOverView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeXiuGameSettlementUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scoreCon_ = ControllerUtil.GetController(slot0.transform_, "score")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.leaveBtn_, nil, function ()
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.onceMoreBtn_, nil, function ()
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = uv0.mainActivityID_,
			activityID = uv0.activityID_
		})
		manager.notify:CallUpdateFunc(COWBOY_RESTART)
	end)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.params_.score <= CowboyData:GetHistoryScore(slot0.activityID_) then
		slot0.highest_.text = slot1

		slot0.scoreCon_:SetSelectedState("normal")
	else
		CowboyData:SetScore(slot0.activityID_, slot0.params_.score)

		slot0.highest_.text = slot0.params_.score

		slot0.scoreCon_:SetSelectedState("new")
	end

	slot0.score_.text = slot0.params_.score
end

function slot0.OnExit(slot0)
	manager.audio:Pause("music", false)
	manager.audio:Stop("music", true)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
