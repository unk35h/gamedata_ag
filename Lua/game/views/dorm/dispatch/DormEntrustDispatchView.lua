slot0 = class("DormEntrustDispatchView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HouseUI/HouseSendChooseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnCtor(slot0, ...)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

return slot0
