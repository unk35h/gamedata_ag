slot0 = import(".HeroReducer")

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {}
	end

	function slot3(slot0)
		slot1 = uv0.data
		slot0[slot1.id] = uv1(slot0[slot1.id], uv0)
	end

	if ({
		[ACTIONS.HERO_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot0[slot5.id] = uv1(slot0[slot5.id], {
					type = ACTIONS.HERO_INIT,
					data = slot5
				})
			end
		end,
		[ACTIONS.HERO_MODIFY] = slot3,
		[ACTIONS.HERO_EXP_ADD_SUCCESS] = slot3,
		[ACTIONS.HERO_UNLOCK_SUCCESS] = slot3,
		[ACTIONS.HERO_SKILL_UP_SUCCESS] = slot3,
		[ACTIONS.HERO_UNLOCK_TALENT_SUCCESS] = slot3,
		[ACTIONS.HERO_EQUIP_TALENT_SUCCESS] = slot3,
		[ACTIONS.HERO_EQUIP_TALENT_ALL_SUCCESS] = slot3,
		[ACTIONS.HERO_PIECE_MODIFY] = slot3,
		[ACTIONS.HERO_STAR_UP_SUCCESS] = slot3,
		[ACTIONS.HERO_EQUIP_CHANGE] = slot3,
		[ACTIONS.HERO_CHAT_READ] = slot3,
		[ACTIONS.HERO_CARE_MODIFY] = slot3,
		[ACTIONS.HERO_NICK_MODIFY] = slot3,
		[ACTIONS.HERO_GIFT_GET] = slot3,
		[ACTIONS.HERO_CLEAR_MISSION] = slot3,
		[ACTIONS.HERO_CLEAR_TIMES] = slot3,
		[ACTIONS.HERO_BREAK_SUCCESS] = slot3,
		[ACTIONS.HERO_SERVANT_REPLACE] = slot3,
		[ACTIONS.HERO_WEAPON_STR] = slot3,
		[ACTIONS.HERO_WEAPON_BREAK] = slot3,
		[ACTIONS.APPLY_SWAP_EQUIP_SUCCESS] = function (slot0)
			slot1 = uv0.data.equipID
			slot2 = uv0.data.pos
			slot3 = uv0.data.heroID

			if uv0.data.oldUseHeroID then
				if slot4 == slot3 or slot3 == 0 then
					slot0[slot3].equip[slot2] = {
						equip_id = 0,
						pos = slot2
					}
				else
					slot0[slot4].equip[slot2] = {
						equip_id = 0,
						pos = slot2
					}
					slot0[slot3].equip[slot2] = {
						equip_id = slot1,
						pos = slot2
					}
				end
			elseif slot3 ~= 0 then
				slot0[slot3].equip[slot2] = {
					equip_id = slot1,
					pos = slot2
				}
			end
		end,
		[ACTIONS.HERO_CHAT_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot0[slot5.hero_id] = uv1(slot0[slot5.hero_id], {
					type = ACTIONS.HERO_CHAT_INIT,
					data = slot5
				})
			end
		end,
		[ACTIONS.HERO_CHAT_MODIFY] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot0[slot5.hero_id] = uv1(slot0[slot5.hero_id], {
					type = ACTIONS.HERO_CHAT_MODIFY,
					data = slot5
				})
			end
		end,
		[ACTIONS.HERO_SKIN_ADD] = function (slot0)
			slot2 = SkinCfg[uv0.data.skinId]
			slot0[HeroCfg[slot2.hero].id] = uv1(slot0[slot2.hero], uv0)
		end,
		[ACTIONS.SELECT_SKIN] = function (slot0)
			slot2 = SkinCfg[uv0.data.skinId]
			slot0[HeroCfg[slot2.hero].id] = uv1(slot0[slot2.hero], uv0)
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
