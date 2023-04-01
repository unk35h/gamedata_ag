slot0 = class("HeroChipItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.notify:Invoke(ON_CLICK_HEROCHIP_ITEM, uv0.chipID_)
	end)
end

function slot0.SetChipID(slot0, slot1, slot2)
	slot0.chipID_ = slot1
	slot0.curHeroId_ = slot2
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.gameObject_.name = slot0.chipID_
	slot0.curHeroId_ = slot2
	slot3 = ChipCfg[slot0.chipID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot3.picture_id)
	slot0.name_.text = slot3.suit_name

	SetActive(slot0.lockGo_, table.keyof(ChipData:GetUnlockHeroChipIDList(), slot0.chipID_) == nil)
	SetActive(slot0.useGo_, ChipData:GetHeroChipIsEnableByChipId(slot0.chipID_))
	SetActive(slot0.selectGo_, slot0.chipID_ == slot1)
	SetActive(slot0.prohibitGo_, false)
	slot0:BindRedPoint()
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.notice_, string.format("%s_%s", slot0.curHeroId_, slot0.chipID_), {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.notice_)
end

return slot0
