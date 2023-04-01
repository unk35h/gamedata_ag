slot0 = class("ActivityMainBaseView", ReduxView)

function slot0.UIName(slot0)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitSubmoduleButton()
end

function slot0.InitSubmoduleButton(slot0)
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)
	slot0:RefreshUI()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:Dispose()
	end

	slot0.submoduleBtnList_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot1.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot1.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.GetActivityID(slot0)
end

return slot0
