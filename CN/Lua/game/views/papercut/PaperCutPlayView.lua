slot0 = class("PaperCutPlayView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/PaperCut/PaperCutPlayUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		PaperCutTool:GameOver()
		uv0:Back()
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		PaperCutTool:GameOver()

		if uv0.params_.goHomeHandler ~= nil then
			uv0.params_.goHomeHandler()
		end
	end)
	slot0.statusController_:SetSelectedState("prepare")

	slot0.activityID_ = slot0.params_.activityID
	slot0.titleText_.text = PaperCutCfg[slot0.activityID_].name

	PaperCutTool:RegisterCompleteHandler(handler(slot0, slot0.OnCompleted))
	PaperCutTool:RegisterStartDrawHandler(handler(slot0, slot0.OnStartDraw))
end

function slot0.OnCompleted(slot0)
	JumpTools.OpenPageByJump("paperCutResult", {
		activityID = slot0.activityID_
	})
end

function slot0.OnStartDraw(slot0)
	manager.windowBar:HideBar()
	slot0.statusController_:SetSelectedState("playing")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

return slot0
