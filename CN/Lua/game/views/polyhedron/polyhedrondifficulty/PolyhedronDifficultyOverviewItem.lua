slot0 = class("PolyhedronDifficultyOverviewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot1 == 1 then
		slot3 = slot2
		slot0.m_des.text = getAffixName(slot3) .. NumberTools.IntToRomam(slot3[2]) .. "\n" .. getAffixDesc(slot3)
		slot0.m_icon.sprite = getAffixSprite(slot3)
	elseif slot1 == 2 then
		slot4 = slot2[2]

		if PublicAttrCfg[slot2[1]].percent == 1 then
			slot4 = slot4 / 10 .. "%"
		end

		slot0.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot3][2]) .. "\n" .. GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot3][3]) .. slot4
		slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. slot3)
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
