slot0 = class("SequentialBattleBossInfoItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.skillList_ = {}
	slot0.scrollRectCast_ = slot0:FindCom("ScrollRectCast", "", slot0.scrollView_.transform)

	slot0.scrollRectCast_:SetParent(slot0.parentGo_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.skillList_) do
		slot5:Dispose()
	end

	slot0.skillList_ = nil
end

function slot0.SetBossID(slot0, slot1, slot2)
	slot0.bossID_ = slot1
	slot0.portraitImage_.sprite = getSpriteWithoutAtlas(string.format("Textures/MardukUI/boss/solo582x648/%s", slot1))
	slot3 = CollectMonsterCfg[slot1]
	slot0.nameText_.text = slot3.name
	slot8 = slot3.race
	slot0.tagText_.text = GetTips("RACE_TYPE_" .. slot8)
	slot4 = 1

	for slot8 = 1, 6 do
		if slot3[string.format("skill%s", slot8)] ~= "" then
			if not slot0.skillList_[slot4] then
				slot0.skillList_[slot4] = BattleBossChallengeSkillItem.New(slot0.skillItem_, slot0.skillParent_)
			end

			slot0.skillList_[slot4]:SetText(slot9, slot3[string.format("skill_desc%s", slot8)])
			slot0.skillList_[slot4]:Show(true)

			slot4 = slot4 + 1
		end
	end

	for slot8 = slot4, #slot0.skillList_ do
		slot0.skillList_[slot8]:Show(false)
	end

	slot0.lvText_.text = NumberTools.IntToRomam(slot2)
end

return slot0
