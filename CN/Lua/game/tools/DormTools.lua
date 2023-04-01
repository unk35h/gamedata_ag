slot1 = nil

function dump_value_(slot0)
	if type(slot0) == "string" then
		slot0 = "\"" .. slot0 .. "\""
	end

	return tostring(slot0)
end

function split(slot0, slot1)
	slot0 = tostring(slot0)

	if tostring(slot1) == "" then
		return false
	end

	slot2 = 0
	slot3 = {}

	for slot7, slot8 in function ()
		return string.find(uv0, uv1, uv2, true)
	end, nil,  do
		table.insert(slot3, string.sub(slot0, slot2, slot7 - 1))

		slot2 = slot8 + 1
	end

	table.insert(slot3, string.sub(slot0, slot2))

	return slot3
end

function trim(slot0)
	return string.gsub(slot0, "^%s*(.-)%s*$", "%1")
end

function dump(slot0, slot1, slot2)
	if type(slot2) ~= "number" then
		slot2 = 3
	end

	slot3 = {}
	slot5 = split(debug.traceback("", 2), "\n")
	slot10 = slot1
	slot11 = "- "

	(function (slot0, slot1, slot2, slot3, slot4)
		slot1 = slot1 or "<var>"
		slot5 = ""

		if type(slot4) == "number" then
			slot5 = string.rep(" ", slot4 - string.len(dump_value_(slot1)))
		end

		if type(slot0) ~= "table" then
			uv0[#uv0 + 1] = string.format("%s%s%s = %s", slot2, dump_value_(slot1), slot5, dump_value_(slot0))
		elseif uv1[tostring(slot0)] then
			uv0[#uv0 + 1] = string.format("%s%s%s = *REF*", slot2, dump_value_(slot1), slot5)
		else
			uv1[tostring(slot0)] = true

			if uv2 < slot3 then
				uv0[#uv0 + 1] = string.format("%s%s = *MAX NESTING*", slot2, dump_value_(slot1))
			else
				slot14 = slot1
				uv0[#uv0 + 1] = string.format("%s%s = {", slot2, dump_value_(slot14))
				slot6 = slot2 .. "    "
				slot7 = {}
				slot8 = 0
				slot9 = {}

				for slot13, slot14 in pairs(slot0) do
					slot7[#slot7 + 1] = slot13

					if slot8 < string.len(dump_value_(slot13)) then
						slot8 = slot16
					end

					slot9[slot13] = slot14
				end

				function slot13(slot0, slot1)
					if type(slot0) == "number" and type(slot1) == "number" then
						return slot0 < slot1
					else
						return tostring(slot0) < tostring(slot1)
					end
				end

				table.sort(slot7, slot13)

				for slot13, slot14 in ipairs(slot7) do
					uv3(slot9[slot14], slot14, slot6, slot3 + 1, slot8)
				end

				uv0[#uv0 + 1] = string.format("%s}", slot2)
			end
		end
	end)(slot0, slot10, slot11, 1)

	for slot10, slot11 in ipairs({}) do
		print(slot11)
	end
end

return {
	HideAllCharacter = function ()
		DormCharacterManager.GetInstance():Clear()
	end,
	EnterFurnitureEdit = function ()
		uv0.HideAllCharacter()
		JumpTools.OpenPageByJump("/roomEdit")
	end,
	CalcEntrustLastTime = function (slot0, slot1)
		if slot1.start_time + BackHomeCanteenTaskCfg[slot1.id].time * 60 - manager.time:GetServerTime() > 0 then
			return manager.time:DescCDTime(slot6)
		else
			return 0
		end
	end,
	GetIsOverLoad = function (slot0, slot1)
		slot2 = DormitoryData:GetDormLevel(slot1)
		slot3 = nil

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot3 = GameSetting.dorm_lobby_furniture_limited.value[1]
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot3 = BackHomeDormLevel[slot2].furniture_max
		end

		if slot3 - DormitoryData:GetFurHasPlaceTotalNum(slot1) - DormitoryData:GetCacheFurTotalNum() > 0 then
			return true
		end

		return false
	end,
	ChangeDormScene = function (slot0)
		uv0.HideAllCharacter()
		DormAction:ChangeDormScene(slot0)
	end,
	ChangeDormFloorOrWall = function (slot0, slot1)
		if BackHomeFurniture[slot1].type == DormConst.FLOOR_TYPE_NUM then
			DormLuaBridge.SetRoomThemeFloor(BackHomeFurniture[slot1].model, BackHomeFurniture[slot1].extend)
		elseif BackHomeFurniture[slot1].type == DormConst.WALL_TYPE_NUM then
			DormLuaBridge.SetRoomThemeWall(BackHomeFurniture[slot1].material, BackHomeFurniture[slot1].mesh)
		end
	end,
	GenFurListInCurRoom = function (slot0, slot1)
		if slot1 then
			DormFurnitureManager.GetInstance():ClearAndGenByFurList(slot1)
		else
			print("家具信息不存在")
		end
	end,
	SaveDormSceneTemplate = function (slot0, slot1, slot2, slot3, slot4, slot5)
		if slot2 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
			slot2 = DormConst.BACKHOME_TYPE.PublicDorm
		end

		if slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
			slot2 = DormConst.BACKHOME_TYPE.PrivateDorm
		end

		if not slot4 or slot4 > 1000 then
			slot7 = DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID())

			DormAction:SaveFurTemplate(slot1, slot2, slot3, 0, slot7.roomInfo.furnitureInfoS, slot5, slot7.wallID, slot7.floorID)
		else
			DormAction:SaveFurTemplate(slot1, slot2, slot3, slot4, nil, slot5, nil, )
		end
	end,
	PreviewDormSceneTemplate = function (slot0, slot1)
		DormTools.HideAllCharacter()
		slot0:GenFurListInCurRoom(DormitoryData:GetDormTemplateInfo(slot1).furnitureInfoS)

		if DormitoryData:GetDormTemplateInfo(slot1):GetTemplateWallAndFloorInfo().floorID then
			slot0.ChangeDormFloorOrWall(slot0, slot3.floorID)
		end

		if slot3.wallID then
			slot0.ChangeDormFloorOrWall(slot0, slot3.wallID)
		end
	end,
	CancelPreviewDormSceneTemplate = function (slot0, slot1)
		slot2 = DormitoryData:GetDormSceneData(slot1)

		slot0:GenFurListInCurRoom(slot2.roomInfo.furnitureInfoS)
		slot0:ChangeDormFloorOrWall(slot2.floorID)
		slot0:ChangeDormFloorOrWall(slot2.wallID)
		DormTools:GenerateHeroWhenEnterScene()
	end,
	CheckFurNumSuitTemplate = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = true

		if not DormitoryData:GetDormTemplateInfo(slot1) then
			print("模板数据为空")

			return
		end

		slot6, slot7 = slot5.GetDormTemplateFurNumInfo(slot5)

		for slot11, slot12 in pairs(slot7) do
			if slot12 > DormitoryData:GetCanUseFurNumInRoom(slot2, slot11) + DormitoryData:GetHasPlaceFurInfoByRoom(slot2, slot11) then
				slot4 = false
				slot3[slot11] = slot12 - slot13
			end
		end

		if not slot4 then
			return slot4, slot3
		else
			return slot4, nil
		end
	end,
	ConfirmUseTemplateInRoom = function (slot0, slot1, slot2, slot3, slot4)
		if slot3 then
			DormAction:SetFurListInMap(slot2, slot1, nil)
		else
			DormAction:SetFurListInMap(slot2, nil, slot4)
		end
	end,
	ReduceTemplateLackFurInfoS = function (slot0, slot1, slot2)
		slot4 = DormitoryData:GetDormTemplateInfo(slot1)
		slot5 = {}
		slot6 = slot4.wallID
		slot7 = slot4.floorID

		for slot11 = 0, DormitoryData:GetDormTemplateInfo(slot1).furnitureInfoS.Length - 1 do
			slot12 = FurnitureInfo.New()
			slot12.id = slot3[slot11].id
			slot12.tileType = slot3[slot11].tileType
			slot12.pos = slot3[slot11].pos
			slot12.rotation = slot3[slot11].rotation

			table.insert(slot5, slot12)
		end

		for slot11 = #slot5, 1, -1 do
			if not uv0:JudgeFurType(slot5[slot11].id) and slot2[slot12] and slot2[slot12] > 0 then
				table.remove(slot5, slot11)

				slot2[slot12] = slot2[slot12] - 1
			end
		end

		slot8 = slot4.type

		if slot2[slot6] and slot2[slot6] > 0 then
			slot6 = DormitoryData:GetOriFloorOrWall(slot8, DormConst.WALL_TYPE_NUM)
		end

		if slot2[slot7] and slot2[slot7] > 0 then
			slot7 = DormitoryData:GetOriFloorOrWall(slot8, DormConst.FLOOR_TYPE_NUM)
		end

		slot9 = RoomInfo.New()
		slot9.furnitureInfoS = slot5

		return slot9.furnitureInfoS, slot6, slot7
	end,
	RenameTemplate = function (slot0, slot1, slot2)
		DormAction:ReviseFurTemplateName(slot1, slot2)
	end,
	GenerateHeroByDrag = function (slot0, slot1)
		DormLuaBridge.BeginGrabPlayerEntity(DormCharacterManager.GetInstance():Generate(slot1), UnityEngine.Camera.main, Input.mousePosition)
	end,
	GenreateHero = function (slot0, slot1)
		if not DormCharacterManager.GetInstance():Generate(slot1) then
			print("未生成角色" .. slot1)
		end

		return slot3
	end,
	ReGenerateDormHeroEntity = function (slot0)
		slot2 = CanteenAIFunction:GetAllEIDNameSpace(CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.DormNormalHero))
		slot5 = {}

		for slot9, slot10 in ipairs(DormitoryData:GetDormHerosByArchitecture(DormData:GetCurrectSceneID())) do
			slot5[slot10] = false
		end

		for slot9, slot10 in ipairs(slot2) do
			slot13 = false

			if CanteenAIFunction:GetEntityData(slot10).cfgID then
				for slot17, slot18 in pairs(slot5) do
					if slot12 == slot17 then
						slot13 = true
						slot5[slot17] = true

						break
					end
				end

				if slot13 == false then
					slot0.DisposeSingleHero(slot0, slot10)
				end
			end
		end

		for slot9, slot10 in pairs(slot5) do
			if slot10 == false then
				slot0.RandomSetHeroTrs(slot0, slot0.GenreateHero(slot0, slot9))
			end
		end
	end,
	EnterSceneWallAndFloor = function (slot0)
		slot1 = DormData:GetCurrectSceneID()
		slot2 = DormitoryData:GetDormSceneData(slot1)
		slot4 = slot2.wallID

		if not DormTools:JudgeFurIsOri(slot1, slot2.floorID) then
			DormLuaBridge.SetRoomThemeFloor(BackHomeFurniture[slot3].model, BackHomeFurniture[slot3].extend)
		end

		if not DormTools:JudgeFurIsOri(slot1, slot4) then
			DormLuaBridge.SetRoomThemeWall(BackHomeFurniture[slot4].material, BackHomeFurniture[slot4].mesh)
		end
	end,
	DisposeSingleHero = function (slot0, slot1)
		DormCharacterManager.FindAndRemove(slot1)
	end,
	GenerateHeroWhenEnterScene = function (slot0)
		if DormData:GetCurrectSceneID() > 1000 then
			if DormitoryData:GetCurVisitHeroList() then
				for slot6, slot7 in ipairs(slot2) do
					uv0:RandomSetHeroTrs(uv0:GenreateHero(slot7))
				end
			end

			return
		end

		if not DormitoryData:GetDormMapList()[slot1].archiveIDList then
			return
		end

		slot3 = nil

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			if slot2 and #slot2 > 0 then
				for slot7, slot8 in ipairs(slot2) do
					if DormData:GetHeroInfo(slot8):GetHeroId() ~= nil then
						uv0:RandomSetHeroTrs(uv0:GenreateHero(slot10))
					end
				end
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(slot2[1]) and slot5.GetHeroState(slot5) == DormEnum.DormHeroState.InPrivateDorm and slot5.GetHeroId(slot5) ~= nil then
			uv0:RandomSetHeroTrs(uv0:GenreateHero(slot7))
		end
	end,
	GenerateFurnitureWhenEnterScene = function (slot0)
		DormFurnitureManager.GetInstance():ClearAndGenByFurList(DormitoryData:GetDormFurListByRoomID(DormData:GetCurrectSceneID()))
		uv0:EnterSceneWallAndFloor()
	end,
	RandomSetHeroTrs = function (slot0, slot1)
		Dorm.DormEntityManager.PutEntityLookToDir(slot1, DormLuaBridge.FindSpawnPos(Dorm.DormEntityManager.QueryRadius(slot1), 5, true) or Dorm.DormEntityManager.QueryPosition(slot1), Quaternion.Euler(0, 360 * math.random(), 0) * Vector3.forward)
	end,
	GetBackHomeCanUseHeroList = function (slot0)
		slot1 = {}
		slot2 = {}

		if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot4 = {}

			for slot8, slot9 in ipairs(HeroCfg.get_id_list_by_private[0]) do
				if HeroTools.GetHeroIsUnlock(slot9) == true and BackHomeHeroCfg[slot9] and not slot2[DormData:GetHeroArchiveID(slot9)] then
					slot2[slot10] = true

					table.insert(slot4, slot10)
				end
			end

			for slot8, slot9 in pairs(slot4) do
				if #DormData:GetHeroInfo(slot9).canUseHero > 0 then
					for slot14, slot15 in ipairs(slot10.canUseHero) do
						table.insert(slot1, slot15)
					end
				end
			end

			return slot1
		elseif BackHomeCfg[slot3].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			if DormitoryData:GetDormSceneData(slot3).archiveIDList[1] then
				for slot10, slot11 in ipairs(DormData:GetHeroInfo(slot4).canUseHero) do
					table.insert(slot1, slot11)
				end
			else
				print("未找到档案id")
			end

			return slot1
		end

		Debug.LogError("未找到对应房间类型")
	end,
	CheckFurCanUseRoom = function (slot0, slot1, slot2)
		slot4 = false

		for slot8, slot9 in ipairs(BackHomeFurniture[slot2].scene_id) do
			if slot9 == BackHomeCfg[slot1].type then
				slot4 = true
			end
		end

		return slot4
	end,
	JudgeFurType = function (slot0, slot1)
		if BackHomeFurniture[slot1] then
			if BackHomeFurniture[slot1].type == DormConst.FLOOR_TYPE_NUM or BackHomeFurniture[slot1].type == DormConst.WALL_TYPE_NUM then
				return true
			else
				return false
			end
		else
			print("家具id配置错误" .. slot1)
		end
	end,
	JudgeFurIsOri = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(BackHomeCfg[slot1].default_item) do
			if slot2 == slot8[1] then
				return true
			end
		end

		return false
	end,
	VisitFlag = function (slot0, slot1)
		uv0 = slot1
	end,
	GetFlag = function (slot0)
		return uv0
	end,
	MinSwitchTime = function (slot0, slot1)
		slot2, slot3 = math.modf(slot1 / 60)

		return string.format("%02d:%02d:%02d", slot2, slot3, 0)
	end,
	SecondSwitchTime = function (slot0, slot1)
		slot2 = math.ceil(slot1 / 60)

		return string.format("%d%s%02d%s", math.modf(slot2 / 60), GetTips("HOUR"), slot2 % 60, GetTips("MINUTE"))
	end,
	PlayDormAudioEffect = function (slot0, slot1)
		manager.audio:PlayEffect("ui_dorm", slot1, "")
	end,
	IsVoiceNeedUnlock = function (slot0, slot1)
		for slot5, slot6 in ipairs(BackHomeDormLevelRewardCfg.all) do
			if BackHomeDormLevelRewardCfg[slot6].type == 2 and slot7.reward[1] == slot1 then
				return true
			end
		end

		return false
	end,
	GetVoiceUnlockLevel = function (slot0, slot1, slot2)
		slot5 = DormData:GetHeroInfo(DormData:GetHeroArchiveID(slot1)):GetHeroId()

		for slot9, slot10 in ipairs(BackHomeDormLevel.all) do
			for slot15, slot16 in ipairs(BackHomeHeroCfg[slot5].level_reward[slot9]) do
				if BackHomeDormLevelRewardCfg[slot16].type == 2 and slot17.reward[1] == slot2 then
					return slot10
				end
			end
		end

		return 1
	end,
	IsHeroInDormConfig = function (slot0, slot1)
		for slot7, slot8 in ipairs(HeroRecordCfg[DormData:GetHeroArchiveID(slot1)].hero_id) do
			if BackHomeHeroCfg[slot8] then
				return true
			end
		end

		return false
	end
}
