slot0 = class("EquipBreakThroughMaterialMapInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapDetailsPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.toggleItemList_ = {
		EquipBreakThroughMaterialMapInfoBtn.New(slot0.teamInfoGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM),
		EquipBreakThroughMaterialMapInfoBtn.New(slot0.buffGo_, EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF)
	}
	slot0.selectToggleHandler_ = handler(slot0, slot0.RefreshToggle)
	slot0.teamInfoView_ = EquipBreakThroughMaterialTeamInfoView.New(slot0.teamContentGo_)
	slot0.buffView_ = EquipBreakThroughMaterialBuffView.New(slot0.buffContentGo_)
end

function slot0.OnEnter(slot0)
	slot0.toggleType_ = slot0.params_.toggleType

	for slot4, slot5 in ipairs(slot0.toggleItemList_) do
		slot5:OnEnter(slot0.toggleType_)
	end

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, slot0.selectToggleHandler_)
	slot0:RefreshToggle(slot0.toggleType_)
	slot0.teamInfoView_:OnEnter()
	slot0.buffView_:OnEnter()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.toggleItemList_) do
		slot5:OnExit()
	end

	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_TOGGLE, slot0.selectToggleHandler_)
	slot0.teamInfoView_:OnExit()
	slot0.buffView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.toggleItemList_) do
		slot5:Dispose()
	end

	slot0.toggleItemList_ = nil
	slot0.selectToggleHandler_ = nil

	slot0.teamInfoView_:Dispose()

	slot0.teamInfoView_ = nil

	slot0.buffView_:Dispose()

	slot0.buffView_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshToggle(slot0, slot1)
	if slot1 == EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF then
		slot0.controller_:SetSelectedState("buff")
	else
		slot0.controller_:SetSelectedState("team")
	end
end

return slot0
