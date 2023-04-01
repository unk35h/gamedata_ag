slot0 = class("RestaurantCookUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dining/PotUpgradeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.unlockScroll = LuaList.New(handler(slot0, slot0.unLockItem), slot0.materialListGo_, CommonItem)
	slot0.conditionScroll = LuaList.New(handler(slot0, slot0.conditionItem), slot0.conditionListGo_, RestaurantCookConditionItem)
	slot0.skillScroll = LuaList.New(handler(slot0, slot0.skillItem), slot0.skillListGo_, RestaurantCookConditionItem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.skillListController = ControllerUtil.GetController(slot0.skillListGo_.transform, "empty")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)
end

function slot0.OnEnter(slot0)
	slot0:RefreshTree()

	slot0.type = slot0.params_.type or 1
	slot0.furEID = slot0.params_.furEID or CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
	slot0.unLockFlag = true

	slot0:RegisterEvent()

	slot0.furCfgID = BackHomeCanteenFurnitureIDCfg[slot0.furEID].type_id

	if not slot0.type then
		slot0.currentGroupIndex_ = 1
	else
		slot0.currentGroupIndex_ = slot0.type
	end

	slot0.currentItemIndex_ = 1

	if slot0.furEID then
		for slot5 = 0, slot0.treeData_.groupDatas[slot0.currentGroupIndex_ - 1].itemDatas.Count - 1 do
			if slot1.itemDatas[slot5].id == slot0.furEID then
				slot0.currentItemIndex_ = slot5 + 1

				break
			end
		end
	end

	slot0.tree_:SelectItem(slot0.currentGroupIndex_, slot0.currentItemIndex_)
end

function slot0.OnExit(slot0)
	if slot0.upFlag then
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close or CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Start then
			manager.notify:Invoke(DORM_RESTAURANT_UPDATE_SCENE_ITEM)
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
		end
	end

	slot0.upFlag = nil

	slot0:RemoveAllEventListener()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_FUR_LEVEL_UP, function ()
		uv0.upFlag = true

		uv0.tree_:SelectItem(uv0.currentGroupIndex_, uv0.currentItemIndex_)
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.upBtn_, nil, function ()
		if uv0.furEID then
			if not uv0.unLockFlag then
				ShowTips(GetTips("DORM_CANTEEN_CANT_LEVEL_UP"))

				return
			end

			slot0 = BackHomeCanteenFurnitureIDCfg[uv0.furEID].type_id
			slot2 = 0

			if CanteenData:GetFurInfoList()[uv0.furEID] then
				slot2 = slot1.level
			end

			for slot7, slot8 in ipairs(BackHomeCanteenFurnitureCfg[slot0].cost_material[slot2 + 1]) do
				if CurrencyData:GetCurrencyNum(slot8[1]) < slot8[2] then
					ShowTips(GetTips("DORM_CANTEEN_LEVEL_NOT_ENOUGH"))

					return
				end
			end

			CanteenAction:CanteenFurnitureUpgrade(uv0.furEID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2)
	slot0.currentGroupIndex_ = slot1

	if not slot0.currentItemIndex_ then
		slot0.currentItemIndex_ = 1
	end

	slot0:UpdataCookLevelUpInfo(slot0.currentGroupIndex_)
end

function slot0.OnItemSelect(slot0, slot1)
	slot0.currentItemIndex_ = slot1
	slot0.unLockFlag = true

	slot0:RefreshView()
end

function slot0.RefreshTree(slot0)
	slot0.tree_:SetSelectedHandler(nil, slot6)

	slot2 = UITreeData.New()

	for slot6 = 1, #{
		GetTips("DORM_CANTEEN_FURNITURE_KITCHEN"),
		GetTips("DORM_CANTEEN_FURNITURE")
	} do
		slot7 = UITreeGroupData.New()
		slot7.id = slot6
		slot7.text = slot1[slot6]

		if slot6 == 1 then
			slot8, slot9 = nil
			slot8 = UITreeItemData.New()
			slot8.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pan)
			slot9 = BackHomeCanteenFurnitureIDCfg[slot8.id].type_id
			slot8.text = ItemCfg[slot9].name
			slot8.extraData = BackHomeCanteenFurnitureCfg[slot9].type

			slot7.itemDatas:Add(slot8)

			slot8 = UITreeItemData.New()
			slot8.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Oven)
			slot9 = BackHomeCanteenFurnitureIDCfg[slot8.id].type_id
			slot8.text = ItemCfg[slot9].name
			slot8.extraData = BackHomeCanteenFurnitureCfg[slot9].type

			slot7.itemDatas:Add(slot8)

			slot8 = UITreeItemData.New()
			slot8.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Steamer)
			slot9 = BackHomeCanteenFurnitureIDCfg[slot8.id].type_id
			slot8.text = ItemCfg[slot9].name
			slot8.extraData = BackHomeCanteenFurnitureCfg[slot9].type

			slot7.itemDatas:Add(slot8)

			slot8 = UITreeItemData.New()
			slot8.id = CanteenTools:GetFurEidByType(DormEnum.FurnitureTypeNum.Pot)
			slot9 = BackHomeCanteenFurnitureIDCfg[slot8.id].type_id
			slot8.text = ItemCfg[slot9].name
			slot8.extraData = BackHomeCanteenFurnitureCfg[slot9].type

			slot7.itemDatas:Add(slot8)
		end

		if slot6 == 2 then
			for slot11, slot12 in ipairs(BackHomeCanteenFurnitureCfg.all) do
				if BackHomeCanteenFurnitureCfg[slot12].type == 2 then
					slot14 = nil
					slot14 = UITreeItemData.New()
					slot14.id = CanteenTools:GetCanteenEIDByFurCfgID(slot12)
					slot15 = BackHomeCanteenFurnitureIDCfg[slot14.id].type_id
					slot14.text = ItemCfg[slot15].name
					slot14.extraData = BackHomeCanteenFurnitureCfg[slot15].type

					slot7.itemDatas:Add(slot14)
				end
			end
		end

		slot2.groupDatas:Add(slot7)
	end

	slot0.tree_:SetData(slot2)

	slot6 = handler(slot0, slot0.OnGroupSelect)

	slot0.tree_:SetSelectedHandler(slot6, handler(slot0, slot0.OnItemSelect))

	slot0.treeData_ = slot2
	slot0.upControllerList = {}

	for slot6 = 1, slot0.treeData_.groupDatas.Count do
		for slot11 = 1, slot0.treeData_.groupDatas[slot6 - 1].itemDatas.Count do
			slot14 = ControllerUtil.GetController(slot0.tree_:GetItemGameObjectById(slot6, slot7.itemDatas[slot11 - 1].id).transform, "levelUp")

			if not slot0.upControllerList[slot6] then
				slot0.upControllerList[slot6] = {}
			end

			table.insert(slot0.upControllerList[slot6], slot14)
		end
	end
end

function slot0.skillItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillList[slot1], 1)
end

function slot0.unLockItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.materialList[slot1])
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.num
		})
	end)

	slot3 = slot0.materialList[slot1]

	if ItemTools.getItemNum(slot3.id) < slot3.number then
		slot2:SetBottomText("<color=#CF3232>" .. slot4 .. "</color>" .. "/" .. slot3.number)
	else
		slot2:SetBottomText(slot4 .. "/" .. slot3.number)
	end
end

function slot0.conditionItem(slot0, slot1, slot2)
	slot2:UpdataCondition(function (slot0)
		uv0.unLockFlag = slot0
	end)
	slot2:RefreshUI(slot0.conditionList[slot1], 2)
end

function slot0.UpdataCookLevelUpInfo(slot0, slot1)
	for slot6 = 1, #slot0.upControllerList[slot1] do
		if CanteenTools:CheckFurCanLevelUp(slot0.treeData_.groupDatas[slot1 - 1].itemDatas[slot6 - 1].id) then
			slot0.upControllerList[slot1][slot6]:SetSelectedState("true")
		else
			slot0.upControllerList[slot1][slot6]:SetSelectedState("false")
		end
	end
end

function slot0.RefreshView(slot0)
	slot0.furEID = slot0.treeData_.groupDatas[slot0.currentGroupIndex_ - 1].itemDatas[slot0.currentItemIndex_ - 1].id

	slot0:RefreshFurInfo(slot0.furEID)
end

function slot0.RefreshFurInfo(slot0, slot1)
	slot2 = CanteenData:GetFurnitureLevel(slot1)
	slot3 = BackHomeCanteenFurnitureIDCfg[slot1].type_id
	slot0.num0Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot2)
	slot0.titleText_.text = ItemCfg[slot3].name
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot3)

	slot0:RefreshSkillEffectList(slot3, slot2)

	if slot2 ~= #BackHomeCanteenFurnitureCfg[slot3].cost_material then
		slot0.stateController:SetSelectedState("false")

		slot0.num1Text_.text = string.format(GetTips("DORM_CANTEEN_LEVEL"), slot2 + 1)

		if slot2 == 0 then
			slot0.conditionTitle.text = GetTips("DORM_CANTEEN_UNLOCK_CONDITION")
			slot0.btnText.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
		else
			slot0.conditionTitle.text = GetTips("DORM_CANTEEN_LEVEL_CONDITION")
			slot0.btnText.text = GetTips("TEXT_UPGRADE")
		end

		slot0:RefreshLevelUpInfo(slot3, slot4)
		slot0:RefreshMaterialList(slot3, slot4)
	else
		slot0.stateController:SetSelectedState("true")
	end
end

function slot0.RefreshSkillEffectList(slot0, slot1, slot2)
	slot0.skillList = BackHomeCanteenFurnitureCfg[slot1].skill[slot2]

	if slot0.skillList then
		slot0.skillScroll:StartScroll(#slot0.skillList)
	else
		slot0.skillScroll:StartScroll(0)
		slot0.skillListController:SetSelectedState("false")
	end
end

function slot0.RefreshLevelUpInfo(slot0, slot1, slot2)
	slot0.conditionList = BackHomeCanteenFurnitureCfg[slot1].condition[slot2]

	if slot0.conditionList then
		slot0.conditionScroll:StartScroll(#slot0.conditionList)
	else
		slot0.conditionScroll:StartScroll(0)
	end
end

function slot0.RefreshMaterialList(slot0, slot1, slot2)
	if BackHomeCanteenFurnitureCfg[slot1].cost_material[slot2] then
		slot0.materialList = {}

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot0.materialList, {
				id = slot8[1],
				number = slot8[2]
			})
		end

		slot0.unlockScroll:StartScroll(#slot0.materialList)
	else
		slot0.unlockScroll:StartScroll(0)
	end
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.unlockScroll then
		slot0.unlockScroll:Dispose()

		slot0.unlockScroll = nil
	end

	if slot0.conditionScroll then
		slot0.conditionScroll:Dispose()

		slot0.conditionScroll = nil
	end

	if slot0.skillScroll then
		slot0.skillScroll:Dispose()

		slot0.skillScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
