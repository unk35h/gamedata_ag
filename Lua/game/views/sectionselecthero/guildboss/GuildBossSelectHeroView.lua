slot0 = class("GuildBossSelectHeroView", SectionSelectHeroBaseView)

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.heroInfoList_ = {}
end

function slot0.GoHeroInfoUI(slot0, slot1)
	slot0:Go("/guildBossTeamInfo", {
		isEnter = true,
		selectHeroPos = slot1,
		stageID = slot0.stageID_,
		activityID = slot0.params_.activityID,
		stageType = slot0.stageType_,
		heroList = slot0.heroInfoList_,
		selfInfoCallback = handler(slot0, slot0.OnHeroChange),
		assistantInfoCallback = handler(slot0, slot0.OnAssistantHeroChange)
	})
end

function slot0.GetSelectHero(slot0)
	slot0.lockStateList_ = {}
	slot0.heroTrialList_ = {}
	slot0.cacheHeroTeam_ = {}

	if slot0.params_.isReserves then
		slot4 = slot0.params_.index
		slot0.cacheHeroTeam_ = BattleTeamData:GetReservesTeam(slot4)

		for slot4, slot5 in ipairs(slot0.cacheHeroTeam_) do
			slot0:OnHeroChange(slot4, slot5)
		end

		return
	end

	slot2 = GuildData:GetAssistantBriefList()
	slot3 = {}

	if BattleTeamData:GetTeamRawDataByType(slot0.stageType_) then
		for slot7, slot8 in ipairs(slot1) do
			if slot8.hero_type == 3 then
				slot9 = false
				slot10 = nil

				for slot14, slot15 in ipairs(slot2) do
					if slot15.member_id == slot8.owner_id then
						slot10 = slot15

						if slot15.assist_hero_id ~= slot8.hero_id then
							slot9 = true

							break
						end
					end
				end

				if not slot9 and slot10 ~= nil then
					table.insert(slot3, {
						type = 2,
						info = slot10
					})
				end
			elseif slot8.hero_type == 1 then
				table.insert(slot3, {
					type = 1,
					heroId = slot8.hero_id
				})
			else
				error("不支持试用角色")
			end
		end

		slot0.heroInfoList_ = slot3
	else
		slot3 = slot0.heroInfoList_
	end

	for slot7 = 1, 3 do
		if slot0.heroInfoList_[slot7] ~= nil then
			if slot0.heroInfoList_[slot7].type == 1 then
				slot0.cacheHeroTeam_[slot7] = slot0.heroInfoList_[slot7].heroId
			else
				slot0.cacheHeroTeam_[slot7] = slot0.heroInfoList_[slot7].info.assist_hero_id
			end
		else
			slot0.cacheHeroTeam_[slot7] = 0
		end
	end
end

function slot0.OnHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	if slot2 == 0 then
		for slot6 = slot1, 2 do
			slot0.heroInfoList_[slot6] = slot0.heroInfoList_[slot6 + 1]
		end

		slot0.heroInfoList_[3] = nil
	else
		if slot0.heroInfoList_[1] ~= nil and slot3.type == 1 and slot3.heroId == slot2 and slot0.heroInfoList_[slot1] == nil then
			return
		end

		if slot2 ~= nil and slot2 > 0 then
			slot0.heroInfoList_[slot1] = {
				type = 1,
				heroId = slot2
			}
		else
			slot0.heroInfoList_[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
end

function slot0.OnAssistantHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		for slot6 = slot1, 2 do
			slot0.heroInfoList_[slot6] = slot0.heroInfoList_[slot6 + 1]
		end

		slot0.heroInfoList_[3] = nil
	else
		if slot0.heroInfoList_[1] ~= nil and slot3.type == 2 and slot3.info.assist_hero_id == slot2.assist_hero_id and slot3.info.member_id == slot2.member_id and slot0.heroInfoList_[slot1] == nil then
			return
		end

		if slot2 ~= nil then
			slot0.heroInfoList_[slot1] = {
				type = 2,
				info = slot2
			}
		else
			slot0.heroInfoList_[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
end

function slot0.GetHeroPower(slot0, slot1)
	if slot0.heroInfoList_[slot1] and slot0.heroInfoList_[slot1].type == 2 then
		return slot0.heroInfoList_[slot1].info.fight_capacity
	end

	return getHeroPower(slot0.heroInfoList_[slot1].heroId, false)
end

function slot0.GetSkinCfg(slot0, slot1)
	if slot0.heroInfoList_[slot1] and slot0.heroInfoList_[slot1].type == 2 then
		if slot0.heroInfoList_[slot1].info.assist_hero_skin == 0 then
			slot2 = slot0.heroInfoList_[slot1].info.assist_hero_id
		end

		return SkinCfg[slot2]
	end

	return slot0:GetHeroCfg(slot0.heroInfoList_[slot1].heroId)
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot0.heroInfoList_) do
			if slot12.type == 2 and slot12.info.assist_hero_id == slot7 then
				slot2[slot7] = slot12
			elseif slot12.type == 1 and slot12.heroId == slot7 then
				slot2[slot7] = slot12
			end
		end
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		slot3[slot7] = slot2[slot8]
	end

	slot0.heroInfoList_ = slot3

	slot0:GuildBossChangeHeroTeam(slot0.heroInfoList_)
	slot0:RefreshAddBtn()
end

function slot0.GuildBossChangeHeroTeam(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot7 = 1, 3 do
		if slot1[slot7] then
			if slot1[slot7].type == 1 then
				table.insert(slot2, {
					owner_id = 0,
					hero_type = 1,
					hero_id = slot8.heroId
				})
				table.insert(slot3, slot8.heroId)
			elseif slot8.type == 2 then
				table.insert(slot2, {
					hero_type = 3,
					hero_id = slot8.info.assist_hero_id,
					owner_id = slot8.info.member_id
				})
				table.insert(slot3, slot8.info.assist_hero_id)
			end
		end
	end

	ComboSkillData:SetNeedRefresh(true)

	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4, {
			hero_id = slot9.hero_id,
			owner_id = tonumber(slot9.owner_id),
			hero_type = slot9.hero_type
		})
	end

	BattleTeamData:SetTeamRawData(slot0.stageType_, slot2)
	BattleFieldAction.PushGuildTeamsToServer(slot0.stageType_, slot4, slot0.params_.activityID, slot0.comboSkillView_:GetComboSkillID(), {
		id = slot0.chipView_:GetCurEnabledID(),
		chip = slot0.chipView_:GetCurChipList()
	})
end

function slot0.CheckComboSkillExist(slot0, slot1)
	return true
end

function slot0.StartBattle(slot0)
	slot1 = BattleStageFactory.Produce(slot0.stageType_, slot0.stageID_, 1)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0.heroInfoList_) do
		if slot10.type == 2 then
			table.insert(slot2, slot10.info.assist_hero_id)
			table.insert(slot3, slot10.info.member_id)
			table.insert(slot4, slot10.info.assist_hero_id)
			table.insert(slot5, slot10.info.member_id)
		else
			table.insert(slot2, slot10.heroId)
			table.insert(slot3, "0")
		end
	end

	slot6 = 0

	slot1:SetGuildBossTeam(slot2, slot3)
	slot1:SetMultiple(slot0.multiple_)
	slot1:SetDest(slot0.params_.dest)
	slot1:InitChipData()

	if #slot4 > 0 then
		for slot10, slot11 in ipairs(slot4) do
			slot12 = ForeignInfoAction

			slot12:TryToCheckForeignHeroInfo(slot5[slot10], slot11, 2, function ()
				uv0 = uv0 + 1

				if uv0 >= #uv1 then
					slot0 = {}

					for slot4, slot5 in ipairs(uv1) do
						slot0[slot5] = ForeignInfoData:GetHeroInfo(slot5).using_hero_chip
					end

					uv2:SetChipDic(slot0)
					BattleController.GetInstance():LaunchBattle(uv2)
				end
			end)
		end
	else
		BattleController.GetInstance():LaunchBattle(slot1)
	end
end

function slot0.GetHeroId(slot0, slot1)
	if slot0.heroInfoList_[slot1] == nil then
		return 0
	end

	if slot0.heroInfoList_[slot1].type == 1 then
		return slot0.heroInfoList_[slot1].heroId
	end

	return slot0.heroInfoList_[slot1].assist_hero_id
end

return slot0
