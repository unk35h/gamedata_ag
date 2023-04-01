slot0 = class("EquipBreakThroughMaterialMapItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "equipMaterial")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.currentPosController_ = ControllerUtil.GetController(slot0.transform_, "currentPosition")
	slot0.finishStateController_ = ControllerUtil.GetController(slot0.transform_, "finish")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.colorController_ = ControllerUtil.GetController(slot0.transform_, "open")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), uv0.mapStageID_) or uv0.lock_ then
			return
		end

		EquipBreakThroughMaterialData:SetChooseMapStageID(uv0.mapStageID_)

		slot1 = nil

		uv0:Go("equipBreakThroughMaterialStageInfo", {
			section = (uv0.cfg_.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL or GameSetting.equip_crossroads_heal_stage_id.value[1]) and (uv0.cfg_.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF or GameSetting.equip_crossroads_buff_stage_id.value[1]) and EquipBreakThroughMaterialData:GetStageData()[uv0.mapStageID_].stageID
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.mapStageID_ = slot1
	slot0.cfg_ = EquipBreakThroughMaterialMapCfg[slot1]
	slot0.lock_ = true

	slot0:RefreshItemState()
	slot0:RefreshItemPosition()
	SetActive(slot0.gameObject_, true)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.OnTop(slot0)
	slot0.selectController_:SetSelectedState("off")
end

function slot0.OnBehind(slot0)
	if slot0.mapStageID_ == EquipBreakThroughMaterialData:GetChooseMapStageID() then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

function slot0.RefreshItemPosition(slot0)
	slot2 = slot0.cfg_
	slot0.transform_.localPosition = Vector3(EquipBreakThroughMaterialStagePositionCfg[0].row_position * slot2.col, EquipBreakThroughMaterialStagePositionCfg[slot2.row].row_position, 0)
end

function slot0.RefreshItemState(slot0)
	slot1 = EquipBreakThroughMaterialData:GetFinishStageList()
	slot2 = slot1[#slot1]

	if table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), slot0.mapStageID_) then
		slot0.finishStateController_:SetSelectedState("on")
	else
		slot0.finishStateController_:SetSelectedState("off")
	end

	if table.keyof(EquipBreakThroughMaterialPointCfg.all, EquipBreakThroughMaterialMapCfg[slot0.mapStageID_].stage_type) then
		slot0.pointText_.text = EquipBreakThroughMaterialPointCfg[slot3.stage_type].stage_point[slot3.col]
	end

	slot0.canvasGroup_.blocksRaycasts = false

	if slot0.mapStageID_ == slot2 then
		slot0.currentPosController_:SetSelectedState("on")
	else
		slot0.currentPosController_:SetSelectedState("off")
	end

	slot4 = true

	if slot2 == nil then
		if EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()][1] == slot0.mapStageID_ then
			slot0.canvasGroup_.blocksRaycasts = true

			slot0.lockController_:SetSelectedState("off")

			slot0.lock_ = false

			slot0.colorController_:SetSelectedState(tostring(slot3.stage_type))
		else
			slot0.lockController_:SetSelectedState(tostring(slot3.stage_type))
			slot0.colorController_:SetSelectedState("0")
		end
	elseif table.keyof(EquipBreakThroughMaterialMapCfg[slot2].next_id_list, slot0.mapStageID_) then
		slot0.lockController_:SetSelectedState("off")

		slot0.canvasGroup_.blocksRaycasts = true
		slot0.lock_ = false

		slot0.colorController_:SetSelectedState(tostring(slot3.stage_type))
	elseif table.keyof(EquipBreakThroughMaterialData:GetFinishStageList(), slot0.mapStageID_) then
		slot0.lockController_:SetSelectedState("off")
		slot0.colorController_:SetSelectedState("0")
	else
		slot0.lockController_:SetSelectedState(tostring(slot3.stage_type))
		slot0.colorController_:SetSelectedState("0")
	end

	slot0.typeController_:SetSelectedState(tostring(slot3.stage_type))

	slot0.icon_.sprite = getSprite("Atlas/Stage", EquipBreakThroughMaterialPointCfg[slot3.stage_type].icon)
end

function slot0.GetLocalPosition(slot0)
	return slot0.transform_.localPosition
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return slot0
