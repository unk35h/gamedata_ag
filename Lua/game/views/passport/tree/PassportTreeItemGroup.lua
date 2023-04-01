slot0 = class("PassportTreeItemGroup", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.itemGo_ = slot2
	slot0.labels_ = {
		GetTips("MISSION_DAILY"),
		GetTips("MISSION_WEEKLY"),
		GetTips("MISSION_CHALLENGE")
	}

	slot0:Init()
end

function slot0.GetContainer(slot0)
	return slot0.transform_
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.items_ = {}
	slot0.toggleGroup_ = slot0.gameObject_:GetComponent(typeof(ToggleGroup))
end

function slot0.SetShopIds(slot0, slot1, slot2)
	slot0.shopIdList_ = slot1

	slot0:UpdateItems()

	if not slot0.items_[slot2]:GetToggle().isOn then
		slot0.items_[slot2]:GetToggle().isOn = true
	else
		slot0:NotifySelect(slot2, slot0.shopIdList_[slot2])
	end
end

function slot0.UpdateItems(slot0)
	for slot4 = 1, #slot0.shopIdList_ do
		if not slot0.items_[slot4] then
			slot0.items_[slot4] = ShopTreeItem.New(Object.Instantiate(slot0.itemGo_, slot0.transform_))
			slot6 = slot0.items_[slot4]
			slot6:GetToggle().group = slot0.toggleGroup_
			slot6 = slot0.items_[slot4]
			slot6 = slot6:GetToggle().onValueChanged

			slot6:AddListener(function (slot0)
				if slot0 then
					uv0:NotifySelect(uv1, uv0.shopIdList_[uv1])
				end
			end)
		end

		slot0.items_[slot4]:SetShopId(slot0.shopIdList_[slot4])
	end

	while #slot0.items_ > #slot0.shopIdList_ do
		slot1 = slot0.items_[#slot0.items_]

		SetActive(slot1.gameObject_, false)
		slot0:DisposeItem(slot1)
		table.remove(slot0.items_, #slot0.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.NotifySelect(slot0, slot1, slot2)
	if slot0.selectedCallback_ then
		slot0.selectedCallback_(slot1, slot2)
	end
end

function slot0.SetSelectCallback(slot0, slot1)
	slot0.selectedCallback_ = slot1
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.items_ then
		for slot4, slot5 in ipairs(slot0.items_) do
			slot0:DisposeItem(slot5)
		end

		slot0.items_ = nil
	end

	slot0.selectedCallback_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.DisposeItem(slot0, slot1)
	slot1:GetToggle().onValueChanged:RemoveAllListeners()
	slot1:Dispose()
end

return slot0
