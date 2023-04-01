slot0 = class("polyhedronDifficultyItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()

	if slot2[1] == 1 then
		slot5 = slot2[3]
		slot7 = {
			slot2[2],
			slot5,
			slot2[4]
		}
		slot0.m_name.text = getAffixName(slot7) .. NumberTools.IntToRomam(slot5)
		slot0.m_des.text = getAffixDesc(slot7)
		slot0.m_icon.sprite = getAffixSprite(slot7)
	elseif slot3 == 2 then
		slot5 = slot2[3]

		if PublicAttrCfg[slot2[2]].percent == 1 then
			slot5 = slot5 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[slot4] ~= nil then
			slot0.m_name.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot4][2])
			slot0.m_des.text = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot4][3]) .. slot5
		else
			slot0.m_name.text = slot6.name
			slot0.m_des.text = slot6.name .. slot5
		end

		slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. slot4)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_desTrans)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
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

function slot0.SetData(slot0, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
