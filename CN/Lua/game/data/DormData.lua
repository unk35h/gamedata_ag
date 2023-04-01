require("game.data.DormDataTemplate")

slot0 = import("game.dorm.DormEnum")
slot1 = singletonClass("DormData")
slot2, slot3, slot4, slot5, slot6, slot7 = nil

function slot1.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
end

function slot1.InitHeroInfo(slot0, slot1, slot2)
	if slot1 and slot2 then
		for slot6, slot7 in ipairs(slot1) do
			uv0[slot7.archives_id] = DormHeroTemplate.New({
				archives_id = slot7.archives_id,
				hero_id = slot7.hero_id,
				feed_times = slot7.feed_times or 0,
				fatigue = slot7.fatigue
			})
		end

		uv1 = slot2
	end
end

function slot1.GetArchiveIDByJobType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7.jobType == slot1 then
			table.insert(slot2, slot6)
		end
	end

	return slot2
end

function slot1.GetDormAdditionByHeroID(slot0, slot1, slot2, slot3)
	slot4 = {
		attribute = {},
		voice = {}
	}

	if not table.indexof(slot0:GetCanUseHeroInDorm(), slot0:GetHeroArchiveID(slot1)) then
		return slot4
	end

	slot8 = slot0:GetHeroInfo(slot5):GetHeroId()
	slot9 = 0

	if not slot3 then
		slot9 = slot2 or slot0:GetDormLevelByHeroID(slot8)
	end

	for slot13 = 1, slot9 do
		for slot18, slot19 in ipairs(BackHomeHeroCfg[slot8].level_reward[slot13]) do
			if BackHomeDormLevelRewardCfg[slot19].type == 1 then
				if not slot4.attribute[slot20.reward[1]] then
					slot4.attribute[slot20.reward[1]] = 0
				end

				slot4.attribute[slot20.reward[1]] = slot4.attribute[slot20.reward[1]] + slot20.reward[2]
			elseif slot20.type == 2 then
				table.insert(slot4.voice, slot20.reward[1])
			end
		end
	end

	return slot4
end

function slot1.GetDormLevelByHeroID(slot0, slot1)
	return DormitoryData:GetDormLevel(DormitoryData:GetDormIDViaArchive(uv0:GetHeroArchiveID(slot1))) or 0
end

function slot1.GetHeroArchiveID(slot0, slot1)
	if HeroRecordCfg.get_id_list_by_hero_id[slot1] then
		return HeroRecordCfg.get_id_list_by_hero_id[slot1][1]
	end

	return slot1
end

function slot1.GetHeroInfoList(slot0)
	return uv0
end

function slot1.GetHeroInfo(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = DormHeroTemplate.New({
			feed_times = 0,
			archives_id = slot1,
			fatigue = GameSetting.canteen_hero_fatigue_max.value[1]
		})
	end

	return uv0[slot1]
end

function slot1.GetHeroTemplateInfo(slot0, slot1)
	if not uv0[slot0:GetHeroArchiveID(slot1)] then
		uv0[slot2] = DormHeroTemplate.New({
			feed_times = 0,
			archives_id = slot2,
			fatigue = GameSetting.canteen_hero_fatigue_max.value[1]
		})
	end

	return uv0[slot2]
end

function slot1.GetHeroFatigue(slot0, slot1)
	if not uv0[slot0:GetHeroArchiveID(slot1)] then
		uv0[slot2] = DormHeroTemplate.New({
			feed_times = 0,
			archives_id = slot2,
			fatigue = GameSetting.canteen_hero_fatigue_max.value[1]
		})
	end

	return uv0[slot2].fatigue
end

function slot1.SetHeroFatigue(slot0, slot1, slot2)
	slot3 = slot0:GetHeroArchiveID(slot1)

	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot3] and not slot3 then
		uv0[slot3] = DormHeroTemplate.New({
			feed_times = 0,
			archives_id = slot3,
			fatigue = GameSetting.canteen_hero_fatigue_max.value[1]
		})
	end

	uv0[slot3]:SetFatigue(slot2)
end

function slot1.RefreshInDormHeroInfo(slot0, slot1, slot2)
	slot3 = BackHomeCfg[slot1].type
	slot4 = DormitoryData:GetDormSceneData(slot1)
	slot5 = slot0:GetHeroInfoList()

	if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot4.archiveIDList = {}

		for slot9, slot10 in ipairs(slot2) do
			slot11 = DormData:GetHeroArchiveID(slot10)

			table.insert(slot4.archiveIDList, slot11)
			slot5[slot11]:ResetHeroSkill()
		end
	elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot7 = DormData:GetHeroArchiveID(slot2[1])

		if slot4.archiveIDList and #slot4.archiveIDList > 0 then
			print("该房间已被其他角色使用")

			return
		end

		slot4.archiveIDList = {}

		table.insert(slot4.archiveIDList, slot7)
		slot0:GetHeroTemplateInfo(slot7):SetCurHeroID(slot6)
		slot5[slot7]:ResetHeroSkill()
	end
end

function slot1.HasJobAssignedToHero(slot0, slot1)
	slot2 = uv0.RestaurantJobToServerMap[slot1]

	for slot6, slot7 in pairs(uv1) do
		if slot7.jobType == slot2 then
			return true
		end
	end

	return false
end

function slot1.InitCanteenHeroState(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if uv0[slot0:GetHeroArchiveID(slot6.hero_id)] then
			slot9:SetJob(slot6.type)
			slot9:SetCurHeroID(slot7)
		end
	end

	DormData:RefreshCanteenJobList()
end

slot8 = nil

function slot1.GetCanteenJobList(slot0)
	if uv0 then
		return uv0
	end
end

function slot1.GetJobTypeByHeroID(slot0, slot1)
	if uv0[slot0:GetHeroArchiveID(slot1)] then
		return slot3.jobType
	end
end

function slot1.RefreshCanteenJobList(slot0)
	slot1 = {
		{},
		{},
		{}
	}

	for slot5, slot6 in pairs(uv0) do
		if slot6.jobType then
			slot1[slot6.jobType].heroID = uv0[slot5]:GetHeroId()
		end
	end

	uv1 = slot1
end

function slot1.GetJobDispatchMaxCount(slot0, slot1)
	if slot1 == uv0.CharacterType.RestaurantCook then
		return 1
	elseif slot1 == uv0.CharacterType.RestaurantWaiter then
		return 1
	elseif slot1 == uv0.CharacterType.RestaurantCashier then
		return 1
	end
end

function slot1.GetCanUseHeroInDorm(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(slot7) == true and BackHomeHeroCfg[slot7] then
			slot1[DormData:GetHeroArchiveID(slot7)] = true
		end
	end

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot6)
	end

	return slot2
end

function slot1.GetAllCanUseHeroInDorm(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(slot6) == true and BackHomeHeroCfg[slot6] then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot1.GetDormSceneData(slot0, slot1)
	if slot1 then
		if BackHomeCfg[slot1] then
			if slot2.type == 1 then
				return CanteenData:GetCanteenSceneData()
			elseif slot3 == 2 or slot3 == 3 or slot3 == 4 or slot3 == 5 then
				return DormitoryData:GetDormMapList()[slot1]
			end
		else
			Debug.LogError("不存在" .. slot1 .. "场景的配置信息")
		end
	else
		Debug.LogError("id为空")
	end
end

function slot1.GetDormSceneDataList(slot0, slot1)
	if slot1 == uv0.DormSystemType.Canteen then
		return {
			CanteenData:GetCanteenSceneData()
		}
	elseif slot1 == uv0.DormSystemType.Dormitory then
		return DormitoryData:GetDormMapList()
	end
end

function slot1.SetCurrentScene(slot0, slot1)
	uv0 = slot1
end

function slot1.GetCurrectSceneID(slot0)
	if uv0 then
		return uv0
	end
end

function slot1.AddFurnitureInfo(slot0, slot1, slot2, slot3)
	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			if not BackHomeFurniture[slot8.furniture_id] then
				print("家具信息错误,id为" .. slot8.furniture_id)

				return
			end

			if BackHomeFurniture[slot8.furniture_id].type == 20 or BackHomeFurniture[slot8.furniture_id].type == 21 then
				break
			else
				slot9 = FurnitureInfo.New()
				slot9.id = slot8.furniture_id
				slot9.tileType = slot3
				slot9.pos = Vector2.New(slot8.x / DormConst.POS_PRECISION, slot8.y / DormConst.POS_PRECISION)
				slot9.rotation = slot8.rotation / DormConst.POS_PRECISION

				table.insert(slot1, slot9)
			end
		end
	end
end

function slot1.InitFurnitureInfoList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.furniture_id] = {
			num = slot6.num,
			give_num = slot6.give_num or 0,
			hasPlaceNum = 0
		}
	end
end

function slot1.GetFurnitureInfoList(slot0)
	return uv0
end

function slot1.GetFurNumInfo(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	else
		uv0[slot1] = {
			hasPlaceNum = 0,
			num = 0,
			give_num = 0
		}

		return uv0[slot1]
	end
end

function slot1.GetRoomCanUseFurList(slot0, slot1)
	slot2 = {}

	if DormData:GetCanUseFurListByRoomID(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if DormitoryData:GetCanUseFurNumInRoom(slot1, slot8) > 0 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot1.GetRoomCanPlaceFurMaxNum(slot0, slot1, slot2)
	slot3 = 0

	if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormTools:JudgeFurType(slot2) then
			if BackHomeFurniture[slot2].is_give == 0 then
				if uv0[slot2].num > 0 then
					slot3 = 1
				end
			elseif BackHomeFurniture[slot2].is_give == 1 and uv0[slot2].give_num > 0 then
				slot3 = 1
			end
		elseif BackHomeFurniture[slot2].is_give == 0 then
			slot3 = uv0[slot2].num
		elseif BackHomeFurniture[slot2].is_give == 1 then
			slot3 = uv0[slot2].give_num
		end
	elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot5 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1])

		if DormTools:JudgeFurType(slot2) then
			if BackHomeFurniture[slot2].is_give == 0 then
				if uv0[slot2].num > 0 then
					slot3 = 1
				end
			elseif BackHomeFurniture[slot2].is_give == 1 and slot5:GetGiftNum(slot2) > 0 then
				slot3 = 1
			end
		elseif BackHomeFurniture[slot2].is_give == 0 then
			slot3 = uv0[slot2].num
		elseif BackHomeFurniture[slot2].is_give == 1 then
			slot3 = slot5:GetGiftNum(slot2)
		end
	end

	return slot3
end

function slot1.RefreshPlaceFurNumList(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if not DormTools:JudgeFurType(slot5) then
			slot6.hasPlaceNum = 0
		end
	end

	for slot6, slot7 in pairs(uv1:GetDormSceneDataList(slot1)) do
		slot8, slot9 = slot0:GetHasPlaceFurNumInfoInMap(slot6)

		for slot13, slot14 in pairs(slot9) do
			if not uv0[slot13] then
				uv0[slot13] = {
					hasPlaceNum = 0,
					num = 0,
					give_num = 0
				}
			end

			if not uv0[slot13].hasPlaceNum then
				uv0[slot13].hasPlaceNum = 0
			end

			uv0[slot13].hasPlaceNum = uv0[slot13].hasPlaceNum + slot14
		end
	end
end

function slot1.RefreshWallAndFloorNumList(slot0, slot1)
	slot2 = uv0:GetDormSceneDataList(slot1)

	for slot6, slot7 in pairs(uv1) do
		if DormTools:JudgeFurType(slot6) then
			slot7.hasPlaceNum = 0
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot9 = slot2[slot6].floorID

		if not uv1[slot2[slot6].wallID].hasPlaceNum then
			uv1[slot8].hasPlaceNum = 0
		end

		if not uv1[slot9].hasPlaceNum then
			uv1[slot9].hasPlaceNum = 0
		end

		uv1[slot9].hasPlaceNum = uv1[slot9].hasPlaceNum + 1
		uv1[slot8].hasPlaceNum = uv1[slot8].hasPlaceNum + 1
	end
end

function slot1.GetHasPlaceFurNumInfoInMap(slot0, slot1)
	slot2 = 0
	slot3 = {}

	if uv0:GetDormSceneData(slot1).roomInfo then
		for slot9 = 0, slot4.roomInfo.furnitureInfoS.Length - 1 do
			slot2 = slot2 + 1

			if not slot3[slot5[slot9].id] then
				slot3[slot5[slot9].id] = 0
			end

			slot3[slot5[slot9].id] = slot3[slot5[slot9].id] + 1
		end
	end

	return slot2, slot3
end

function slot1.AddFurTotalNum(slot0, slot1, slot2)
	slot3 = slot0:GetFurNumInfo(slot1)
	slot3.num = slot3.num + slot2
end

function slot1.GetCanUseFurListByRoomID(slot0, slot1)
	slot2 = {}
	slot3 = BackHomeCfg[slot1].type

	for slot7, slot8 in pairs(uv0) do
		for slot13, slot14 in ipairs(BackHomeFurniture[slot7].scene_id) do
			if slot14 == slot3 then
				table.insert(slot2, slot7)

				break
			end
		end
	end

	return slot2
end

function slot1.GetHeroFatigueInfo(slot0)
	return uv0
end

function slot1.GetFatigueUpdateTime(slot0)
	return uv0
end

function slot1.SetfatigueUpdateTime(slot0, slot1)
	uv0 = slot1
end

return slot1
