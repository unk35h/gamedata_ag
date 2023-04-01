slot0 = class("SequentialBattleFactoryTeamBuff", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.SetData(slot0, slot1)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/BuffIcon/maedukAffix/" .. PublicBuffCfg[AffixTypeCfg[slot1].affix_buff_id].icon)

	slot0:Show(true)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
