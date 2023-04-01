slot0 = class("LuaTree")

function slot0.Ctor(slot0, slot1)
	slot0.treeGo_ = slot1

	slot0:InitUI()
	slot0:AddListeners()

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.InitUI(slot0)
	slot0.tree_ = slot0.treeGo_:GetComponent("UITree")
end

function slot0.AddListeners(slot0)
	if slot0.tree_ ~= nil then
		slot0.tree_:SetItemRenderer(handler(slot0, slot0.ItemRenderer))
		slot0.tree_:SetGroupRenderer(handler(slot0, slot0.GroupRenderer))
		slot0.tree_:SetGroupSelectHandler(handler(slot0, slot0.OnGroupSelect))
		slot0.tree_:SetItemSelectHandler(handler(slot0, slot0.OnItemSelect))
	end
end

function slot0.RemoveListeners(slot0)
	if slot0.tree_ ~= nil then
		slot0.tree_:SetItemRenderer(nil)
		slot0.tree_:SetGroupRenderer(nil)
		slot0.tree_:SetGroupSelectHandler(nil)
		slot0.tree_:SetItemSelectHandler(nil)
	end
end

function slot0.SetData(slot0, slot1)
	if slot0.tree_ ~= nil then
		slot0.tree_:SetData(slot1)
	end
end

function slot0.SetRenderer(slot0, slot1, slot2)
	slot0.groupRenderer_ = slot1
	slot0.itemRenderer_ = slot2
end

function slot0.SetSelectedHandler(slot0, slot1, slot2)
	slot0.itemSelectedHandler_ = slot2
	slot0.groupSelectHandler_ = slot1
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.itemSelectedHandler_ ~= nil then
		slot0.itemSelectedHandler_(slot1 + 1, slot2, slot3, slot4)
	end
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.groupSelectHandler_ ~= nil then
		slot0.groupSelectHandler_(slot1 + 1, slot2, slot3, slot4)
	end
end

function slot0.ItemRenderer(slot0, slot1, slot2)
	if slot0.itemRenderer_ then
		slot0.itemRenderer_(slot1, slot2)
	end
end

function slot0.GroupRenderer(slot0, slot1, slot2)
	if slot0.groupRenderer_ then
		slot0.groupRenderer_(slot1, slot2)
	end
end

function slot0.SelectGroup(slot0, slot1)
	slot2 = slot1 - 1

	slot0.tree_:SelectGroup(slot2)

	slot3 = slot0.tree_.data.groupDatas[slot2]

	if slot0.groupSelectHandler_ then
		slot0.groupSelectHandler_(slot1, slot3.id, slot3.text, slot3.extraData)
	end
end

function slot0.GetGroupGameObjectById(slot0, slot1)
	return slot0.tree_:GetGroupGameObjectById(slot1)
end

function slot0.SelectItem(slot0, slot1, slot2)
	slot3 = slot1 - 1

	slot0.tree_:SelectItem(slot3, slot2 - 1)

	slot5 = slot0.tree_.data.groupDatas[slot3]

	if slot0.groupSelectHandler_ then
		slot0.groupSelectHandler_(slot1, slot5.id, slot5.text, slot5.extraData)
	end

	if slot4 < slot5.itemDatas.Count then
		slot6 = slot5.itemDatas[slot4]

		if slot0.itemSelectedHandler_ then
			slot0.itemSelectedHandler_(slot2, slot6.id, slot6.text, slot6.extraData)
		end
	end
end

function slot0.GetItemGameObjectById(slot0, slot1, slot2)
	return slot0.tree_:GetItemGameObjectById(slot1, slot2)
end

function slot0.GetGroupRedPointContainerById(slot0, slot1)
	if slot0.tree_:GetGroupGameObjectById(slot1) ~= nil then
		return slot2:GetComponent("UITreeGroup").noticeContainer
	end

	return nil
end

function slot0.GetItemRedPointContainerById(slot0, slot1, slot2)
	if slot0.tree_:GetItemGameObjectById(slot1, slot2) ~= nil then
		return slot3:GetComponent("UITreeItem").noticeContainer
	end

	return nil
end

function slot0.Refresh(slot0)
	slot0.tree_:Refresh()
end

function slot0.GetData(slot0)
	return slot0.tree_.data
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	if slot0.tree_ ~= nil then
		slot0.tree_ = nil
	end

	ReduxFactory.GetInstance():OnManagedObjDisposed(slot0)
end

return slot0
