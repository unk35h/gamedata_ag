slot0 = class("RoomEditView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormEditstatusUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FurnitureItem)
	slot0.choiceController = ControllerUtil.GetController(slot0.screeningswitchTrs_, "choice")
	slot0.switchController = ControllerUtil.GetController(slot0.screeningswitchTrs_, "switch")
	slot0.canPlaceController = ControllerUtil.GetController(slot0.canPlace.transform, "name")
	slot0.notPresentedController = ControllerUtil.GetController(slot0.notPresented.transform, "name")
	slot0.hadPlaceController = ControllerUtil.GetController(slot0.hadPlace.transform, "name")
	slot0.otherHadPlaceController = ControllerUtil.GetController(slot0.otherHadPlace.transform, "name")
end

function slot0.OnEnter(slot0)
	slot0.type = slot0.params_.type

	slot0:BindRedPoint()

	slot0.roomID = DormData:GetCurrectSceneID()
	slot0.roomData = DormitoryData:GetDormSceneData(slot0.roomID)

	DormLuaBridge.ChangeCameraMode(1, true)
	DormLuaBridge.SetIsCanEditTag(true)

	slot0.selectIndex_ = slot0.params_.index or DormConst.FLOOR_TYPE_NUM
	slot0.params_.index = slot0.selectIndex_

	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	DormLuaBridge.SetIsCanEditTag(false)

	slot0.selIndex = nil

	slot0:RemoveAllEventListener()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.item_20icon, RedPointConst.DORM_FURNITURE_FLOOR)
	manager.redPoint:bindUIandKey(slot0.item_21icon, RedPointConst.DORM_FURNITURE_WALL)
	manager.redPoint:bindUIandKey(slot0.item_22icon, RedPointConst.DORM_FURNITURE_WINDOW)
	manager.redPoint:bindUIandKey(slot0.item_23icon, RedPointConst.DORM_FURNITURE_TABLE)
	manager.redPoint:bindUIandKey(slot0.item_24icon, RedPointConst.DORM_FURNITURE_BED)
	manager.redPoint:bindUIandKey(slot0.item_25icon, RedPointConst.DORM_FURNITURE_FLOOR_ITEM)
	manager.redPoint:bindUIandKey(slot0.item_26icon, RedPointConst.DORM_FURNITURE_WALL_ITEM)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.item_20icon, RedPointConst.DORM_FURNITURE_FLOOR)
	manager.redPoint:unbindUIandKey(slot0.item_21icon, RedPointConst.DORM_FURNITURE_WALL)
	manager.redPoint:unbindUIandKey(slot0.item_22icon, RedPointConst.DORM_FURNITURE_WINDOW)
	manager.redPoint:unbindUIandKey(slot0.item_23icon, RedPointConst.DORM_FURNITURE_TABLE)
	manager.redPoint:unbindUIandKey(slot0.item_24icon, RedPointConst.DORM_FURNITURE_BED)
	manager.redPoint:unbindUIandKey(slot0.item_25icon, RedPointConst.DORM_FURNITURE_FLOOR_ITEM)
	manager.redPoint:unbindUIandKey(slot0.item_26icon, RedPointConst.DORM_FURNITURE_WALL_ITEM)
end

function slot0.RefreshView(slot0)
	slot0:InitRoomCanUseFurList()

	slot0["item_" .. slot0.selectIndex_ .. "Tgl_"].isOn = true

	slot0:OnGroupSelect(slot0.selectIndex_)
	slot0:UpdataHasPlaceFurNum()
	slot0:RefreshSwichBar()

	if slot0.filterShow then
		slot0:RefreshBtnController()
	end
end

function slot0.UpdataHasPlaceFurNum(slot0)
	slot0.curNum.text = DormData:GetHasPlaceFurNumInfoInMap(slot0.roomID) + DormitoryData:GetCacheFurTotalNum()
	slot3 = 0

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot3 = GameSetting.dorm_lobby_furniture_limited.value[1]
	elseif BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot3 = BackHomeDormLevel[DormitoryData:GetDormLevel(slot0.roomID)].furniture_max
	end

	slot0.totalNum.text = "/" .. slot3
end

function slot0.InitRoomCanUseFurList(slot0)
	slot0.furList = {}

	if DormitoryData:GetFurEditFlag().canPlaceFlag then
		slot5 = slot0.roomID
		slot0.canPlaceList = DormData:GetRoomCanUseFurList(slot5)

		for slot5, slot6 in ipairs(slot0.canPlaceList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace
			})
		end
	end

	if slot1.notPresentedFlag then
		slot5 = slot0.roomID
		slot0.notPresentedList = DormitoryData:GetNotPresentedFurInRoom(slot5)

		for slot5, slot6 in ipairs(slot0.notPresentedList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented
			})
		end
	end

	if slot1.hadPlaceFlag then
		slot5 = slot0.roomID
		slot0.hadPlaceFurList = DormitoryData:GetHadPlaceFurNumInRoom(slot5)

		for slot5, slot6 in ipairs(slot0.hadPlaceFurList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace
			})
		end
	end

	if slot1.otherHadPlaceFlag then
		slot5 = slot0.roomID
		slot0.otherHadPlaceFurList = DormitoryData:GetHadPlaceFlagFurInRoom(slot5)

		for slot5, slot6 in ipairs(slot0.otherHadPlaceFurList) do
			table.insert(slot0.furList, {
				furID = slot6,
				type = DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace
			})
		end
	end
end

function slot0.RefreshSwichBar(slot0)
	for slot5, slot6 in pairs(DormitoryData:GetFurEditFlag()) do
		if not slot1[slot5] then
			slot0.choiceController:SetSelectedState("single")

			return
		end
	end

	slot0.choiceController:SetSelectedState("all")
end

function slot0.OnGroupSelect(slot0, slot1)
	slot0.selectIndex_ = slot1
	slot0.params_.index = slot0.selectIndex_
	slot0.dataList_ = {}

	if slot0.furList then
		for slot5, slot6 in ipairs(slot0.furList) do
			if BackHomeFurniture[slot6.furID].type == slot1 then
				table.insert(slot0.dataList_, slot6)
			end
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.dataList_)

	slot0.selIndex = DormitoryData:GetSelFurIndex()

	if slot0.selIndex then
		slot0.scrollHelper_:ScrollToIndex(slot0.selIndex, false, false)
	end

	slot0.redPointList = {}

	for slot5, slot6 in ipairs(slot0.dataList_) do
		if slot6.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			table.insert(slot0.redPointList, slot6)
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.dataList_[slot1], slot0.selItem_, DormEnum.FurItemType.Edit, nil, slot1)
	slot2:OnPointerDown(function (slot0, slot1, slot2)
		uv0.furType = slot2

		if DormTools:JudgeFurType(slot0) and slot2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			DormitoryData:SetSelFurIndex(uv0.selIndex)

			uv0.selItem_ = slot0
			uv0.selIndex = slot1

			JumpTools.OpenPageByJump("/furnitureEdit", {
				type = "click",
				itemId = uv0.selItem_,
				itemType = uv0.selItemType
			})
		end

		if slot2 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			uv0.selItem_ = slot0
			uv0.selIndex = slot1

			uv0.scrollHelper_:Refresh()
		end

		if slot2 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			ShowTips(GetTips("DORM_FUR_NEED_GIFT"))
		end
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		DormAction:SetFurListInMap(uv0.roomID, nil, DormLuaBridge.GetPlacedFurnitureInfo())
		DormLuaBridge.ChangeCameraMode(0, true)
		DormitoryData:SetSelFurIndex(nil)
		gameContext:Go("/dorm")
		DormTools:GenerateHeroWhenEnterScene()
	end)
	slot0:AddBtnListenerScale(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function ()
				DormitoryData:RestoreRoomAllFurniture()
				DormitoryData:RestoreWallAndFloor()
				DormFurnitureManager.GetInstance():ClearAndGenByFurList()
				uv0:RefreshView()
			end,
			CancelCallback = function ()
			end
		})
	end)

	slot4 = slot0.cancelBtn_

	slot0:AddBtnListenerScale(slot4, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CANCEL"),
			OkCallback = function ()
				DormitoryData:ClearFurNumInEditRoom()
				DormitoryData:ClearCacheWallAndFloor()
				DormLuaBridge.ChangeCameraMode(0, true)

				slot0 = DormData:GetCurrectSceneID()

				DormFurnitureManager.GetInstance():ClearAndGenByFurList(DormitoryData:GetDormFurListByRoomID(slot0))

				slot2 = DormitoryData:GetDormSceneData(slot0)

				DormTools:ChangeDormFloorOrWall(slot2.wallID)
				DormTools:ChangeDormFloorOrWall(slot2.floorID)
				gameContext:Go("/dorm")
				DormitoryData:SetSelFurIndex(nil)
				DormLuaBridge.SetIsCanEditTag(false)
				DormTools:GenerateHeroWhenEnterScene()
			end,
			CancelCallback = function ()
			end
		})
	end)

	for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		slot0:AddToggleListener(slot0["item_" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				uv0:OnGroupSelect(uv1)
				DormitoryData:CloseDormFurRedPoint(uv0.roomID, uv0.selectIndex_, uv0.redPointList)
			end
		end)
	end

	slot1 = slot0.uilistSrex_.ExitScrollArea

	slot1:AddListener(function ()
		if uv0.selItem_ and uv0.furType == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			if not DormTools:GetIsOverLoad(uv0.roomID) then
				ShowTips(GetTips("DORM_FURNITURE_SET_MAX"))

				return
			end

			DormitoryData:SetSelFurIndex(uv0.selIndex)
			JumpTools.OpenPageByJump("/furnitureEdit", {
				type = "drag",
				itemId = uv0.selItem_,
				itemType = uv0.selItemType
			})

			if not DormTools:JudgeFurType(uv0.selItem_) then
				DormitoryData:ReviseFurNumInEditRoom(uv0.selItem_, 1)
			end

			DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.PlaceFur)
		end
	end)
	slot0:AddBtnListenerScale(slot0.filterbtn_, nil, function ()
		if not uv0.filterShow then
			uv0.switchController:SetSelectedState("on")

			uv0.filterShow = true

			uv0:RefreshBtnController()
		else
			uv0.switchController:SetSelectedState("off")

			uv0.filterShow = false
		end
	end)
	slot0:AddBtnListenerScale(slot0.canPlacebtn_, nil, function ()
		if DormitoryData:GetFurEditFlag().canPlaceFlag then
			slot0.canPlaceFlag = false
		else
			slot0.canPlaceFlag = true
		end

		DormitoryData:SetSelFurIndex(nil)

		uv0.selIndex = nil

		uv0:RefreshView()
	end)
	slot0:AddBtnListenerScale(slot0.hadPlacebtn_, nil, function ()
		if DormitoryData:GetFurEditFlag().hadPlaceFlag then
			slot0.hadPlaceFlag = false
		else
			slot0.hadPlaceFlag = true
		end

		DormitoryData:SetSelFurIndex(nil)

		uv0.selIndex = nil

		uv0:RefreshView()
	end)
	slot0:AddBtnListenerScale(slot0.otherHadPlacebtn_, nil, function ()
		if DormitoryData:GetFurEditFlag().otherHadPlaceFlag then
			slot0.otherHadPlaceFlag = false
		else
			slot0.otherHadPlaceFlag = true
		end

		DormitoryData:SetSelFurIndex(nil)

		uv0.selIndex = nil

		uv0:RefreshView()
	end)
	slot0:AddBtnListenerScale(slot0.notPresentedbtn_, nil, function ()
		if DormitoryData:GetFurEditFlag().notPresentedFlag then
			slot0.notPresentedFlag = false
		else
			slot0.notPresentedFlag = true
		end

		DormitoryData:SetSelFurIndex(nil)

		uv0.selIndex = nil

		uv0:RefreshView()
	end)
end

function slot0.RefreshBtnController(slot0)
	if DormitoryData:GetFurEditFlag().otherHadPlaceFlag then
		slot0.otherHadPlaceController:SetSelectedState("on")
	else
		slot0.otherHadPlaceController:SetSelectedState("off")
	end

	if slot1.hadPlaceFlag then
		slot0.hadPlaceController:SetSelectedState("on")
	else
		slot0.hadPlaceController:SetSelectedState("off")
	end

	if slot1.canPlaceFlag then
		slot0.canPlaceController:SetSelectedState("on")
	else
		slot0.canPlaceController:SetSelectedState("off")
	end

	if slot1.notPresentedFlag then
		slot0.notPresentedController:SetSelectedState("on")
	else
		slot0.notPresentedController:SetSelectedState("off")
	end
end

function slot0.CheckFurNum(slot0)
	slot1 = nil
	slot4 = DormitoryData:GetDormFurListByRoomID().Length + DormitoryData:GetCacheFurTotalNum()

	if (BackHomeCfg[slot0.roomID].type ~= DormConst.BACKHOME_TYPE.PublicDorm or GameSetting.dorm_lobby_furniture_limited.value[1]) and BackHomeCfg[slot0.roomID].load_max[DormitoryData:GetDormLevel(slot0.roomID)] then
		if slot1 <= slot4 then
			return false
		else
			return true
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()
	end

	slot0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
