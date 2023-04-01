slot0 = import("game.tools.HeroTools")
slot1 = import("game.tools.EquipTools")
slot2 = import("game.tools.LvTools")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			talent = 0,
			hero = {}
		}
	end

	if ({
		[ACTIONS.PREVIEW_HERO_GET] = function (slot0)
			slot1 = uv0.data
			slot0.hero = {
				hero_id = slot1.hero_id,
				hero_level = slot1.hero_level or uv1.CheckExp(1, slot1.exp, "user_level_exp"),
				hero_star = slot1.hero_star or slot1.star,
				hero_rune = {},
				hero_using_talent = {},
				hero_equip = {}
			}
			slot2 = ipairs
			slot4 = slot1.hero_skill_list or {}

			for slot5, slot6 in slot2(slot4) do
				slot0.hero.hero_rune[slot5] = slot6
			end

			slot2 = ipairs
			slot4 = slot1.hero_using_talent or {}

			for slot5, slot6 in slot2(slot4) do
				slot0.hero.hero_using_talent[slot5] = {
					pos = slot6.pos,
					astrolabe_id = slot6.talent_id
				}
			end

			slot2 = ipairs
			slot4 = slot1.astrolabe_list or {}

			for slot5, slot6 in slot2(slot4) do
				slot0.hero.hero_using_talent[slot5] = {
					pos = slot6.pos,
					astrolabe_id = slot6.astrolabe_id
				}
			end

			slot2 = {}
			slot3 = ipairs
			slot5 = slot1.hero_equip_list or {}

			for slot6, slot7 in slot3(slot5) do
				if slot7.equip_info and slot7.equip_info.prefab_id ~= 0 then
					slot0.hero.hero_equip[slot7.pos] = {
						equip_id = slot7.equip_info.equip_id,
						prefab_id = slot7.equip_info.prefab_id,
						level = slot7.equip_info.level,
						star = slot7.equip_info.star,
						attributes = {}
					}
					slot11 = slot0.hero.hero_equip[slot7.pos]
					slot12 = slot0.hero.hero_equip[slot7.pos].level
					slot0.hero.hero_equip[slot7.pos].exp = uv2.CountNeedExp(slot11, slot12, slot0.hero.hero_equip[slot7.pos].star)

					for slot11, slot12 in ipairs(slot7.equip_info.attribute_list) do
						slot0.hero.hero_equip[slot7.pos].attributes[slot11] = slot12
					end

					for slot12, slot13 in pairs(uv2.CountEquipAttribute(slot0.hero.hero_equip[slot7.pos])) do
						if slot2[slot12] == nil then
							slot2[slot12] = 0
						end

						slot2[slot12] = slot2[slot12] + slot13
					end
				end
			end

			slot3 = ipairs
			slot5 = slot1.equip_list or {}

			for slot6, slot7 in slot3(slot5) do
				if slot7.prefab_id ~= 0 then
					slot0.hero.hero_equip[slot6] = {
						equip_id = slot7.equip_id,
						prefab_id = slot7.prefab_id,
						exp = slot7.exp,
						star = slot7.star,
						attributes = {}
					}
					slot11 = slot0.hero.hero_equip[slot6]
					slot0.hero.hero_equip[slot6].level = uv2.CountEquipLevel(slot11)

					for slot11, slot12 in ipairs(slot7.attribute_list) do
						slot0.hero.hero_equip[slot6].attributes[slot11] = slot12
					end

					for slot12, slot13 in pairs(uv2.CountEquipAttribute(slot0.hero.hero_equip[slot6])) do
						if slot2[slot12] == nil then
							slot2[slot12] = 0
						end

						slot2[slot12] = slot2[slot12] + slot13
					end
				end
			end

			slot3 = uv3.CaculateHeroAttribute(slot1, slot2)

			uv3.CalFinalAttribute(slot3)

			slot0.hero.hero_attribute = slot3
		end,
		[ACTIONS.PREVIEW_HERO_TALENT_SELECT] = function (slot0)
			slot0.talent = uv0.data
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
