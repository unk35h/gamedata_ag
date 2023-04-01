slot0 = class("CanteenPassTablePop", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamPassTablePop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.ExitOnCanteenModeChange(slot0)
	slot0.onSelect = nil
	slot0.onCanceled = nil

	slot0:Back()
end

function slot0.OnEnter(slot0)
	slot0.passtableEntityEid = CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.ItemType.PassTable))[1]
	slot0.passtableData = CanteenAIFunction:GetEntityData(slot0.passtableEntityEid)
	slot0.foodList = nullable(slot0.passtableData, "foodList")
	slot0.playerEID = slot0.params_.playerEID
	slot0.onSelect = slot0.params_.onSelect
	slot0.onCanceled = slot0.params_.onCanceled

	slot0.foodListScroll_:StartScroll(slot0.foodList and #slot0.foodList or 0)

	slot0.select = false
	slot2 = handler(slot0, slot0.ExitOnCanteenModeChange)

	slot0:RegistEventListener(DORM_RESTAURANT_START_AUTO, slot2)
	slot0:RegistEventListener(DORM_RESTAURANT_START_MANUAL, slot2)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.foodListScroll_ = LuaList.New(handler(slot0, slot0.foodItem), slot0.foodlistUilist_, CanteenPassTableFoodItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0.select = false

		JumpTools.Back()
	end)
end

function slot0.foodItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot0.foodList[slot1])
	slot2:RegistCallBack(function (slot0)
		CanteenAIFunction:SetCharacterTarget(uv0.playerEID, slot0)

		uv0.select = true

		JumpTools.Back()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.select then
		if slot0.onSelect then
			slot0.onSelect()
		end
	elseif slot0.onCanceled then
		slot0.onCanceled()
	end
end

function slot0.Dispose(slot0)
	if slot0.foodListScroll_ then
		slot0.foodListScroll_:Dispose()

		slot0.foodListScroll_ = nil
	end
end

return slot0
