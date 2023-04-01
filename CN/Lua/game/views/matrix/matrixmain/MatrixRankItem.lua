slot0 = class("MatrixRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.heroCountController_ = ControllerUtil.GetController(slot0.transform_, "heroCount")
	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.Refresh(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.m_rankText.text = slot1.rank
	slot0.m_scoreText.text = slot1.score
	slot0.m_difficultyText.text = slot1.difficulty
	slot3 = math.min(table.length(slot1.select_hero_id_list), 3)
	slot7 = slot3

	slot0.heroCountController_:SetSelectedIndex(slot7)

	for slot7 = 1, slot3 do
		if HeroStandardSystemCfg[slot2[slot7].id] then
			slot10 = slot9.hero_id

			if slot8.skin_id == 0 then
				slot11 = slot10
			end

			slot0["m_heroIcon_" .. slot7].sprite = getSpriteViaConfig("HeroLittleIcon", slot11)
		end
	end

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.m_name.text = slot1.nick
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.m_frame.sprite = ItemTools.getItemSprite(slot1.icon_frame)
end

return slot0
