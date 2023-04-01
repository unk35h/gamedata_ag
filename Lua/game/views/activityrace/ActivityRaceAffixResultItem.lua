slot0 = class("ActivityRaceAffixResultItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.affixID_ = slot1

	if slot0.affixID_ then
		if PublicBuffCfg[AffixTypeCfg[slot0.affixID_].affix_buff_id].icon == "" then
			-- Nothing
		end

		slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. slot3)
		slot0.name_.text = slot2.name
	end
end

return slot0
