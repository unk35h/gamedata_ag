HeroSorter = import("game.tools.HeroSorter")
slot1 = HeroSorter.New()
slot2 = {}
slot3 = 0

function slot4()
	return uv0 < #HeroRecordCfg.all
end

function slot5(slot0)
	slot1 = false

	for slot5 = uv0 + 1, #HeroRecordCfg.all do
		for slot12, slot13 in pairs(HeroRecordCfg[HeroRecordCfg.all[slot5]].hero_id) do
			uv1[slot13] = slot6

			if slot0 == slot13 then
				slot1 = true
			end
		end

		uv0 = slot5

		if slot1 then
			return slot6
		end
	end

	return nil
end

function slot6(slot0)
	if uv0[slot0] == nil then
		slot1 = uv1(slot0)
	end

	return slot1
end

return {
	GetNeedPreLoadHeroId = function ()
		slot0 = {}

		if HeroData:GetHeroList() == nil then
			return slot0
		end

		slot3 = HeroData
		slot5 = slot3
		slot1 = uv0.Sort(slot3.GetHeroList(slot5), true)

		for slot5 = 1, HeroConst.PRELOAD_HERO_NUM do
			if slot1[slot5] then
				slot0[slot1[slot5]] = true
			end
		end

		slot0[PlayerData:GetPlayerInfo().poster_girl] = true

		return slot0
	end,
	Sort = function (slot0, slot1)
		slot1 = slot1 or false
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" then
				if slot1 then
					table.insert(slot2, slot6)
				elseif slot7.hero_unlock == 1 or slot7.unlock == 1 then
					table.insert(slot2, slot6)
				end
			end
		end

		return uv0:SortWithId(slot2)
	end,
	SortHero = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insert(slot1, slot6)
		end

		return uv0:SetUnlockFirst(true):SortWithId(slot1)
	end,
	Count = function (slot0)
		slot1 = 0
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" then
				if slot7.hero_unlock == 1 or slot7.unlock == 1 then
					slot1 = slot1 + 1
				end

				slot2 = slot2 + 1
			end
		end

		return slot1, slot2
	end,
	GetStarCnt = function (slot0)
		return math.floor(slot0 / 100)
	end,
	GetStarCfgId = function (slot0, slot1)
		return slot0 * 100 + slot1
	end,
	GetNextStarAndPhase = function (slot0, slot1)
		if slot0 == HeroConst.MAX_STAR then
			return slot0, slot1
		end

		if HeroConst.PER_STAR_PHASE < slot1 + 1 then
			return slot0 + 1, 0
		end

		return slot0, slot1
	end,
	GetCanExchangeHero = function ()
		slot0 = {}
		slot3 = HeroData
		slot5 = slot3

		for slot4, slot5 in pairs(slot3.GetHeroList(slot5)) do
			slot6 = 0
			slot7 = HeroCfg[slot5.id]

			if slot5.unlock == 1 then
				for slot15 = table.keyof(HeroStarCfg.all, uv0.GetStarCfgId(HeroStarCfg[slot5.star].star, HeroStarCfg[slot5.star].phase)), #HeroStarCfg.all do
					slot6 = slot6 + HeroStarCfg[HeroStarCfg.all[slot15]].star_up
				end

				if slot6 < slot5.piece then
					table.insert(slot0, {
						id = ItemCfg[slot5.id].fragment,
						number = slot5.piece - slot6
					})
				end
			end
		end

		return slot0
	end,
	GetHeroIsUnlock = function (slot0)
		return HeroData:GetHeroList()[slot0] and slot1.unlock ~= 0 or false
	end,
	GetHeroRecoveryNum = function (slot0)
		return GameSetting.recovery_fragment.value[HeroCfg[slot0].rare]
	end,
	PlayTalk = function (slot0, slot1, slot2, slot3)
		slot4 = HeroCfg[slot0]

		HeroTools.StopTalk()
		manager.audio:PlayUIAudioByVoice(slot1)

		if (slot2 or 1) == 1 then
			if slot3 ~= nil then
				LuaForUtil.PlayVoiceWithCriLipsync(slot3, string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
			else
				manager.audio:PlayVoice(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
			end
		else
			manager.audio:PlayVoice(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
		end

		manager.notify:Invoke(HERO_SOUND_PLAY, slot0, slot1, slot2)
	end,
	PlayVoice = function (slot0, slot1, slot2)
		slot3 = HeroCfg[slot0]
		slot2 = slot2 or 1

		HeroTools.StopTalk()

		slot4 = nil

		manager.notify:Invoke(HERO_SOUND_PLAY, slot0, slot1, slot2)

		return (slot2 ~= 1 or manager.audio:PlayVoice(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))) and manager.audio:PlayVoice(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
	end,
	GetTalkLength = function (slot0, slot1, slot2)
		if (slot2 or 1) == 1 then
			return manager.audio:GetVoiceLength(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
		else
			return manager.audio:GetVoiceLength(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
		end
	end,
	StopTalk = function ()
		manager.audio:Stop("voice")
	end,
	GetVirtualHeroByCfg = function (slot0)
		slot1 = {
			id = slot2.hero_id,
			skin_id = slot2.skin_id,
			skin = slot2.skin_id,
			exp = GameLevelSetting[slot2.hero_lv].hero_lv_exp_sum,
			star = slot2.star_lv,
			level = slot2.hero_lv,
			break_level = slot2.hero_break,
			using_astrolabe = {},
			transition = {}
		}
		slot2 = HeroStandardSystemCfg[slot0]

		if slot2.astrolabe_suit_id and slot2.astrolabe_suit_id ~= 0 then
			slot6 = slot2.astrolabe_suit_id

			for slot6, slot7 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot6]) do
				table.insert(slot1.using_astrolabe, slot7)
			end
		end

		slot3 = slot2.skill_lv
		slot1.skill = {}
		slot7 = slot2.hero_id

		for slot7, slot8 in ipairs(HeroCfg[slot7].skills) do
			if slot8 == HeroCfg[slot2.hero_id].avoid[1] then
				table.insert(slot1.skill, {
					skill_level = 1,
					skill_id = slot8
				})
			else
				table.insert(slot1.skill, {
					skill_id = slot8,
					skill_level = slot3 + uv0.GetHeroSkillAddLevel(slot1, slot8)
				})
			end
		end

		slot1.weapon_info = {
			exp = GameLevelSetting[slot2.weapon_level].weapon_lv_exp_sum,
			breakthrough = slot2.weapon_break
		}
		slot1.servant = {
			id = slot2.weapon_key,
			stage = slot2.weapon_stage
		}

		return slot1
	end,
	GetConstructHero = function (slot0)
		slot0.skin_id = slot0.skin

		if slot0.skin > 0 then
			slot0.skin_id = slot0.skin
		else
			slot0.skin_id = slot0.id
		end

		return slot0
	end,
	AttributeAdd = function (slot0, slot1, slot2)
		slot1 = slot1 or 0
		slot2 = slot2 or 0

		if slot0 == HeroConst.SUB_MUL_ATTRIBUTE_ID then
			return HeroConst.ATTRIBUTE_PRECISION - (HeroConst.ATTRIBUTE_PRECISION - slot1) * (HeroConst.ATTRIBUTE_PRECISION - slot2) / HeroConst.ATTRIBUTE_PRECISION
		elseif slot0 == HeroConst.SUB_MUL_INJURY_ID or slot0 == HeroConst.SUB_MUL_SELF_INJURY_ID then
			return (HeroConst.ATTRIBUTE_PRECISION + slot1) * (HeroConst.ATTRIBUTE_PRECISION + slot2) / HeroConst.ATTRIBUTE_PRECISION
		else
			return slot1 + slot2
		end
	end,
	GetHeroAttribute = function (slot0)
		slot1 = {}
		slot2 = slot0.star

		for slot10, slot11 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[HeroCfg[slot0.id].star_up_skill_template]) do
			if HeroStarUpTemplateCfg[slot11].stage <= slot2 and HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == HeroStarSkillCfg[slot12.skill_id].type then
				for slot18, slot19 in pairs(slot14.params) do
					slot1[slot19[1]] = (slot1[slot19[1]] or 0) + slot19[2]
				end
			end
		end

		slot1[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (slot1[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + slot4.base_crit2[(slot0.break_level or 0) + 1]
		slot7 = HeroStarCfg[slot2].star

		for slot11, slot12 in pairs(PublicAttrCfg.all) do
			slot13 = 0

			if HeroConst.HERO_ATTRIBUTE_MAP[slot12] then
				if slot14.base then
					slot13 = slot13 + slot4[slot14.base][slot7]
				end

				if slot14.grow_fixed then
					slot13 = slot13 + (slot0.level - 1) * slot4[slot14.grow_fixed][slot7]
				end
			end

			if slot1[slot12] == nil then
				slot1[slot12] = 0
			end

			slot1[slot12] = slot1[slot12] + slot13
		end

		return slot1
	end,
	CaculateHeroAttribute = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		slot7 = {}
		slot8 = slot3 or slot0.star or slot0.hero_star
		slot9 = slot2 or slot0.hero_level or slot0.level or uv0.CheckExp(1, slot0.exp) or 1
		slot11 = HeroCfg[slot0.hero_id or slot0.id]

		for slot15, slot16 in pairs(slot1) do
			slot7[slot15] = (slot7[slot15] or 0) + slot16
		end

		for slot17, slot18 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot11.star_up_skill_template]) do
			if HeroStarUpTemplateCfg[slot18].stage <= slot8 and HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == HeroStarSkillCfg[slot19.skill_id].type then
				for slot25, slot26 in pairs(slot21.params) do
					slot7[slot26[1]] = (slot7[slot26[1]] or 0) + slot26[2]
				end
			end
		end

		slot7[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (slot7[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + slot11.base_crit2[(slot0.break_level or 0) + 1]

		if not slot5 then
			slot14 = {}
			slot15, slot16 = nil

			if slot6 then
				if slot6.isForeign then
					slot15 = ForeignInfoData:GetHeroWeaponInfo(slot10)
					slot16 = ForeignInfoData:GetHeroServantInfo(slot10)
				elseif slot6.isTemp then
					slot15 = TempHeroData:GetHeroWeaponInfo(slot6.tempHeroList, slot10)
					slot16 = TempHeroData:GetHeroServantInfo(slot6.tempHeroList, slot10)
				elseif slot6.isPolyhedron then
					slot15 = PolyhedronData:GetPolyhedronHeroData()[slot10].weapon_info
					slot16 = HeroTools.GetHeroServantInfo(slot10)
				end
			else
				slot15 = HeroData:GetHeroList()[slot10].weapon_info
				slot16 = HeroTools.GetHeroServantInfo(slot10)
			end

			if slot15 then
				slot18 = HeroCfg[slot10].weapon_break_attribute[slot15.breakthrough + 1]
				slot14[1] = WeaponTools.WeaponAtk(slot15.level, slot15.breakthrough)
				slot14[slot18[1]] = slot18[2]

				if slot16 then
					slot20 = WeaponServantCfg[slot16.id].attribute
					slot14[1] = slot14[1] + slot14[1] * WeaponServantCfg[slot16.id].attrib_addition / 100
					slot14[slot20[1]] = slot14[slot20[1]] + slot20[2]
				end

				for slot22, slot23 in pairs(slot14) do
					if not slot7[slot22] then
						slot7[slot22] = slot23
					end

					slot7[slot22] = slot7[slot22] + slot23
				end
			end
		end

		slot14 = HeroStarCfg[slot8].star

		for slot18, slot19 in pairs(PublicAttrCfg.all) do
			slot20 = 0

			if HeroConst.HERO_ATTRIBUTE_MAP[slot19] then
				if slot21.base then
					slot20 = slot20 + slot11[slot21.base][slot14]
				end

				if slot21.grow_fixed then
					slot20 = slot20 + (slot9 - 1) * slot11[slot21.grow_fixed][slot14]
				end
			end

			if slot7[slot19] == nil then
				slot7[slot19] = 0
			end

			slot7[slot19] = slot7[slot19] + slot20
		end

		return slot7
	end,
	CalFinalAttribute = function (slot0)
		for slot4, slot5 in pairs(HeroConst.HERO_ATTRIBUTE_MAP) do
			if slot5.ratio and slot0[slot4] then
				slot0[slot4] = slot0[slot4] * (1 + (slot0[slot5.ratio] / GameSetting.hp_ratio_percent.value[1] or 1))
			end
		end

		for slot4, slot5 in ipairs(slot0) do
			if PublicAttrCfg[slot4].percent and slot6.percent == 1 then
				slot0[slot4] = slot0[slot4]
			else
				slot0[slot4] = math.floor(slot0[slot4])
			end
		end
	end,
	Format = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			slot2[slot6] = {}

			for slot11, slot12 in ipairs(slot1) do
				slot2[slot6][slot12] = slot7[slot12]
			end
		end

		return slot2
	end,
	CheckBlankTable = function (slot0)
		slot1 = true
		slot2 = pairs
		slot4 = slot0 or {}

		for slot5, slot6 in slot2(slot4) do
			slot1 = false

			break
		end

		return slot1
	end,
	GetEquipMap = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			if type(slot6) == "table" then
				for slot10, slot11 in pairs(slot6.equip) do
					slot1[slot11.equip_id] = slot5
				end
			end
		end

		return slot1
	end,
	GetHeroEquipS = function (slot0)
		return deepClone(HeroData:GetHeroData(slot0).equip)
	end,
	CheckExp = function (slot0, slot1)
		slot3 = GameLevelSetting[slot0 + 1]

		if GameLevelSetting[slot0] == nil or slot3 == nil then
			return slot0
		end

		if slot2.hero_level_exp1 <= slot1 then
			return uv0.CheckExp(slot0 + 1, slot1 - slot4)
		else
			return slot0
		end
	end,
	GetUnlockSkill = function (slot0)
		slot7 = HeroConst.SKILL_TYPE.ATTACK

		table.insert({}, {
			lv = 1,
			id = slot0,
			type = slot7
		})

		for slot7 = 1, #HeroData:GetHeroList()[slot0].skill do
			table.insert(slot1, {
				id = slot2[slot7].skill_id,
				lv = slot2[slot7].lv or 0,
				type = HeroConst.SKILL_TYPE.SKILL
			})
		end

		return slot1
	end,
	GetExSkillId = function (slot0)
		return slot0 * 1000 + 209
	end,
	GetTotalSkillLv = function (slot0, slot1, slot2)
		return uv0.GetSkillLv(slot0, slot1, slot2) + uv0.GetHeroSkillAddLevel(HeroData:GetHeroData(slot0), slot1)
	end,
	GetSkillLv = function (slot0, slot1, slot2)
		slot3 = nil

		if slot2 then
			if slot2.isForeign then
				slot3 = ForeignInfoData:GetHeroInfo(slot0)
			elseif slot2.isTemp then
				slot3 = TempHeroData:GetHeroDataByHeroID(slot2.tempHeroList, slot0)
			elseif slot2.isPreview then
				return 1
			elseif slot2.isPolyhedron then
				slot3 = PolyhedronData:GetPolyhedronHeroData(slot0)
			end
		else
			slot3 = HeroData:GetHeroData(slot0)
		end

		for slot7, slot8 in ipairs(slot3.skill) do
			if slot8.skill_id == slot1 then
				return slot8.skill_level
			end
		end

		return 0
	end,
	GetHeroSkillInfo = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in ipairs(HeroData:GetHeroData(slot0).skill) do
			slot2[slot8.skill_id] = slot8.skill_level
		end

		slot4 = {}

		for slot8, slot9 in ipairs(HeroCfg[slot0].skills) do
			slot10 = uv0.GetHeroSkillAddLevel(slot3, slot9)

			if SkillTools.GetIsDodgeSkill(slot9) then
				slot10 = 0
			end

			table.insert(slot4, {
				id = slot9,
				heroId = slot0,
				lv = slot2[slot9],
				isCanUp = SkillTools.GetIsCanUp(slot9, slot2[slot9]),
				addSkillLv = slot10
			})
		end

		if slot1 == true then
			for slot8, slot9 in ipairs(slot4) do
				slot9.lv = 1
				slot9.isCanUp = false
				slot9.addSkillLv = 0
			end
		end

		return slot4
	end,
	GetHeroSkillAddLevel = function (slot0, slot1)
		if table.indexof(HeroCfg[slot0.id or slot0.hero_id].skills, slot1) then
			slot5 = slot0.star
			slot6 = {}

			for slot12, slot13 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot3.star_up_skill_template]) do
				if HeroStarUpTemplateCfg[slot13].stage <= slot5 and HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == HeroStarSkillCfg[slot14.skill_id].type then
					for slot20, slot21 in pairs(slot16.params) do
						slot6[slot21[1]] = (slot6[slot21[1]] or 0) + slot21[2]
					end
				end
			end

			return slot6[slot4] or 0
		end

		return 0
	end,
	GetTransitionAddLevel = function (slot0, slot1)
		if not table.indexof(HeroCfg[slot0.id or slot0.hero_id].skills, slot1) then
			return 0
		end

		slot5 = HeroTools.GetHeroEquipSkillAddLevel(slot0)
		slot6 = 0
		slot7 = 0
		slot8 = GameSetting.exclusive_skill_level_up_type.value
		slot10 = slot0.equip

		for slot14, slot15 in ipairs(slot0.transition) do
			if slot10[slot15.slot_id].equip_id ~= 0 and GameSetting.exclusive_open_need.value[1] <= EquipData:GetEquipData(slot17):GetLevel() then
				for slot23, slot24 in ipairs(slot15.skill_list) do
					slot25 = slot24.skill_id

					for slot29, slot30 in ipairs(slot8) do
						if slot25 == slot30[1] and slot30[2] == slot4 then
							slot7 = slot7 + slot24.skill_level
							slot6 = slot25
						end
					end
				end
			end
		end

		if slot6 ~= 0 then
			slot11 = EquipSkillCfg[slot6]

			return slot11.upgrade / slot11.percent * (slot7 + slot5)
		end

		return 0
	end,
	CountTransitionTotalSkill = function (slot0, slot1)
		slot2 = HeroTools.GetHeroEquipSkillAddLevel(slot0)
		slot3 = slot0.transition
		slot4 = {}
		slot5 = {}
		slot6 = ipairs
		slot8 = slot1 or {}

		for slot9, slot10 in slot6(slot8) do
			slot5[EquipCfg[slot10.prefab_id].pos] = slot10
		end

		for slot9, slot10 in ipairs(slot3) do
			if slot5[slot10.slot_id] and GameSetting.exclusive_open_need.value[1] <= slot12.GetLevel(slot12) then
				for slot17, slot18 in ipairs(slot10.skill_list) do
					if not slot4[slot18.skill_id] then
						slot4[slot19] = 0
					end

					slot4[slot19] = slot4[slot19] + slot18.skill_level
				end
			end
		end

		slot6 = 0

		for slot10, slot11 in pairs(slot4) do
			slot6 = slot6 + slot11 + slot2
		end

		return slot6
	end,
	CalTransitionSkillAttribute = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}
		slot5 = slot0.transition
		slot6 = HeroTools.GetHeroEquipSkillAddLevel(slot0)
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = {}

		for slot12, slot13 in ipairs(slot1) do
			slot8[EquipCfg[slot13.prefab_id].pos] = slot13
		end

		slot9 = {}
		slot10 = {}
		slot11 = {}

		for slot15, slot16 in pairs(slot5) do
			if slot8[slot15] and GameSetting.exclusive_open_need.value[1] <= EquipTools.CountEquipLevel(slot17) then
				for slot22, slot23 in ipairs(slot16) do
					if EquipSkillCfg[slot23.skill_id].equip_effect_id == 0 then
						slot26 = false

						for slot30, slot31 in ipairs(slot7) do
							if slot24 == slot31[1] then
								slot26 = slot31[2]

								break
							end
						end

						if slot26 then
							slot11[slot24] = (slot11[slot24] or 0) + slot23.skill_level
						else
							slot9[slot24] = (slot9[slot24] or 0) + slot23.skill_level
						end
					else
						slot10[slot24] = (slot10[slot24] or 0) + slot23.skill_level
					end
				end
			end
		end

		for slot15, slot16 in pairs(slot9) do
			slot17 = EquipSkillCfg[slot15]
			slot2[slot18] = (slot2[slot17.attribute] or 0) + slot17.upgrade * (slot16 + slot6)
		end

		for slot15, slot16 in pairs(slot10) do
			slot17 = EquipSkillCfg[slot15]
			slot3[slot15] = (slot3[info] or 0) + slot16 + slot6
		end

		slot12 = HeroCfg[slot0.id].skills

		for slot16, slot17 in pairs(slot11) do
			slot18 = EquipSkillCfg[slot16]
			slot19 = slot17 + slot6

			for slot23, slot24 in ipairs(slot7) do
				if slot16 == slot24[1] then
					slot4[slot12[slot24[2]]] = slot18.upgrade * slot19

					break
				end
			end
		end

		return slot2, slot3, slot4
	end,
	GetHeroEquipSkillAddLevel = function (slot0)
		slot1 = slot0.id or slot0.hero_id
		slot3 = slot0.star

		for slot9, slot10 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[HeroCfg[slot1].star_up_skill_template]) do
			if HeroStarUpTemplateCfg[slot10].stage <= slot3 and HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_UP == HeroStarSkillCfg[slot11.skill_id].type then
				return 1
			end
		end

		return 0
	end,
	GetHeroWeaponAddLevel = function (slot0)
		slot3 = slot0.star

		for slot9, slot10 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[HeroCfg[slot0.id].star_up_skill_template]) do
			if HeroStarUpTemplateCfg[slot10].stage <= slot3 and HeroConst.HERO_STAR_SKILL_TYPE.WEAPON_UP == HeroStarSkillCfg[slot11.skill_id].type then
				return 2
			end
		end

		return 0
	end,
	GetIsSuitNumCut = function (slot0)
		if not slot0 then
			return false
		end

		slot2 = HeroCfg[slot0.id or slot0.hero_id]

		if (slot0.star or slot0.hero_star) and HeroStarCfg[slot3] then
			for slot9, slot10 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot2.star_up_skill_template]) do
				if HeroStarUpTemplateCfg[slot10].stage <= slot3 and HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_SUIT == HeroStarSkillCfg[slot11.skill_id].type then
					return true
				end
			end
		end

		return false
	end,
	CountHeroTotalSkilllv = function (slot0)
		slot2 = 0

		for slot6, slot7 in ipairs(HeroData:GetHeroList()[slot0].skill) do
			slot2 = slot2 + slot7.skill_level + uv0.GetHeroSkillAddLevel(slot1, slot7.skill_id)
		end

		return slot2
	end,
	GetEquipSuitEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if slot6.equip_id ~= 0 then
				slot1[slot9] = (slot1[EquipCfg[EquipData:GetEquipList()[slot6.equip_id].prefab_id].type] or 0) + 1
			end
		end

		slot2 = {}
		slot3 = 0

		for slot7, slot8 in pairs(slot1) do
			for slot13, slot14 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot7]) do
				if EquipSuitCfg[slot14].need <= slot8 then
					if slot2[slot15.suit] == nil then
						slot2[slot15.suit] = {}
						slot3 = slot3 + 1
					end

					table.insert(slot2[slot15.suit], slot15)
				end
			end
		end

		return slot2, slot3
	end,
	GetIsCanSkillUp = function (slot0)
		slot1 = HeroCfg[slot0.id]

		if slot0.unlock == 0 then
			return false
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0.skill) do
			slot2[slot7.skill_id] = slot7.skill_level
		end

		for slot6, slot7 in ipairs(slot1.skills) do
			if SkillTools.GetIsCanUp(slot7, slot2[slot7]) then
				return true
			end
		end

		return false
	end,
	GetIsCanUpStar = function (slot0)
		slot1 = HeroCfg[slot0.id]

		if slot0.unlock == 0 then
			if GameSetting.unlock_hero_need.value[slot1.rare] <= slot0.piece then
				return true
			end
		else
			if HeroConst.MAX_STAR_UP_ID <= slot0.star then
				return false
			end

			slot3 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)
			slot5 = HeroStarCfg[slot2].gold_cost

			if HeroStarCfg[slot2].star_up <= slot0.piece and slot5 <= slot3 then
				return true
			end
		end

		return false
	end,
	SortByChat = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if type(slot9) == "table" and slot9.unlock == 1 then
				slot4[slot8] = slot9.chat_unread

				table.insert(slot3, slot8)
			end
		end

		table.sort(slot3)
		table.sort(slot3, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		if uv0.lastList and uv0.lastList[slot2 - slot1] and slot6 ~= slot3[slot5] and table.indexof(slot3, slot6) then
			table.remove(slot3, slot7)
			table.insert(slot3, slot5, slot6)
		end

		uv0.lastList = slot3

		return slot3
	end,
	SortByChat2 = function (slot0)
		if uv0.chatList then
			return uv0.chatList
		end

		slot1 = {}
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" and slot7.unlock == 1 then
				slot2[slot6] = slot7.chat_unread

				table.insert(slot1, slot6)
			end
		end

		table.sort(slot1)
		table.sort(slot1, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		uv0.chatList = slot1

		return slot1
	end,
	HeroUsingSkinInfo = function (slot0)
		slot1 = slot0

		if (HeroData:GetHeroData(slot0) and slot2.using_skin or 0) == 0 then
			slot3 = slot1
		end

		return SkinCfg[slot3]
	end,
	SetHeroModelWeaponActivity = function (slot0, slot1)
		LuaForUtil.ShowWeapon(slot0, slot1)
	end,
	HeroUnlockSkinS = function (slot0)
		slot2 = {}

		table.insertto(slot2, HeroData:GetHeroData(slot0).unlocked_skin)
		table.insert(slot2, slot0)

		return slot2
	end,
	CanChangeSkin = function (slot0)
		slot1 = false

		for slot7, slot8 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot0].hero)) do
			if slot8 == slot0 then
				slot1 = true

				break
			end
		end

		if slot1 then
			return false
		end

		if not uv0.GetSkinChangeItem(slot0) then
			return false
		end

		if MaterialData:GetMaterial(slot4).num > 0 then
			return true
		end
	end,
	GetSkinIsCanUnLock = function (slot0)
		if SkinCfg[slot0].unlock_id_list[1] then
			return true
		end

		return false
	end,
	GetSkinChangeItem = function (slot0)
		return SkinCfg[slot0].change_item
	end,
	GetHeadSprite = function (slot0)
		return getSpriteViaConfig("HeroLittleIcon", slot0)
	end,
	GetSmallHeadSprite = function (slot0)
		return getSpriteViaConfig("HeroItemshead", slot0)
	end,
	GetBackHomeHeadSprite = function (slot0)
		return getSpriteViaConfig("DormHeroHeadIcon", slot0)
	end,
	GetBackHomeFullModelSprite = function (slot0)
		return getSpriteViaConfig("DormHeroModelIcon", slot0)
	end,
	GetBackHomeFullModelFowardSprite = function (slot0)
		return getSpriteViaConfig("DormHeroPortrait", slot0)
	end,
	GetHeroAttackRangeIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot6[1] == CharactorParamCfg[slot0].RangeType then
				slot1 = slot6[3]

				break
			end
		end

		return getSprite("Atlas/Hero/HeroAttribute", slot1)
	end,
	GetHeroRaceIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if slot6[1] == HeroCfg[slot0].race then
				slot1 = slot6[3]
			end
		end

		return getSprite("Atlas/CampItem", slot1)
	end,
	GetHeroSkillAttributeIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot6[1] == HeroCfg[slot0].ATK_attribute[1] then
				slot1 = slot6[3]

				break
			end
		end

		return getSprite("Atlas/Hero/HeroAttribute", slot1)
	end,
	GetHeroSkillMechanismIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot6[1] == HeroCfg[slot0].mechanism_type[1] then
				slot1 = slot6[3]

				break
			end
		end

		return getSprite("Atlas/Hero/HeroAttribute", slot1)
	end,
	GetHeroCurrentMaxLevel = function (slot0)
		return HeroTools.GetHeroBreakConfig(HeroCfg[slot0.id].race, slot0.break_level or 0).max_level
	end,
	GetHeroBreakConfig = function (slot0, slot1)
		for slot5, slot6 in ipairs(HeroBreakCfg.all) do
			if HeroBreakCfg[slot6].race == slot0 and HeroBreakCfg[slot6].break_times == slot1 then
				return HeroBreakCfg[slot6]
			end
		end

		error(string.format("在hero_break.csv中找不到race=%d,breakLevel=%d的项", slot0, slot1))

		return nil
	end,
	GetHeroServantInfo = function (slot0)
		slot1 = WeaponServantData.GetWeaponServantList()

		if HeroData:GetHeroList()[slot0].servant_uid == 0 then
			return nil
		end

		return slot1[slot2]
	end,
	GetHeroSpecServant = function (slot0)
		return HeroCfg[slot0].spec_servant
	end,
	GetHeroProficiency = function (slot0)
		return math.min(HeroData:GetHeroData(slot0).clear_times * GameSetting.mastery_gain.value[1], GameSetting.mastery_level_max.value[1])
	end,
	CanBreakHero = function (slot0)
		slot1 = HeroCfg[slot0]

		if not HeroData:GetHeroData(slot0).unlock or slot2.level >= HeroConst.HERO_LV_MAX or HeroTools.GetHeroCurrentMaxLevel(slot2) > slot2.level then
			return false
		end

		if PlayerData:GetPlayerInfo().userLevel < HeroTools.GetHeroBreakConfig(slot1.race, slot2.break_level or 0).user_level then
			return false
		end

		for slot8 = 1, #slot3.cost do
			slot9 = 0

			if MaterialData:GetMaterialList()[slot3.cost[slot8][1]] then
				slot9 = MaterialData:GetMaterialList()[slot10[1]].num
			end

			if not (slot10[2] <= slot9) then
				return false
			end
		end

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot3.cost_gold then
			return false
		end

		return true
	end,
	GetHeroOntologyID = function (slot0)
		for slot4, slot5 in ipairs(HeroRecordCfg.all) do
			slot6 = HeroRecordCfg[slot5]

			if slot0 == slot5 then
				return slot5, true
			end

			for slot10, slot11 in ipairs(slot6.hero_id) do
				if slot0 == slot11 then
					return slot5, false
				end
			end
		end
	end,
	GetHeroTeachVideo = function (slot0)
		slot1 = HeroCfg[slot0]

		if HeroData:GetHeroData(slot0).unlock == 0 then
			return nil
		end

		if slot1.study_stage[1] and TeachStageExInfoCfg[slot3] and slot4.video_url then
			return slot4.video_url
		end
	end,
	IsSkinUnlock = function (slot0)
		for slot6, slot7 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot0].hero)) do
			if slot7 == slot0 then
				return true
			end
		end

		return false
	end,
	GetHeroAllAttribute = function (slot0, slot1)
		slot2, slot3, slot4 = nil

		if slot1 then
			if slot1.isForeign then
				slot2 = ForeignInfoData:GetHeroInfo(slot0)
				slot3 = ForeignInfoData:GetEquipList(slot0)
			elseif slot1.isTemp then
				slot3 = TempHeroData:GetHeroDataByHeroID(slot1.tempHeroList, slot0).equip_list
				slot4 = TempHeroData:GetHeroDataByHeroID(slot1.tempHeroList, slot0).tempID
			elseif slot1.isPolyhedron then
				slot4 = PolyhedronHeroCfg[slot0].standard_id

				return GetPolyhedronHeroPracticalAttr(PolyhedronData:GetPolyhedronInfo(), HeroTools.GetVirtualHeroByCfg(slot4), EquipTools.GetConstructVirtualEquips(slot4), slot4)
			else
				print("暂未设置类型")
			end
		else
			slot8 = slot0
			slot3 = {}

			for slot8, slot9 in pairs(HeroData:GetHeroData(slot8).equip) do
				if slot9.equip_id ~= 0 then
					table.insert(slot3, EquipData:GetEquipData(slot9.equip_id))
				end
			end

			if slot2.servant_uid ~= 0 then
				slot5 = WeaponServantData.GetWeaponServantList()[slot2.servant_uid]
				slot2.servant = {
					id = slot5.id,
					stage = slot5.stage
				}
			else
				slot2.servant = nil
			end
		end

		slot5 = GetHeroFinalAttr(slot2, slot3, slot4, false, slot1)
		slot5[HeroConst.HERO_ATTRIBUTE.ATK] = slot5[HeroConst.HERO_ATTRIBUTE.ATK] * (1 + slot5[11] / 1000 + slot5[13] / 1000) + slot5[12]
		slot5[HeroConst.HERO_ATTRIBUTE.ARM] = slot5[HeroConst.HERO_ATTRIBUTE.ARM] * (1 + slot5[21] / 1000) + slot5[22]
		slot5[HeroConst.HERO_ATTRIBUTE.STA] = slot5[HeroConst.HERO_ATTRIBUTE.STA] * (1 + slot5[31] / 1000) + slot5[32]

		return slot5
	end,
	GetShopIdBySkinId = function (slot0)
		if not uv0.GetSkinChangeItem(slot0) then
			return 0
		end

		if not ShopCfg.get_id_list_by_give_id[slot1] then
			return 0
		end

		return ShopCfg.get_id_list_by_give_id[slot1][1]
	end,
	IsSkinOutOfDate = function (slot0)
		if uv0.GetShopIdBySkinId(slot0) > 0 then
			return ShopData.IsGoodOutOfDate(slot1)
		else
			return true
		end
	end,
	CanBeDraw = function (slot0, slot1)
		slot2 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

		for slot6, slot7 in ipairs(slot2) do
			if ActivityData:GetActivityIsOpen(slot7) and ActivityDrawPoolCfg[slot7] then
				for slot12, slot13 in ipairs(slot8.config_list) do
					if slot1 == slot13 then
						return true
					end
				end
			end
		end

		return false
	end,
	GetIsHide = function (slot0)
		return HideInfoData:GetHeroHideList()[slot0] or false
	end,
	GetIsSkinHide = function (slot0)
		return HideInfoData:GetSkinHideList()[slot0] or false
	end,
	GetSkinIsCanUnlockAndGet = function (slot0)
		if SkinCfg[slot0].unlock_id_list[1] then
			for slot4, slot5 in pairs(SkinCfg[slot0].unlock_id_list) do
				slot6, slot7, slot8 = IsConditionAchieved(slot5, {
					heroId = SkinCfg[slot0].hero
				})

				if not slot6 then
					return false
				end
			end

			return true
		else
			return false
		end
	end,
	IsSamePerson = function (slot0, slot1)
		slot3 = uv0(slot1)

		return uv0(slot0) ~= nil and slot3 ~= nil and slot2 == slot3
	end,
	GetUnlockInteractionCfg = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in pairs(HeroInteractionCfg[slot1]) do
			if string.find(slot7, "_talk") then
				slot11 = string.split(slot7, "_")[1]
				slot3[slot11] = {}
				slot3[slot11 .. "_talk"] = {}
				slot3[slot11 .. "_delay"] = {}

				for slot15, slot16 in ipairs(slot2[slot7]) do
					if slot0.IsUnlockVoice(slot0, slot1, HeroVoiceCfg.get_id_list_by_file[string.split(slot16, "_")[2]][1]) then
						table.insert(slot3[slot11], slot2[slot11][slot15])
						table.insert(slot3[slot11 .. "_talk"], slot2[slot11 .. "_talk"][slot15])

						if slot2[slot11 .. "_delay"] then
							table.insert(slot3[slot11 .. "_delay"], slot2[slot11 .. "_delay"][slot15])
						end
					end
				end
			end
		end

		return slot3
	end,
	IsUnlockVoice = function (slot0, slot1, slot2)
		if DormTools:IsVoiceNeedUnlock(slot2) then
			if DormTools:IsHeroInDormConfig(slot1) then
				if DormData:GetDormLevelByHeroID(slot1) < DormTools:GetVoiceUnlockLevel(slot1, slot2) then
					return false
				end
			else
				return false
			end
		end

		if HeroVoiceCfg[slot2].unlock_condition == 0 then
			return true
		else
			return IsConditionAchieved(slot3, {
				heroId = slot1
			})
		end
	end,
	GetModuleAttribute = function (slot0)
		slot2 = {
			0,
			0,
			0,
			0
		}

		for slot7, slot8 in pairs(HeroTools.GetModuleEffectByHeroAndLevel(slot0.id, slot0.weapon_module_level)) do
			if WeaponModuleEffectCfg[slot8].type == 1 then
				for slot13, slot14 in pairs(slot9.attributes) do
					slot2[slot14[1]] = slot2[slot14[1]] + slot14[2]
				end
			end
		end

		return slot2
	end,
	GetModuleAllDes = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = nil

		if HeroData:GetHeroList()[slot1].servant_uid ~= HeroTools.GetHeroSpecServant(slot1) then
			slot6 = 0
		end

		for slot10, slot11 in pairs(slot0) do
			if WeaponModuleEffectCfg[slot11].type == 1 then
				if slot2 == nil then
					slot2 = {
						slot11
					}
				else
					table.insert(slot2, slot11)
				end
			end

			if slot12 == 2 then
				slot3 = (slot3 ~= nil or SkillTools.GetSkillModuleDes(slot11)) and SkillTools.GetSkillModuleDes(slot11) .. "\n" .. SkillTools.GetSkillModuleDes(slot11)
			end

			if slot12 == 3 then
				slot4 = (slot4 ~= nil or AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6)) and AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6) .. "\n\n" .. AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6)
			end

			if slot12 == 4 then
				slot5 = (slot5 ~= nil or WeaponTools.GetWeaponModuleDes(slot11)) and WeaponTools.GetWeaponModuleDes(slot11) .. "\n\n" .. WeaponTools.GetWeaponModuleDes(slot11)
			end

			if slot12 == 5 then
				slot3 = (slot3 ~= nil or SkillTools.GetServantSkillModuleDes(slot11)) and slot3 .. "\n" .. SkillTools.GetServantSkillModuleDes(slot11)
			end
		end

		return slot2, slot3, slot4, slot5
	end,
	MergeModuleAttribute = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			for slot11, slot12 in pairs(WeaponModuleEffectCfg[slot6].attributes) do
				if slot1[slot12[1]] then
					slot1[slot12[1]] = slot1[slot12[1]] + slot12[2]
				else
					slot1[slot12[1]] = slot12[2]
				end
			end
		end

		return slot1
	end,
	CheckModulePieceCanEnter = function ()
		for slot4, slot5 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
			if MaterialData:GetMaterial(slot5).num > 0 then
				return true
			end
		end

		return false
	end,
	GetModuleEffectByHeroAndLevel = function (slot0, slot1)
		slot2 = {}

		if slot0 and slot1 and WeaponModuleCfg[slot0] then
			for slot7 = 1, slot1 do
				for slot11, slot12 in pairs(slot3.skill[slot7]) do
					table.insert(slot2, slot12)
				end
			end
		end

		return slot2
	end
}
