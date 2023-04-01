slot0 = class("ChooseStickerBgView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/StickerNEW/StickerChooseBgUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.scrollList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, StickerBgItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.list_[slot1]

	slot2:RefreshUI(slot3)

	if slot3 == slot0.chooseID_ then
		slot2:SetState("use")
	elseif PlayerData:GetStickerBg(slot3).unlock ~= 0 then
		slot2:SetState("change")
	else
		slot2:SetState("lock")
	end

	slot2:SetSelected(slot3 == slot0.curID_)

	tip = manager.redPoint:getTipValue(RedPointConst.STICKER_BG .. "_" .. slot3)

	slot2:SetNew(tip > 0)
	slot2:RegistClickFunc(function ()
		uv0:SetBgID(uv1)

		if tip > 0 then
			RedPointData:SetRedPointOpen(RedPointConst.STICKER_BG_RANGE + uv1, false)
			manager.redPoint:setTip(RedPointConst.STICKER_BG .. "_" .. uv1, 0)
			uv2:SetNew(false)
			RedPointAction.HandleRedPoint(RedPointConst.STICKER_BG_RANGE + uv1)
		end
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		uv0.params_.temp.stickerBg = uv0.curID_

		uv0:Back(1, {
			type = 2,
			tempInfo = uv0.params_.temp
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.chooseID_ = slot0.params_.chooseID
	slot0.list_ = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:Sortlist()
	slot0:SetBgID(slot0.chooseID_)
	slot0.scrollList_:StartScroll(#slot0.list_, table.indexof(slot0.list_, slot0.chooseID_))
end

function slot0.Sortlist(slot0)
	table.sort(slot0.list_, function (slot0, slot1)
		if slot0 == uv0.chooseID_ or slot1 == uv0.chooseID_ then
			return slot0 == uv0.chooseID_
		end

		if PlayerData:GetStickerBg(slot0).unlock ~= PlayerData:GetStickerBg(slot1).unlock then
			return slot3 < slot2.unlock
		end

		return ItemCfg[slot0].display_order < ItemCfg[slot1].display_order
	end)
end

function slot0.SetBgID(slot0, slot1)
	slot0.curID_ = slot1

	slot0:RefreshInfo()
	slot0.scrollList_:Refresh()
end

function slot0.RefreshInfo(slot0)
	slot0.show_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_big_" .. slot0.curID_)
	slot0.desc_.text = ItemCfg[slot0.curID_].desc

	if slot0.curID_ == slot0.chooseID_ then
		slot0.stateCon_:SetSelectedState("use")
	elseif PlayerData:GetStickerBg(slot0.curID_).unlock ~= 0 then
		slot0.stateCon_:SetSelectedState("change")
	else
		slot0.stateCon_:SetSelectedState("lock")

		slot0.unlock_.text = ItemCfg[slot0.curID_].desc_source
	end
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back(1, {
			type = 2,
			tempInfo = uv0.params_.temp
		})
	end)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
