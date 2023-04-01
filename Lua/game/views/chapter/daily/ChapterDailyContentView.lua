slot0 = class("ChapterDailyContentView", import("..ChapterBaseContentView"))

function slot0.RefreshMapItems(slot0)
	for slot6 = #slot0.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		table.insert(slot0.itemList_, slot0:CreateItem(slot2[slot6]))
	end
end

function slot0.CreateItem(slot0, slot1)
	slot3 = ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]]

	return ChapterDailyItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)
end

return slot0
