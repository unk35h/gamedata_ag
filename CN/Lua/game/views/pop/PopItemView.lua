slot0 = class("PopItemView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopItemUI"
end

function slot0.OnCtor(slot0, ...)
	slot1, slot2 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(slot1)) == "/" then
		slot1 = string.sub(slot1, 2)
	end

	slot0.lastRecord_ = slot1

	OperationRecorder.Record(slot0.lastRecord_, "PopItemView")
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.itemInfo_ = slot0.params_.popItemInfo
	slot0.extraInfo_ = slot0.params_.extraInfo or {}

	slot0:RefreshCommonItem()
	slot0:RefreshContent()
	slot0:RefreshCount()

	if ItemCfg[slot0.itemInfo_[1]].type == ItemConst.ITEM_TYPE.CURRENCY or slot2 == ItemConst.ITEM_TYPE.HERO or slot2 == ItemConst.ITEM_TYPE.STICKER or slot2 == ItemConst.ITEM_TYPE.STICKER_BG or slot2 == ItemConst.ITEM_TYPE.CLUB_COMMON or slot2 == ItemConst.ITEM_TYPE.GIFT and (slot1.sub_type == ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE or slot1.sub_type == ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE_UP or slot1.sub_type == ItemConst.ITEM_SUB_TYPE.DROP_ITEM) then
		SetActive(slot0.cntPanel_, false)
	else
		SetActive(slot0.cntPanel_, true)
	end

	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialUpdate))
end

function slot0.OnMaterialUpdate(slot0, slot1)
	if slot1 == slot0.itemInfo_[1] then
		slot0:RefreshCount()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot0.commonItemView_:Dispose()

	slot0.commonItemView_ = nil
	slot0.maskBtn_ = nil
	slot0.nameText_ = nil
	slot0.countentText_ = nil
	slot0.sourceBtn_ = nil
	slot0.sourceBtnGo_ = nil
	slot0.operatePanel_ = nil
	slot0.useBtn_ = nil
	slot0.cntPanel_ = nil
	slot0.cntText_ = nil
	slot0.commonItem_ = nil
	slot0.sourcePanel_ = nil
	slot0.infoBtn_ = nil
	slot0.sourceParent_ = nil
	slot0.unlockItem_ = nil
	slot0.lockItem_ = nil
	slot0.invalidItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isCountdownController = ControllerUtil.GetController(slot0.gameObject_.transform, "isCountdown")
	slot0.useNumTriggerListener_ = slot0.useNumSlider_.gameObject.transform:GetComponent(typeof(EventTriggerListener))

	slot0:CustomInitUI()
end

function slot0.CustomInitUI(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.RefreshContent(slot0)
	slot1 = ItemCfg[slot0.itemInfo_[1]]
	slot0.nameText_.text = slot1.name
	slot0.countentText_.text = slot1.desc

	if ItemTools.GetItemExpiredTimeByInfo({
		id = slot0.itemInfo_[1],
		num = slot0.itemInfo_[2],
		time_valid = slot0.itemInfo_[4]
	}) == nil or slot3 == 0 then
		slot0.isCountdownController:SetSelectedState("false")
	else
		slot0.isCountdownController:SetSelectedState("true")

		slot0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(ItemTools.GetItemExpiredTimeByInfo(slot2), "!%Y/%m/%d %H:%M"))
	end
end

function slot0.RefreshCommonItem(slot0)
	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItem.New(slot0.commonItem_)
	end

	slot0.commonItemView_:RefreshData(formatReward(slot0.itemInfo_))
	slot0.commonItemView_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)

	if ItemCfg[slot0.itemInfo_[1]] and ItemConst.ITEM_TYPE.HERO == slot1.type then
		slot0.commonItemView_:HideNum()
	else
		slot0.commonItemView_:HideNum()
	end
end

function slot0.SetCommonItem(slot0)
	slot0.itemInfo_[2] = ItemTools.getItemNum(slot0.itemInfo_[1])

	slot0:RefreshCommonItem()
end

function slot0.RefreshCount(slot0)
	slot0.cntText_.text = string.format("x%s", NumberTools.RetractNumberForWindBar(ItemTools.getItemNum(slot0.itemInfo_[1], ItemTools.GetItemExpiredTimeByInfo({
		id = slot0.itemInfo_[1],
		num = slot0.itemInfo_[2],
		time_valid = slot0.itemInfo_[4]
	}))))
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
