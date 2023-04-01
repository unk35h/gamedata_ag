slot0 = class("ActivityMatrixTreeItemGroup", MatrixTreeItemGroup)

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.tag_ = slot1
	slot0.list_ = slot3
	slot0.matrix_activity_id = slot4

	slot0:UpdateItems()

	if not slot0.items_[slot2]:GetToggle().isOn then
		slot0.items_[slot2]:GetToggle().isOn = true
	else
		slot0:NotifySelect(slot0.tag_, slot2, slot0.list_[slot2])
	end
end

function slot0.UpdateItems(slot0)
	for slot4 = 1, #slot0.list_ do
		if not slot0.items_[slot4] then
			slot0.items_[slot4] = ActivityMatrixTreeItem.New(Object.Instantiate(slot0.itemGo_, slot0.transform_))
			slot6 = slot0.items_[slot4]
			slot6:GetToggle().group = slot0.toggleGroup_
			slot6 = slot0.items_[slot4]
			slot6 = slot6:GetToggle().onValueChanged

			slot6:AddListener(function (slot0)
				if slot0 then
					uv0:NotifySelect(uv0.tag_, uv1, uv0.list_[uv1])
				end
			end)
		end

		slot0.items_[slot4]:SetData(slot0.tag_, slot0.list_[slot4], slot0.matrix_activity_id)
	end

	while #slot0.items_ > #slot0.list_ do
		slot1 = slot0.items_[#slot0.items_]

		SetActive(slot1.gameObject_, false)
		slot0:DisposeItem(slot1)
		table.remove(slot0.items_, #slot0.items_)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

return slot0
