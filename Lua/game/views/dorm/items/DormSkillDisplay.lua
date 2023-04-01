slot0 = class("DormSkillDisplay", ReduxView)

function slot0.OnCtor(slot0, slot1)
	if slot1 then
		slot0:BindCfgUI(slot1)
	end
end

function slot1(slot0)
	return "skill: " .. slot0
end

function slot2(slot0)
	return getSpriteWithoutAtlas("skill_icon_" .. slot0)
end

function slot0.SetData(slot0, slot1)
	slot2 = BackHomeHeroCfg[slot1]

	if slot0.desc_1 then
		slot0.desc_1.text = uv0(slot2.skill_list[1])
	end

	if slot0.desc_2 then
		slot0.desc_2.text = uv0(slot2.skill_list[2])
	end

	slot3 = uv1(slot2.skill_list[1])
	slot4 = uv1(slot2.skill_list[2])

	if slot0.icon_1 and slot3 then
		slot0.icon_1.sprite = slot3
	end

	if slot0.icon_2 and slot4 then
		slot0.icon_2.sprite = slot4
	end
end

return slot0
