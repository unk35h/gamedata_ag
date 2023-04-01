slot0 = class("MatrixProcessAstrolabeRewardItem", MatrixProcessRewardItem)

function slot0.UpdateAstrolabePreview(slot0)
	if MatrixItemCfg[slot0.id].matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	slot3 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1.params[1]]
	slot4 = math.floor(slot1.params[1] / 1000)
	slot12 = slot0:GetHeroSkin(slot4)
	slot0.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", slot12)
	slot11 = slot0:GetHeroData(slot4):GetAstrolabeNum(slot1.params[1])
	slot6 = math.min(3, slot11)

	for slot11, slot12 in ipairs(slot0.astrolabeImgs_) do
		if slot11 <= slot6 then
			SetActive(slot12.gameObject, true)

			slot12.sprite = MatrixTools.GetMatrixItemSprite(slot0.id)
		else
			SetActive(slot12.gameObject, false)
		end
	end

	if slot6 > 0 then
		slot8 = slot3[slot6]

		slot0:SetDesc(GetCfgDescription(AstrolabeEffectCfg[slot8].desc[1], 1))

		slot12 = HeroAstrolabeCfg[slot8]
		slot0.m_name1.text = slot12.name
		slot0.m_name2.text = slot12.name
	else
		slot0:SetDesc(slot1.desc)
	end
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

return slot0
