slot0 = class("EquipBagSuitDetailItem", ReduxView)

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
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.data, uv0.ids)
		end
	end)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data = slot2
	slot0.ids = {}
	slot3 = EquipSuitCfg[slot2]

	SetSpriteWithoutAtlasAsync(slot0.icon_, SpritePathCfg.EquipIcon.path .. slot3.equip_skill_icon)

	slot0.name_.text = slot3.name
	slot0.desc_.text = GetCfgDescription(EquipEffectCfg[slot3.suit_effect[1]].desc[1], 1)

	table.insert(slot0.ids, slot2)
end

function slot0.RefreshPos(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.ids) do
		slot2 = slot2 + EquipTools.GetSuitEquipNum(slot7, nil, slot1)
	end

	slot0:SetBottomText(slot2)
end

function slot0.SetBottomText(slot0, slot1)
	slot0.num_.text = slot1

	if slot0.maskGo_ then
		SetActive(slot0.maskGo_, slot1 == 0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

return slot0
