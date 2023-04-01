slot0 = class("FurnitureEditView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/FurnitureEditorUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

slot1 = nil

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rotateController_ = ControllerUtil.GetController(slot0.transform_, "rotate")
	slot0.storageController_ = ControllerUtil.GetController(slot0.transform_, "storage")
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()
	slot0.furID_ = slot0.params_.itemId
	slot0.furEntityID = slot0.params_.furEntityID
	slot0.furnameText_.text = ItemCfg[slot0.furID_].name
	slot1 = BackHomeFurniture[slot0.furID_]
	slot2 = DormFurnitureManager.GetInstance()

	if slot0.params_.type == "click" then
		if slot1.type == DormConst.FLOOR_TYPE_NUM or slot1.type == DormConst.WALL_TYPE_NUM then
			DormTools:ChangeDormFloorOrWall(slot0.furID_)
		else
			slot3 = slot2:Generate(slot0.furID_)

			DormLuaBridge.ChangeFurnitureState(slot3, DormFurnitureManager.FurnitureState.Editing)
			DormLuaBridge.AddFurnitureToWallDitherAlphaControl(slot3)
		end
	elseif slot0.params_.type == "drag" then
		if slot1.type == DormConst.FLOOR_TYPE_NUM or slot1.type == DormConst.WALL_TYPE_NUM then
			DormTools:ChangeDormFloorOrWall(slot0.furID_)
		else
			slot3 = slot2:Generate(slot0.furID_)
			slot4 = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)

			DormLuaBridge.ChangeFurnitureState(slot3, DormFurnitureManager.FurnitureState.Editing)
			DormLuaBridge.AddFurnitureToWallDitherAlphaControl(slot3)
			DormLuaBridge.BeginDragFurniture(slot3)
		end
	end

	if slot0.params_.type == "click" or slot0.params_.type == "drag" then
		uv0 = false
	elseif slot0.params_.type == "edit" then
		uv0 = true
	else
		Debug.LogError("未知的情况")
	end

	slot0:ShowCanUseButton()
end

function slot0.OnExit(slot0)
	slot0.params_.type = nil

	DormLuaBridge.ClearEditingFurniture()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.cancelBtn_, nil, function ()
		if not DormTools:JudgeFurType(uv0.furID_) and not uv1 then
			DormitoryData:ReviseFurNumInEditRoom(uv0.furID_, -1)
		end

		slot0 = BackHomeFurniture[uv0.furID_]

		if DormTools:JudgeFurType(uv0.furID_) then
			slot2 = DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID())

			if slot0.type == DormConst.FLOOR_TYPE_NUM then
				slot4 = nil

				DormTools:ChangeDormFloorOrWall(DormitoryData:GetCacheWallAndFloorInfo(DormConst.FLOOR_TYPE_NUM) and slot3 or slot2.floorID)
			elseif slot0.type == DormConst.WALL_TYPE_NUM then
				slot4 = nil

				DormTools:ChangeDormFloorOrWall(DormitoryData:GetCacheWallAndFloorInfo(DormConst.WALL_TYPE_NUM) and slot3 or slot2.wallID)
			end
		else
			slot1, slot2 = DormLuaBridge.CancelChange(nil)

			if slot1 then
				DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(slot2)
				DormFurnitureManager.GetInstance().FindAndRemove(slot2)
			end
		end

		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.rotateBtn_, nil, function ()
		DormLuaBridge.RotateFurniture()
	end)
	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		if not DormTools:JudgeFurType(uv0.furID_) then
			if DormLuaBridge.SaveChange() then
				JumpTools.Back()
			else
				ShowTips("DORM_FURNITURE_CANNOT_SET")
			end
		else
			DormitoryData:ReviseFurNumInEditRoom(uv0.furID_, 1)

			if BackHomeFurniture[uv0.furID_].type == DormConst.FLOOR_TYPE_NUM then
				DormitoryData:ReviseFurNumInEditRoom(DormitoryData:GetEditCurFloorOrWall(DormConst.FLOOR_TYPE_NUM), -1)
			else
				DormitoryData:ReviseFurNumInEditRoom(DormitoryData:GetEditCurFloorOrWall(DormConst.WALL_TYPE_NUM), -1)
			end

			if BackHomeFurniture[uv0.furID_].type == DormConst.FLOOR_TYPE_NUM then
				DormitoryData:CacheWallAndFloorInfo(uv0.furID_, nil)
			else
				DormitoryData:CacheWallAndFloorInfo(nil, uv0.furID_)
			end

			JumpTools.Back()
		end
	end)
	slot0:AddBtnListenerScale(slot0.storageBtn_, nil, function ()
		if DormLuaBridge.StorageFurniture() >= 0 then
			DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(slot0)
			DormFurnitureManager.GetInstance().FindAndRemove(slot0)
		end

		DormitoryData:ReviseFurNumInEditRoom(uv0.furID_, -1)
		JumpTools.Back()
	end)
end

function slot0.ShowCanUseButton(slot0)
	slot1 = BackHomeCfg[slot0.roomID].type
	slot3 = true

	for slot7, slot8 in ipairs(BackHomeFurniture[slot0.furID_].is_rotate) do
		if slot1 == slot8 then
			slot0.rotateController_:SetSelectedState("false")

			slot3 = false

			break
		end
	end

	if slot3 then
		slot0.rotateController_:SetSelectedState("true")
	end

	slot5 = true

	for slot9, slot10 in ipairs(BackHomeFurniture[slot0.furID_].is_storage) do
		if slot1 == slot10 then
			slot0.storageController_:SetSelectedState("false")

			slot5 = false

			break
		end
	end

	if slot5 then
		slot0.storageController_:SetSelectedState("true")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
