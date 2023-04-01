slot0 = class("SectionSelectHeroBuffItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/BuffIcon/maedukAffix/" .. PublicBuffCfg[AffixTypeCfg[SequentialBattleBuffCfg[slot1].affix_id].affix_buff_id].icon)
end

return slot0
