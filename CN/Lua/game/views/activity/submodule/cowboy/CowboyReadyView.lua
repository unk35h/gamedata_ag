slot0 = class("CowboyReadyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeSignXiuGmaeUI"
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
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		CowboyData:SetLastLevel(uv0.mainActivityID_, uv0.activityID_)
		JumpTools.OpenPageByJump("/cowboyGame", {
			mainActivityID = uv0.mainActivityID_,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.mainActivityID_ = slot0.params_.mainActivityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.title_.text = string.format(GetTips("ACTIVITY_COWBOY_ROUND"), slot0.params_.index)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
