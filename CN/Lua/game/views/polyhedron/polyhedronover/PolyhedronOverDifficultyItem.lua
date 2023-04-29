slot0 = class("PolyhedronOverDifficultyItem", ReduxView)

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
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.name, uv0.desc, uv0.transform_.position, uv0.level)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot1 == 1 then
		slot3 = slot2
		slot0.m_icon.sprite = getAffixSprite(slot3)
		slot0.name = getAffixName(slot3)
		slot0.desc = getAffixDesc(slot3)
	elseif slot1 == 2 then
		slot4 = slot2[2]

		if PublicAttrCfg[slot2[1]].percent == 1 then
			slot4 = slot4 / 10 .. "%"
		end

		if PolyhedronConst.SPECIAL_ATTR_DESC[slot3] ~= nil then
			slot0.name = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot3][2])
			slot0.desc = GetTips(PolyhedronConst.SPECIAL_ATTR_DESC[slot3][3]) .. slot4
		else
			slot0.name = slot5.name
			slot0.desc = slot5.name .. slot4
		end

		slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.HERO_ATTRIBUTE_ICON_PATH .. slot3)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
