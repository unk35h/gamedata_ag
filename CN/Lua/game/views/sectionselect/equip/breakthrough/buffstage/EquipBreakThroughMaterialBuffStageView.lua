slot0 = class("EquipBreakThroughMaterialBullStageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapProcessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.buffList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.buffUIList_, EquipBreakThroughMaterialBuffStageItem)
	slot0.okBtnController_ = ControllerUtil.GetController(slot0.okBtnTf_, "name")
	slot0.selectHandler_ = handler(slot0, slot0.SelectItem)
end

function slot0.OnEnter(slot0)
	slot0.okBtnController_:SetSelectedState("false")

	slot0.selectIndex_ = nil
	slot0.mapStageID_ = slot0.params_.mapStageID
	slot0.cancelText_.text = string.format(GetTips("EQUIP_BREAK_THROUGH_BUFF_HEAL"), GameSetting.equip_crossroads_buff_healing.value[1])

	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, slot0.selectHandler_)
	slot0.buffList_:StartScroll(#EquipBreakThroughMaterialData:GetStageData()[slot0.mapStageID_].buffList)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_SELECT_BUFF, slot0.selectHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectHandler_ = nil

	slot0.buffList_:Dispose()

	slot0.buffList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.selectIndex_ == nil then
			return
		end

		slot0 = EquipBreakThroughMaterialData

		EquipBreakThroughMaterialAction.ChooseBuff(uv0.mapStageID_, slot0:GetStageData()[uv0.mapStageID_].buffList[uv0.selectIndex_], function (slot0)
			if isSuccess(slot0.result) then
				uv0:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		EquipBreakThroughMaterialAction.ChooseBuff(uv0.mapStageID_, 0, function (slot0)
			if isSuccess(slot0.result) then
				uv0:Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_buff_healing.value[1]))
			end
		end)
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.mapStageID_, slot0.selectIndex_)
end

function slot0.SelectItem(slot0, slot1)
	slot0.okBtnController_:SetSelectedState("true")

	slot0.selectIndex_ = slot1
end

return slot0
