for slot3, slot4 in ipairs(ChapterClientCfg.all) do
	if ChapterClientCfg[slot4].not_chapter_id == false then
		for slot8, slot9 in ipairs(ChapterClientCfg[slot4].chapter_list) do
			ChapterCfg[slot9].clientID = slot4
			ChapterClientCfg[slot4].difficulty = ChapterCfg[slot9].difficulty
		end
	else
		for slot8, slot9 in ipairs(ChapterClientCfg[slot4].chapter_list) do
			ChapterClientCfg[slot9].parentToggle = ChapterClientCfg[slot4].toggle

			for slot13, slot14 in ipairs(ChapterClientCfg[slot9].chapter_list) do
				ChapterCfg[slot14].toggle = ChapterClientCfg[slot9].toggle
			end
		end
	end
end

slot0 = {}

for slot4, slot5 in pairs(ChapterCfg.all) do
	for slot10, slot11 in ipairs(ChapterCfg[slot5].section_id_list) do
		if not slot0[slot11] then
			slot0[slot11] = slot5
		end
	end
end

slot1 = {}
slot5 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

for slot5, slot6 in ipairs(ChapterCfg.get_id_list_by_type[slot5]) do
	slot7 = ChapterCfg[slot6]
	slot1[slot7.sub_type] = slot1[slot7.sub_type] or {}
	slot1[slot7.sub_type][slot7.difficulty] = slot1[slot7.sub_type][slot7.difficulty] or {}

	table.insert(slot1[slot7.sub_type][slot7.difficulty], slot6)
end

function getChapterNumList(slot0)
	return uv0[slot0]
end

function getChapterList()
	return uv0
end

slot2 = {}
slot6 = BattleConst.TOGGLE.PLOT

for slot6, slot7 in ipairs(ChapterClientCfg.get_id_list_by_toggle[slot6]) do
	slot2[slot9] = slot2[ChapterCfg[ChapterClientCfg[slot7].chapter_list[1]].difficulty] or {}

	if #ChapterCfg[slot8].section_id_list > 0 then
		table.insert(slot2[slot9], slot7)
	end
end

function getChapterClientList()
	return uv0
end

function slot3(slot0)
	for slot4, slot5 in ipairs(slot0.all) do
		for slot9, slot10 in ipairs(slot0[slot5].next_show_id_list) do
			slot0[slot10].pre_show_id_list = slot0[slot10].pre_show_id_list or {}

			table.insert(slot0[slot10].pre_show_id_list, slot5)
		end

		for slot9, slot10 in ipairs(slot0[slot5].next_unlock_id_list) do
			slot0[slot10].pre_unlock_id_list = slot0[slot10].pre_unlock_id_list or {}

			table.insert(slot0[slot10].pre_unlock_id_list, slot5)
		end
	end
end

for slot8, slot9 in pairs({
	BattleChapterStageCfg,
	BattleDailyStageCfg,
	BattleActivityStoryStageCfg
}) do
	slot3(slot9)
end

slot7 = {}

for slot11, slot12 in ipairs(string.split(GameSetting.guide_map.value2, ",")) do
	if string.split(slot12, "=")[1] and slot13[2] then
		slot7[tonumber(slot13[1])] = tonumber(slot13[2])
	end
end

GameSetting.guide_map.value2 = slot7
slot8 = {}

for slot12, slot13 in pairs(WarchessHexCfg) do
	if slot13.id then
		slot14 = GridConfig.New()
		slot14.id = slot13.id
		slot14.walkable = slot13.move
		slot14.interact = slot13.interact
		slot14.explode = slot13.explode
		slot14.stonecanmove = slot13.stonecanmove
		slot14.stonecaninteract = slot13.stonecaninteract

		table.insert(slot8, slot14)
	end
end

WarchessHexCfg.AllGridConfig = slot8
slot9 = {}

for slot13, slot14 in pairs(BackHomeCfg) do
	if slot14.id then
		slot15 = DormMapCfg.New()
		slot15.id = slot14.id
		slot15.name = slot14.scene
		slot15.previewParams = DormCameraParams.New()
		slot15.editParams = DormCameraParams.New()
		slot16 = DormCameraCfg[slot14.camera_preview]
		slot15.previewParams.value = Vector2.New(slot16.value[1], slot16.value[2])
		slot15.previewParams.topRig = Vector2.New(slot16.toprig[1], slot16.toprig[2])
		slot15.previewParams.middleRig = Vector2.New(slot16.middlerig[1], slot16.middlerig[2])
		slot15.previewParams.bottomRig = Vector2.New(slot16.bottomrig[1], slot16.bottomrig[2])
		slot15.previewParams.topRigInterval = Vector2.New(slot16.toprig_interval[1], slot16.toprig_interval[2])
		slot17 = DormCameraCfg[slot14.camera_edit]
		slot15.editParams.value = Vector2.New(slot17.value[1], slot17.value[2])
		slot15.editParams.topRig = Vector2.New(slot17.toprig[1], slot17.toprig[2])
		slot15.editParams.middleRig = Vector2.New(slot17.middlerig[1], slot17.middlerig[2])
		slot15.editParams.bottomRig = Vector2.New(slot17.bottomrig[1], slot17.bottomrig[2])
		slot15.editParams.topRigInterval = Vector2.New(slot17.toprig_interval[1], slot17.toprig_interval[2])

		table.insert(slot9, slot15)
	end
end

BackHomeCfg.AllMapCfg = slot9
slot10 = {}

for slot14, slot15 in pairs(BackHomeFurniture) do
	if slot15.id and slot15.type ~= DormConst.FLOOR_TYPE_NUM and slot15.type ~= DormConst.WALL_TYPE_NUM then
		slot16 = FurnitureConfig.New()
		slot16.id = slot15.id
		slot16.prefab = slot15.model
		slot16.type = {
			slot15.display_type
		}
		slot16.width = slot15.title[1]
		slot16.height = slot15.title[2]
		slot16.depth = slot15.title[3] or 0

		table.insert(slot10, slot16)
	end
end

BackHomeFurniture.AllFurnitureConfig = slot10
slot11 = {}

for slot15, slot16 in pairs(HeroSkillCfg.all) do
	if type(HeroSkillCfg[slot16].strengthen_desc) == "table" and slot17.strengthen_desc[1] then
		slot11[slot17.strengthen_desc[1]] = slot16
	end
end

for slot15, slot16 in pairs(WeaponEffectCfg.all) do
	slot17 = WeaponEffectCfg[slot16]

	if slot16 > 0 and type(slot17.strengthen_description) == "table" and slot17.strengthen_description[1] then
		slot11[slot17.strengthen_description[1]] = WeaponServantCfg.get_id_list_by_effect[slot16][1]
	end
end

function getSkillIDOrServantID(slot0)
	return uv0[slot0]
end

slot12 = {}

for slot16, slot17 in pairs(AstrolabeEffectCfg.all) do
	if type(AstrolabeEffectCfg[slot17].equip_orange_desc) == "table" then
		for slot22, slot23 in pairs(slot18.equip_orange_desc) do
			if slot12[slot23[3]] == nil then
				slot12[slot23[3]] = {}
			end

			slot12[slot23[3]][slot23[1]] = slot18.id
		end
	end
end

function getAstrolabeID(slot0, slot1)
	if uv0[slot0] == nil then
		print("配置错误！检查AstrolabeEffectCfg和WeaponModuleEffectCfg")

		return
	end

	return uv0[slot0][slot1]
end

HERO_FRAGMENT_VALUE = 10000
slot16 = ItemConst.ITEM_TYPE.HERO

for slot16, slot17 in pairs(ItemCfg.get_id_list_by_type[slot16]) do
	ItemCfg[slot17].fragment = slot17 + HERO_FRAGMENT_VALUE
end

slot16 = ItemConst.ITEM_TYPE.HERO_PIECE

for slot16, slot17 in pairs(ItemCfg.get_id_list_by_type[slot16]) do
	ItemCfg[slot17].hero_id = slot17 - HERO_FRAGMENT_VALUE
end

for slot16, slot17 in pairs(ActivityPtCfg.all) do
	ItemCfg[ActivityPtCfg[slot17].item_id].activity_id = slot17
end

ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId = {}

for slot16, slot17 in ipairs(ActivityPtRepeatCfg.all) do
	if not ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[ActivityPtRepeatCfg[slot17].activity_id] then
		ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[slot18.activity_id] = {}
	end

	ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[slot18.activity_id][slot18.stage_id] = slot18
end

ActivityPt2Cfg.GetCfgFromActivityIdAndStageId = {}

for slot16, slot17 in ipairs(ActivityPt2Cfg.all) do
	if not ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[ActivityPt2Cfg[slot17].activity_id] then
		ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[slot18.activity_id] = {}
	end

	ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[slot18.activity_id][slot18.stage_id] = slot18
end

ShopListCfg.get_id_list_by_system_and_group = {}

for slot16, slot17 in pairs(ShopListCfg.get_id_list_by_system) do
	slot18 = {}

	for slot22, slot23 in ipairs(slot17) do
		if not slot18[ShopListCfg[slot23].display_group] then
			slot18[slot24.display_group] = {}
		end

		table.insert(slot18[slot24.display_group], slot24)
	end

	ShopListCfg.get_id_list_by_system_and_group[slot16] = slot18
end

function UpdateShopCfg(slot0)
	slot1 = slot0.shop_id

	for slot6, slot7 in ipairs(slot0.goods_list) do
		ShopCfg[slot7.goods_id] = {
			taken_down = 0,
			position = 0,
			goods_id = slot7.goods_id,
			shop_id = slot1,
			shop_sort = slot7.shop_sort,
			give_id = slot7.give_id,
			give = slot7.give,
			cost_type = slot7.cost_type,
			cost_id = slot7.cost_id,
			cost = slot7.cost,
			cheap_cost_id = slot7.cheap_cost_id,
			cheap_cost = slot7.cheap_cost,
			discount = slot7.discount,
			limit_num = slot7.limit_num,
			level_limit = cleanProtoTable(slot7.level_limit),
			limit_display = slot7.limit_display,
			pre_goods_id = cleanProtoTable(slot7.pre_goods_id),
			refresh_cycle = slot7.refresh_cycle,
			open_time = {},
			close_time = {},
			is_limit_time_discount = slot7.is_limit_time_discount,
			cheap_open_time = {},
			cheap_close_time = {},
			tag = slot7.tag,
			backhome_tag = slot7.backhome_tag,
			next_goods_id = cleanProtoTable(slot7.next_goods_id)
		}

		if slot7.open_time and slot7.open_time.year ~= 0 then
			slot8 = slot7.open_time
			ShopCfg[slot7.goods_id].open_time = {
				{
					slot8.year,
					slot8.month,
					slot8.day
				},
				{
					slot8.hour,
					slot8.minute,
					slot8.second
				}
			}
		end

		if slot7.close_time and slot7.close_time.year ~= 0 then
			slot8 = slot7.close_time
			ShopCfg[slot7.goods_id].close_time = {
				{
					slot8.year,
					slot8.month,
					slot8.day
				},
				{
					slot8.hour,
					slot8.minute,
					slot8.second
				}
			}
		end

		if slot7.cheap_open_time and slot7.cheap_open_time.year ~= 0 then
			slot8 = slot7.cheap_open_time
			ShopCfg[slot7.goods_id].cheap_open_time = {
				{
					slot8.year,
					slot8.month,
					slot8.day
				},
				{
					slot8.hour,
					slot8.minute,
					slot8.second
				}
			}
		end

		if slot7.cheap_close_time and slot7.cheap_close_time.year ~= 0 then
			slot8 = slot7.cheap_close_time
			ShopCfg[slot7.goods_id].cheap_close_time = {
				{
					slot8.year,
					slot8.month,
					slot8.day
				},
				{
					slot8.hour,
					slot8.minute,
					slot8.second
				}
			}
		end

		ShopCfg.get_id_list_by_shop_id[slot1] = ShopCfg.get_id_list_by_shop_id[slot1] or {}

		if not table.indexof(ShopCfg.get_id_list_by_shop_id[slot1]) then
			table.insert(ShopCfg.get_id_list_by_shop_id[slot1], slot7.goods_id)
		end

		ShopCfg.get_id_list_by_cost_id[slot7.cost_id] = ShopCfg.get_id_list_by_cost_id[slot7.cost_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_cost_id[slot7.cost_id]) then
			table.insert(ShopCfg.get_id_list_by_cost_id[slot7.cost_id], slot7.goods_id)
		end

		ShopCfg.get_id_list_by_give_id[slot7.give_id] = ShopCfg.get_id_list_by_give_id[slot7.give_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_give_id[slot7.give_id]) then
			table.insert(ShopCfg.get_id_list_by_give_id[slot7.give_id], slot7.goods_id)
		end
	end
end

slot16 = ItemConst.ITEM_TYPE.SKIN_CHANGE

for slot16, slot17 in ipairs(ItemCfg.get_id_list_by_type[slot16]) do
	SkinCfg[ItemCfg[slot17].param[1]].change_item = slot17
end

function getChapterIDByStageID(slot0)
	return uv0[slot0]
end

function getChapterClientCfgByChapterID(slot0)
	return ChapterClientCfg[ChapterCfg[slot0].clientID]
end

function getChapterClientCfgByStageID(slot0)
	return getChapterClientCfgByChapterID(getChapterIDByStageID(slot0))
end

function getChapterAndSectionID(slot0)
	return slot1, ChapterCfg[getChapterIDByStageID(slot0)].section_id_list ~= "" and table.keyof(slot2.section_id_list, slot0) or 1
end

function getChapterToggle(slot0)
	return ChapterClientCfg[slot0].parentToggle or ChapterClientCfg[slot0].toggle
end

function getChapterDifficulty(slot0)
	if not ChapterCfg[BattleStageTools.GetChapterByStageId(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)] then
		error("错误的难度参数")
	end

	if slot2.difficulty == 1 then
		return GetTips("HARDLEVEL_EASY")
	elseif slot3 == 2 then
		return GetTips("HARDLEVEL_HARD")
	end
end

function getStageViaStoryID(slot0)
	return StoryCfg[slot0].trigger[2]
end

slot13 = {}

function getChapterListByDifficulty(slot0, slot1)
	slot1 = slot1 or "all"

	if not uv0[slot0] then
		slot2 = {}

		for slot7, slot8 in ipairs(ChapterCfg.get_id_list_by_type[slot0]) do
			slot2[slot10] = slot2[ChapterCfg[slot8].difficulty] or {}
			slot2.all = slot2.all or {}

			table.insert(slot2.all, slot8)
			table.insert(slot2[slot10], slot8)
		end

		uv0[slot0] = slot2
	end

	return uv0[slot0][slot1] or {}
end

slot14 = {}

for slot18, slot19 in pairs(StoryCfg) do
	if slot19.trigger[2] then
		if not slot14[slot20] then
			slot14[slot20] = {}
		end

		slot14[slot20][slot19.trigger[3]] = slot19.id
	end
end

function getStoryViaStageID(slot0, slot1)
	if not uv0[slot0] then
		return false
	end

	return uv0[slot0][slot1]
end

for slot18, slot19 in ipairs(WeaponServantCfg.all) do
	if ServantTools.GetServantSpecHero(slot19) then
		HeroCfg[slot20].spec_servant = slot19
	end
end

slot15 = {}

for slot19, slot20 in pairs(ItemCfg.get_id_list_by_type[14]) do
	slot15[ItemCfg[slot20].param[1]] = slot20
end

function getTicketIDBySkinID(slot0)
	return uv0[slot0]
end

TalentTreeCfg.get_id_list_by_activity_id_and_race = {}

for slot19, slot20 in pairs(TalentTreeCfg.get_id_list_by_activity_id) do
	TalentTreeCfg.get_id_list_by_activity_id_and_race[slot19] = {}
	slot21 = nil

	for slot25, slot26 in ipairs(slot20) do
		if TalentTreeCfg.get_id_list_by_activity_id_and_race[slot19][TalentTreeCfg[slot26].race] == nil then
			TalentTreeCfg.get_id_list_by_activity_id_and_race[slot19][slot21] = {}
		end

		table.insert(TalentTreeCfg.get_id_list_by_activity_id_and_race[slot19][slot21], slot26)
	end
end

slot19 = ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO

for slot19, slot20 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot19]) do
	for slot25, slot26 in ipairs(ActivityCultivateHeroCfg[slot20].group) do
		for slot31, slot32 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[slot26]) do
			CultivateHeroTaskCfg[slot32].activity_id = slot20
		end
	end
end

function DealAreaDifferenceCfg(slot0)
	if slot0 == nil or slot0 == "" or slot0 == "zh_cn" then
		return
	end

	if _G["WordVerifyCfg" .. slot0] then
		WordVerifyCfg = _G["WordVerifyCfg" .. slot0]
		WordVerifyCfg2 = _G["WordVerifyCfg2" .. slot0]
		WordVerifyCfg3 = _G["WordVerifyCfg3" .. slot0]
		WordVerifyCfg4 = _G["WordVerifyCfg4" .. slot0]
		WordVerifyCfg5 = _G["WordVerifyCfg5" .. slot0]
		WordVerifyCfg6 = _G["WordVerifyCfg6" .. slot0]
		WordVerifyCfg7 = _G["WordVerifyCfg7" .. slot0]
		WordVerifyCfg8 = _G["WordVerifyCfg8" .. slot0]
		WordVerifyCfg9 = _G["WordVerifyCfg9" .. slot0]
		WordVerifyCfg10 = _G["WordVerifyCfg10" .. slot0]
	end

	if _G["PaymentCfg" .. slot0] then
		PaymentCfg = _G["PaymentCfg" .. slot0]
	end

	if _G["TotalRechargeCfg" .. slot0] then
		TotalRechargeCfg = _G["TotalRechargeCfg" .. slot0]
	end

	if _G["RechargeCfg" .. slot0] then
		RechargeCfg = _G["RechargeCfg" .. slot0]
	end
end

function GetCfgDescription(slot0, slot1)
	if not DescriptionCfg[slot0] then
		print("错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表"
	end

	slot3 = GetI18NText(slot2.description)

	if slot1 == nil then
		slot1 = 1
	end

	if not slot2.param[slot1] then
		print("错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1)

		return "错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1
	end

	if #slot4 > 1 then
		return LuaExchangeHelper.GetDescription(slot3, slot4)
	else
		return slot3
	end
end

slot16 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.POLYHEDRON_ACTIVITY] or {}

for slot20, slot21 in ipairs(slot16) do
	ActivityCfg[slot21].policy_activity_id = slot21
	slot23 = {}
	slot24 = {}

	for slot28, slot29 in ipairs(ActivityCfg[slot21].sub_activity_list) do
		if ActivityCfg[slot29].activity_template == ActivityTemplateConst.TASK then
			if AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[slot29][1]].type == TaskConst.TASK_TYPE.POLYHEDRON_SEASON then
				slot23[#slot23 + 1] = slot29
			elseif AssignmentCfg[slot31[1]].type == TaskConst.TASK_TYPE.POLYHEDRON_ACHIEVEMENT then
				slot24[#slot24 + 1] = slot29
			end
		end
	end

	ActivityCfg[slot21].season_task_activity_list = slot23
	ActivityCfg[slot21].achievement_task_activity_list = slot24
end

table.deepMerge(StoryWordCfg, StoryWordCfg2)
