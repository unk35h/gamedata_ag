slot0 = singletonClass("TalentTreeData")
talentList_ = {}

function slot0.InitData(slot0)
	talentList_ = {}
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		talentList_[slot6.id] = slot6.level
	end
end

function slot0.UpTalent(slot0, slot1)
	talentList_[slot1] = (talentList_[slot1] or 0) + 1
end

function slot0.GetTalentList(slot0)
	return talentList_
end

function slot0.GetTalentLevel(slot0, slot1)
	return talentList_[slot1] or 0
end

function slot0.GetTalentListByTheme(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(talentList_) do
		if ActivityTools.GetActivityTheme(TalentTreeCfg[slot6].activity_id) == slot1 then
			table.insert(slot2, {
				slot8.affix_id,
				slot7,
				slot8.affix_user
			})
		end
	end

	return slot2
end

return slot0
