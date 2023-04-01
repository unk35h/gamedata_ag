slot0 = class("DamageTestModeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/DamageTest/DamageTestModeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.btnTransform_, "conName")
	slot0.deadManItem_ = DamageTestModeItem.New(slot0.deadManGo_, 1)
	slot0.combatItem_ = DamageTestModeItem.New(slot0.combatGo_, 2)
	slot0.moveManItem_ = DamageTestModeItem.New(slot0.moveManGo_, 3)
	slot0.chooseHandler_ = handler(slot0, slot0.ChooseItemMode)

	slot0.deadManItem_:RegistClickFunc(slot0.chooseHandler_)
	slot0.combatItem_:RegistClickFunc(slot0.chooseHandler_)
	slot0.moveManItem_:RegistClickFunc(slot0.chooseHandler_)
end

function slot0.ChooseItemMode(slot0, slot1)
	slot0.chooseIndex_ = slot1

	slot0.deadManItem_:RefreshUI(slot1)
	slot0.combatItem_:RefreshUI(slot1)
	slot0.moveManItem_:RefreshUI(slot1)
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0.chooseIndex_ = nil

	slot0.deadManItem_:RefreshUI(slot0.chooseIndex_)
	slot0.combatItem_:RefreshUI(slot0.chooseIndex_)
	slot0.moveManItem_:RefreshUI(slot0.chooseIndex_)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.chooseHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		if uv0.chooseIndex_ == nil then
			return
		end

		uv0:ClickBtn()
	end)
end

function slot0.ClickBtn(slot0)
	if slot0.chooseIndex_ == 1 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 0
		})
	elseif slot0.chooseIndex_ == 2 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 1
		})
	elseif slot0.chooseIndex_ == 3 then
		JumpTools.GoToSystem("/damageTestBossSwitch", {
			battleType = 2
		})
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMode(slot0.chooseIndex_)
end

function slot0.RefreshMode(slot0, slot1)
	slot0.chooseIndex_ = slot1

	if slot1 then
		slot0.selectController_:SetSelectedState("yellow")
	else
		slot0.selectController_:SetSelectedState("black")
	end
end

return slot0
