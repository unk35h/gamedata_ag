DormHeroTemplate = class("DormDataTemplate")

function DormHeroTemplate.Ctor(slot0, slot1)
	slot0.fatigue = slot1.fatigue or GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.feed_times = slot1.feed_times
	slot0.archives_id = slot1.archives_id
	slot0.canUseHero = {}

	for slot6, slot7 in ipairs(HeroRecordCfg[slot0.archives_id].hero_id) do
		if BackHomeHeroCfg[slot7] and HeroTools.GetHeroIsUnlock(slot7) == true then
			table.insert(slot0.canUseHero, slot7)
		end
	end

	if not BackHomeHeroCfg[slot1.hero_id] then
		if slot0.canUseHero[1] then
			slot0.hero_id = slot0.canUseHero[1]
		else
			print("无可用人物")
		end

		return
	else
		slot0.hero_id = slot1.hero_id
	end

	slot0.buffList = {}
end

function DormHeroTemplate.GetHeroId(slot0)
	if BackHomeHeroCfg[slot0.hero_id] then
		return slot0.hero_id
	elseif #slot0.canUseHero > 0 then
		return slot0.canUseHero[1]
	end
end

function DormHeroTemplate.SetCurHeroID(slot0, slot1)
	if slot1 == nil then
		slot0.hero_id = nil

		return
	end

	if slot0.archives_id == DormData:GetHeroArchiveID(slot1) then
		slot0.hero_id = slot1
	else
		print("传入角色id不是本档案角色")
	end
end

function DormHeroTemplate.GetFatigue(slot0)
	return slot0.fatigue
end

function DormHeroTemplate.SetFatigue(slot0, slot1)
	if slot1 < 0 or GameSetting.canteen_hero_fatigue_max.value[1] < slot1 then
		print("设置体力越界")

		return
	end

	slot0.fatigue = slot1

	slot0.UpdataHeroState(slot0)
end

function DormHeroTemplate.CalFatigue(slot0, slot1)
	slot0.fatigue = math.min(slot0.fatigue + slot1, GameSetting.canteen_hero_fatigue_max.value[1])

	if slot0.fatigue < 0 then
		slot0.fatigue = 0
	end

	slot0.UpdataHeroState(slot0)
end

function DormHeroTemplate.UpdataHeroState(slot0)
	slot1 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

	if slot0.fatigue < slot1 - slot1 % 0.1 then
		if slot0.jobType then
			slot0.jobType = nil
		end

		slot0.BackToDorm(slot0)
	end
end

function DormHeroTemplate.GetRecoverFatigueNum(slot0)
	slot3 = 3600 / GameSetting.dorm_fatigue_time.value[1]

	if slot0.GetHeroState(slot0) == DormEnum.DormHeroState.InCanteenRntrust or slot1 == DormEnum.DormHeroState.OutDorm then
		return 0
	elseif slot1 == DormEnum.DormHeroState.InPublicDorm then
		slot4 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
		slot5 = 0

		if slot0.hero_id then
			slot5 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
		end

		return slot4 * (100 + slot5) / 100 * slot3
	elseif slot1 == DormEnum.DormHeroState.InPrivateDorm then
		slot5 = GameSetting.dorm_fatigue_increase.value[DormData:GetDormLevelByHeroID(slot0.archives_id)][2] / 100
		slot6 = 0

		if slot0.hero_id then
			slot6 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
		end

		return slot5 * (100 + slot6) / 100 * slot3
	end

	print("人物处于未知状态")
end

function DormHeroTemplate.GetCurRoomID(slot0)
	if slot0.GetHeroState(slot0) == DormEnum.DormHeroState.InCanteenRntrust then
		return DormConst.CANTEEN_ID
	end

	if slot1 == DormEnum.DormHeroState.InPublicDorm then
		return DormConst.PUBLIC_DORM_ID
	elseif slot1 == DormEnum.DormHeroState.InPrivateDorm then
		return DormitoryData:GetDormIDViaArchive(slot0.archives_id)
	end

	return nil
end

function DormHeroTemplate.GetPrivateRoomID(slot0)
	for slot5, slot6 in pairs(DormitoryData:GetDormMapList()) do
		if BackHomeCfg[slot5].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for slot10, slot11 in ipairs(slot6.archiveIDList) do
				if slot11 == slot0.archives_id then
					return slot5
				end
			end
		end
	end

	return nil
end

function DormHeroTemplate.GetHeroState(slot0)
	slot1 = DormitoryData:GetDormIDViaArchive(slot0.archives_id)

	if CanteenData:CheckHasChooseEntrustCharacter(slot0.archives_id) or slot0.jobType then
		return DormEnum.DormHeroState.InCanteenRntrust
	end

	if DormConst.PUBLIC_DORM_ID then
		for slot7, slot8 in ipairs(DormData:GetDormSceneData(slot2).archiveIDList) do
			if slot8 == slot0.archives_id then
				return DormEnum.DormHeroState.InPublicDorm
			end
		end

		if slot1 then
			return DormEnum.DormHeroState.InPrivateDorm
		end

		return DormEnum.DormHeroState.OutDorm
	end
end

function DormHeroTemplate.GetHeroFavorability(slot0)
	return ArchiveData:GetArchive(slot0.archives_id).lv
end

function DormHeroTemplate.GetGiftNum(slot0, slot1)
	return DormitoryData:GetDormSceneData(DormitoryData:GetDormIDViaArchive(slot0.archives_id)).give_furnitures[slot1] or 0
end

function DormHeroTemplate.GetCanGiftNum(slot0, slot1)
	slot2 = 0
	slot3 = DormitoryData:GetDormIDViaArchive(slot0.archives_id)

	if math.min(DormData:GetFurNumInfo(slot1).num - DormData:GetFurNumInfo(slot1).give_num, BackHomeFurniture[slot1].give_max - slot0:GetGiftNum(slot1)) < 0 then
		slot2 = 0

		print("可送礼数量错误")
	end

	return slot2
end

function DormHeroTemplate.FeedFood(slot0, slot1)
	slot0.feed_times = slot0.feed_times + 1

	slot0:CalFatigue(GameSetting.dorm_feed_fatigue.value[1])

	slot2 = GameDisplayCfg.dorm_interaction_feed.value

	Dorm.DormEntityManager.SendInteractToEntityCMD(slot1, slot1, slot2[math.random(1, #slot2)], false)
end

function DormHeroTemplate.GiftFur(slot0, slot1, slot2, slot3)
	if slot1 and slot2 then
		if not DormData:GetDormSceneData(DormitoryData:GetDormIDViaArchive(slot0.archives_id)).give_furnitures then
			slot5.give_furnitures = {}
		end

		if not slot5.give_furnitures[slot1] then
			slot5.give_furnitures[slot1] = 0
		end

		slot5.give_furnitures[slot1] = slot5.give_furnitures[slot1] + slot2
		slot6 = DormData:GetFurnitureInfoList()
		slot6[slot1].give_num = slot6[slot1].give_num + slot2

		if slot6[slot1].num < slot6[slot1].give_num then
			print("家具礼物数量大于拥有数量")
		end

		slot7 = GameDisplayCfg.dorm_interaction_gift.value

		Dorm.DormEntityManager.SendInteractToEntityCMD(slot3, slot3, slot7[math.random(1, #slot7)], false)
	else
		Debug.LogError("赠送家具id或数量为空")
	end
end

function DormHeroTemplate.TouchHero(slot0, slot1)
	slot2 = GameDisplayCfg.dorm_interaction_stroke.value

	Dorm.DormEntityManager.SendInteractToEntityCMD(slot1, slot1, slot2[math.random(1, #slot2)], false)
	SendMessageManagerToSDK("backhome_dorm_stroke", {
		hero_id = slot0.hero_id
	})
end

function DormHeroTemplate.BackToDorm(slot0)
	slot1 = DormitoryData:GetDormIDViaArchive(slot0.archives_id)

	if DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList then
		slot3 = #slot2

		if not slot1 and slot3 < GameSetting.dorm_lobby_hero_max.value[1] then
			table.insert(slot2, slot0.archives_id)
		end
	end

	slot0.ResetHeroSkill(slot0)
end

function DormHeroTemplate.GoToCanteen(slot0)
	if #DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList > 0 then
		for slot5 = 1, #slot1 do
			if slot1[slot5] == slot0.archives_id then
				table.remove(slot1, slot5)

				break
			end
		end
	end

	slot0.ResetHeroSkill(slot0)
end

function DormHeroTemplate.DisposeRunSkill(slot0)
	if slot0.hero_id then
		if not BackHomeHeroCfg[slot0.hero_id] then
			return
		end

		for slot5, slot6 in ipairs(BackHomeHeroCfg[slot0.hero_id].skill_list) do
			if DormSkillData:CheckSkillIsRun(slot0.hero_id, slot6, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(slot0.hero_id, slot6, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.OpenHeroSkill(slot0)
	if slot0.hero_id then
		slot2 = GameSetting.dorm_hero_skill_unlock.value
		slot3 = {}
		slot4 = HeroData:GetHeroData(slot0.hero_id).level

		for slot8 = 1, #BackHomeHeroCfg[slot0.hero_id].skill_list do
			if slot2[slot8] <= slot4 then
				table.insert(slot3, slot1[slot8])
			end
		end

		for slot8, slot9 in ipairs(slot3) do
			if DormSkillData:CheckSkillIsOpen(slot0.hero_id, slot9, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(slot0.hero_id, slot9, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.ResetHeroSkill(slot0)
	slot0.DisposeRunSkill(slot0)
	slot0.OpenHeroSkill(slot0)
end

function DormHeroTemplate.SetJob(slot0, slot1)
	slot0.jobType = slot1
end

DormRoomTemplate = class("DormRoomTemplate")

function DormRoomTemplate.Ctor(slot0, slot1)
	slot0.id = slot1.id
	slot0.type = slot1.type
	slot0.name = slot1.name or "默认名字"
	slot0.posID = slot1.pos
	slot0.furnitureInfoS = slot1.furnitureInfoS
	slot0.floorID = slot1.floorID
	slot0.wallID = slot1.wallID
end

function DormRoomTemplate.GetDormTemplateFurList(slot0)
	if slot0.furnitureInfoS then
		return slot0.furnitureInfoS
	else
		print("模板家具列表为空")
	end
end

function DormRoomTemplate.GetDormTemplateType(slot0)
	if slot0.type then
		return slot0.type
	end

	print("模板家具类型为空")
end

function DormRoomTemplate.GetDormTemplateFurNumInfo(slot0)
	slot1 = 0
	slot2 = {}

	if slot0.furnitureInfoS then
		for slot6 = 0, slot0.furnitureInfoS.Length - 1 do
			slot1 = slot1 + 1

			if not slot2[slot0.furnitureInfoS[slot6].id] then
				slot2[slot7.id] = 0
			end

			slot2[slot7.id] = slot2[slot7.id] + 1
		end
	end

	if slot0.floorID then
		slot2[slot0.floorID] = 1
	end

	if slot0.wallID then
		slot2[slot0.wallID] = 1
	end

	return slot1, slot2
end

function DormRoomTemplate.ReviseFurTemplateNameInfo(slot0, slot1)
	slot0.name = slot1
end

function DormRoomTemplate.GetTemplateName(slot0)
	return slot0.name
end

function DormRoomTemplate.GetTemplateWallAndFloorInfo(slot0)
	return {
		floorID = slot0.floorID,
		wallID = slot0.wallID
	}
end

function DormRoomTemplate.Dispose(slot0)
	slot0.id = nil
	slot0.type = nil
	slot0.name = nil
	slot0.posID = nil
	slot0.furnitureInfoS = nil
	slot0.floorID = nil
	slot0.wallID = nil
end
