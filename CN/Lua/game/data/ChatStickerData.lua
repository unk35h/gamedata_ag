slot0 = singletonClass("ChatStickerData")

function slot0.Init(slot0)
	slot0.customStickerList_ = {}
	slot0.customStickerUIList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot0.customStickerList_ = {}

	for slot5, slot6 in ipairs(slot1.emoticon_id_list) do
		table.insert(slot0.customStickerList_, slot6)
	end
end

function slot0.GetCustomStickerList(slot0)
	return slot0.customStickerList_
end

function slot0.SetCustomStickerList(slot0, slot1)
	slot0.customStickerList_ = slot1
end

function slot0.GetCustomStickerUIList(slot0)
	return slot0.customStickerUIList_
end

function slot0.InitStickerUIList(slot0)
	slot0.customStickerUIList_ = clone(slot0.customStickerList_)
end

function slot0.ChangeCustomStickerUIList(slot0, slot1)
	if table.keyof(slot0.customStickerUIList_, slot1) then
		table.remove(slot0.customStickerUIList_, slot2)
	else
		table.insert(slot0.customStickerUIList_, slot1)
	end
end

function slot0.SaveData(slot0)
	slot0.customStickerList_ = clone(slot0.customStickerUIList_)
end

return slot0
