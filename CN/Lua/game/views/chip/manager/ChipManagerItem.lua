slot0 = class("ChipManagerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.handler_ = handler(slot0, slot0.RefreshEnabledUI)

	manager.notify:RegistListener(ENABLED_CHIP_MANAGER, slot0.handler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/chipManager", {
			chipManagerID = uv0.chipManagerID_
		})
	end)
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID_ = slot1
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.selectGo_, slot1)
	slot0:RefreshEnabledUI()

	slot0.gameObject_.name = slot0.chipManagerID_
	slot0.icon_.sprite = getSpriteViaConfig("ChipIcon", ChipCfg[slot0.chipManagerID_].picture_id)

	SetActive(slot0.lockGo_, table.keyof(slot0:GetUnlockChipManagerList(), slot0.chipManagerID_) == nil)
	slot0:BindRedPoint()
end

function slot0.RefreshEnabledUI(slot0)
	SetActive(slot0.usingGo_, slot0.chipManagerID_ == slot0:GetEnabledChipManagerID())
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ENABLED_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil
end

function slot0.GetUnlockChipManagerList(slot0)
	return ChipData:GetUnlockChipManagerIDList()
end

function slot0.GetEnabledChipManagerID(slot0)
	return ChipData:GetEnabledChipManagerID()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.notice_, string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot0.chipManagerID_), {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.notice_)
end

return slot0
