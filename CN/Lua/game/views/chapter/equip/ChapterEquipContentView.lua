slot0 = class("ChapterEquipContentView", import("..ChapterBaseContentView"))

function slot0.RefreshMapItems(slot0)
	for slot6 = #slot0.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		if slot2[slot6] == 203 then
			table.insert(slot0.itemList_, ChapterEquipEnchantmentItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot6))
		elseif slot2[slot6] == 204 then
			table.insert(slot0.itemList_, ChapterEquipExperienceItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot6))
		elseif slot2[slot6] == 205 then
			table.insert(slot0.itemList_, ChapterEquipBreakThroughMaterialItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot6))
		else
			table.insert(slot0.itemList_, ChapterEquipItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot6))
		end
	end
end

return slot0
