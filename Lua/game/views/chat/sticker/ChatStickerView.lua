slot0 = class("ChatStickerView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.categoryItemList_ = {}
	slot5 = slot0.uiList_
	slot6 = ChatStickerItem
	slot0.stickerUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot5, slot6)

	for slot5, slot6 in ipairs(ChatStickerCategoryCfg.all) do
		slot0.categoryItemList_[slot5] = ChatStickerCategoryItem.New(slot0.categoryItem_, slot0.categoryParent_, slot6)
	end

	slot0.changeStickerCategoryHandler_ = handler(slot0, slot0.ChangeStickerCategory)
	slot0.selectCategoryID_ = ChatStickerCategoryCfg.all[1]
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(CHAT_CHANGE_STICKER_CATEGORY, slot0.changeStickerCategoryHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAT_CHANGE_STICKER_CATEGORY, slot0.changeStickerCategoryHandler_)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = {}

	if slot0.selectCategoryID_ == 0 then
		slot3 = ChatStickerData:GetCustomStickerList()

		if slot1 == 1 then
			slot2:RefreshData(0)
		else
			slot2:RefreshData(slot3[slot1 - 1])
		end
	else
		slot2:RefreshData(ChatStickerCfg.get_id_list_by_category[slot0.selectCategoryID_][slot1])
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.changeStickerCategoryHandler_ = nil

	for slot4, slot5 in ipairs(slot0.categoryItemList_) do
		slot5:Dispose()
	end

	slot0.categoryItemList_ = nil

	slot0.stickerUIList_:Dispose()

	slot0.stickerUIList_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:ChangeStickerCategory(slot0.selectCategoryID_)
	end
end

function slot0.ChangeStickerCategory(slot0, slot1)
	slot0.selectCategoryID_ = slot1 or slot0.selectCategoryID_

	for slot5, slot6 in ipairs(slot0.categoryItemList_) do
		slot6:RefreshSelectID(slot0.selectCategoryID_)
	end

	slot0:RefreshChateSticker()
end

function slot0.RefreshChateSticker(slot0)
	slot1 = 0

	slot0.stickerUIList_:StartScroll(slot0.selectCategoryID_ == 0 and #ChatStickerData:GetCustomStickerList() + 1 or #ChatStickerCfg.get_id_list_by_category[slot0.selectCategoryID_])
end

return slot0
