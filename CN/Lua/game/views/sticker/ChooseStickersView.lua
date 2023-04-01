slot0 = class("ChooseStickersView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/StickerNEW/ChooseStickersUI_New"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.icon_ = {
		slot0.img_1,
		slot0.img_2,
		slot0.img_3
	}
	slot0.sizeTgl_ = {
		slot0.toggle_1,
		slot0.toggle_2,
		slot0.toggle_3
	}
	slot0.sizeCon_ = {
		ControllerUtil.GetController(slot0.rect_s, "state"),
		ControllerUtil.GetController(slot0.rect_m, "state"),
		ControllerUtil.GetController(slot0.rect_l, "state")
	}
	slot0.lockCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
	slot0.scrollList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, StickerChooseItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.allStickerList_[slot1].id

	slot2:RefreshItem(slot3)
	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelected(slot3 == slot0.curID_)
	slot2:RegisterClickListener(function ()
		uv0:SetCurID(uv1.itemID_)
		uv0:RefreshList()
	end)
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.sizeTgl_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0.curSize_ = uv1

			uv0:RefreshIcon()
			uv0:RefreshBtn()
			uv0:RefreshSize()

			if uv0.curID_ == uv0.oldStickerID_ then
				manager.notify:CallUpdateFunc(CHANGE_STICKER_SIZE, uv0.curIndex_, uv0.curID_, uv0.curSize_)
				uv0:Back()
			end
		end)
	end

	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.curID_ == uv0.oldStickerID_ and uv0.curSize_ == uv0.info_.size then
			uv0.curID_ = 0
		end

		manager.notify:CallUpdateFunc(CHANGE_STICKER, uv0.curIndex_, uv0.curID_, uv0.curSize_)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.allStickerList_ = {}
	slot0.info_ = slot0.params_.info
	slot0.curSize_ = slot0.info_.size
	slot0.curList_ = slot0:GetCurList()
	slot0.viewID_ = slot0.params_.viewID
	slot0.curIndex_ = slot0.params_.site
	slot0.oldStickerID_ = slot0.info_.stickerID
	slot0.curID_ = slot0.oldStickerID_

	slot0:GetAllSticker()

	if slot0.curID_ == 0 then
		slot0.curID_ = slot0.allStickerList_[1].id
	end

	slot0:RefreshUI()
	slot0.scrollList_:StartScroll(#slot0.allStickerList_)
end

function slot0.GetCurList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.list) do
		table.insert(slot1, slot6.stickerID)
	end

	return slot1
end

function slot0.GetAllSticker(slot0)
	slot3 = PlayerData
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetStickerList(slot5)) do
		slot7 = PlayerData:GetSticker(slot5)

		if ItemCfg[slot5].sub_type ~= 1302 or slot7.unlock ~= 0 then
			table.insert(slot0.allStickerList_, slot7)
		end
	end

	table.sort(slot0.allStickerList_, function (slot0, slot1)
		slot3 = uv0:IsUsed(slot1.id)

		if uv0:IsUsed(slot0.id) and slot3 then
			return table.indexof(uv0.curList_, slot0.id) < table.indexof(uv0.curList_, slot1.id)
		elseif slot2 or slot3 then
			return slot2
		end

		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)
end

function slot0.IsUsed(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.curList_) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.RefreshUI(slot0)
	slot0:SetCurID(slot0.curID_)
	slot0:RefreshSize()
end

function slot0.SetCurID(slot0, slot1)
	slot0.curID_ = slot1
	slot3 = ItemCfg[slot0.curID_]

	slot0:RefreshIcon()
	slot0:RefreshBtn()
	slot0.lockCon_:SetSelectedState(PlayerData:GetSticker(slot0.curID_).unlock == 0 and "lock" or "default")

	slot0.nameTxt_.text = slot3.name
	slot0.descTxt_.text = slot3.desc
	slot0.wayTxt_.text = slot3.desc_source
end

function slot0.RefreshBtn(slot0)
	if slot0.curID_ == slot0.oldStickerID_ then
		slot0.btnTxt_.text = GetTips("CHIP_UNLOAD")
	elseif slot0:IsUsed(slot0.curID_) then
		slot0.btnTxt_.text = GetTips("TIP_CHANGE")
	else
		slot0.btnTxt_.text = GetTips("TIP_DISPLAY")
	end
end

function slot0.RefreshIcon(slot0)
	slot0.icon_[slot0.curSize_].sprite = ItemTools.getItemSprite(slot0.curID_, {
		size = slot0.curSize_
	})
end

function slot0.RefreshList(slot0)
	slot3 = slot0.scrollList_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:SetSelected(slot5.itemID_ == slot0.curID_)
		slot5:SetUsed(slot0:IsUsed(slot5.itemID_))
	end
end

function slot0.RefreshSize(slot0)
	slot2 = StickViewTemplateCfg[slot0.viewID_].range_list[slot0.curIndex_][2]

	for slot6 = 1, 3 do
		if not table.indexof(slot2, slot6) then
			slot0.sizeCon_[slot6]:SetSelectedState(2)
		elseif slot6 == slot0.curSize_ then
			slot0.sizeCon_[slot6]:SetSelectedState(3)
		else
			slot0.sizeCon_[slot6]:SetSelectedState(1)
		end
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
