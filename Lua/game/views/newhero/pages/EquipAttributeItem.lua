slot0 = class("EquipAttributeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelText_ = {}

	for slot4 = 1, 6 do
		slot0.levelText_[slot4] = slot0["lv_" .. slot4]
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_({
				id = uv0.attrID_,
				num = uv0.skillSum_
			})
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.attrID_ = slot1
	slot0.data_ = slot2
	slot0.isAdd_ = slot3

	slot0:RefreshAttr()
end

function slot0.RefreshAttr(slot0)
	slot1 = 0
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.data_) do
		slot1 = slot1 + slot7.level
		slot2[slot8] = (slot2[slot7.pos] or 0) + slot9
	end

	for slot6 = 1, 6 do
		slot0.levelText_[slot6].text = slot2[slot6] and slot2[slot6] or ""
	end

	slot0.skillSum_ = EquipSkillCfg[slot0.attrID_].lvmax <= slot1 + (slot0.isAdd_ and 1 or 0) and slot4.lvmax or slot1
	slot0.icon_.sprite = getEquipSkillSprite(slot0.attrID_)
	slot0.name_.text = slot4.name
	slot0.desc_.text = string.format(slot4.desc, slot4.upgrade / slot4.percent * slot0.skillSum_)

	if slot0.isAdd_ then
		slot0.level_.text = "<color=#FF9500>" .. slot1 .. "</color>/" .. slot4.lvmax
	else
		slot0.level_.text = slot1 .. "/" .. slot4.lvmax
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
