slot0 = class("SequentialBattleBuffInfoCondition", ReduxView)

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

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.descText_.text = SequentialBattleBuffCfg[slot3].type_desc[slot4]

	if slot2 then
		slot8 = SequentialBattleBuffCfg[slot3].type

		if slot8[slot4][3] <= SequentialBattleTools.GetConditionStatus(slot0:GetHeroList(slot1, table.keyof(SequentialBattleChapterCfg[slot1].stage_id, slot2)), slot8)[slot4] then
			slot0.cntText_.text = string.format("<color=#6AA788>%s/%s</color>", slot9[slot4], slot8[slot4][3])
		else
			slot0.cntText_.text = string.format("<color=#F96763>%s/%s</color>", slot9[slot4], slot8[slot4][3])
		end
	else
		slot0.cntText_.text = ""
	end

	slot0:Show(true)
end

function slot0.GetHeroList(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(SequentialBattleData:GetChapterData(slot1).team[slot2].heroList) do
		if slot9.heroID and slot9.heroID ~= 0 then
			table.insert(slot4, slot9.heroID)
		end
	end

	return slot4
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
