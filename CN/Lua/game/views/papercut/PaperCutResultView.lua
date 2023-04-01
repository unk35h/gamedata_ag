slot0 = class("PaperCutResultView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/EmptyDream/PaperCut/PaperCutResultUI"
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

	slot0.resultImage_ = slot0.resultImageGo_:GetComponent("PaperCutUIImage")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.titleText_.text = PaperCutCfg[slot0.activityID_].name

	slot0:RefreshImage()
	slot0:RefreshScore()
end

function slot0.RefreshImage(slot0)
	PaperCutTool:DisplayResultImage(slot0.resultImage_)

	if slot0.scorePanelTrans_.localPosition.y >= slot0.resultImageTrans_.localPosition.y - slot0.resultImageTrans_.sizeDelta.y * 0.5 then
		slot3.y = slot1.y - slot2.y * 0.5 - 40
		slot0.scorePanelTrans_.localPosition = slot3
	end
end

function slot0.RefreshScore(slot0)
	slot1 = PaperCutTool:CalculateScore()

	PaperCutAction.RequireComplete(slot0.activityID_, slot1)

	slot0.scoreText_.text = slot1 or 0
end

return slot0
