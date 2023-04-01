slot0 = class("ValentineGameResultView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetResultUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.indexCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityId = uv0.params_.mainActivityID
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.indexCon_:SetSelectedState(table.indexof(ActivityCfg[slot0.params_.mainActivityID].sub_activity_list, slot0.params_.activityID))

	slot3 = ActivityValentineCfg[slot0.params_.activityID]
	slot4, slot5 = ValentineGameTools.GetPointRule(slot0.params_.mainActivityID)

	if slot0.params_.point <= slot4 then
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		slot0.completeText_.text = slot3.result_desc[1]
	elseif slot2 <= slot5 then
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		slot0.completeText_.text = slot3.result_desc[2]
	else
		slot0.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		slot0.completeText_.text = slot3.result_desc[3]
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0.canvasGroup_.alpha = 0
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
