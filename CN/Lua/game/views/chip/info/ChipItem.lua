slot0 = class("ChipItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.notify:Invoke(ON_CLICK_CHIP_ITEM, uv0.chipID_)
	end)
end

function slot0.SetChipID(slot0, slot1)
	slot0.chipID_ = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.gameObject_.name = slot0.chipID_
	slot3 = ChipCfg[slot0.chipID_]
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", slot3.picture_id)
	slot0.name_.text = slot3.suit_name

	SetActive(slot0.lockGo_, table.keyof(slot0:GetUnlockChipIDList(), slot0.chipID_) == nil)
	SetActive(slot0.useGo_, table.keyof(slot0:GetManagerData(slot2), slot0.chipID_) ~= nil)
	SetActive(slot0.selectGo_, slot0.chipID_ == slot1)

	slot6 = false

	for slot10, slot11 in ipairs(slot5) do
		if ChipCfg[slot11].spec_char ~= 0 and slot11 ~= slot0.chipID_ then
			slot6 = slot6 or slot3.spec_char == slot12
		end
	end

	SetActive(slot0.prohibitGo_, slot6)
	slot0:BindRedPoint()
end

function slot0.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.GetUnlockChipIDList(slot0)
	return ChipData:GetUnlockChipIDList()
end

function slot0.GetManagerData(slot0, slot1)
	return ChipData:GetChipManagerList()[slot1]
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.notice_, string.format("%s_%s", RedPointConst.CHIP_CHIP, slot0.chipID_), {
		x = 0,
		y = 0
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.notice_)
end

return slot0
