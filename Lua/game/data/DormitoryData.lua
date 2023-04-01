slot0 = singletonClass("DormitoryData")
slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10 = nil

function slot0.IsUnlockScene(slot0, slot1)
	if slot0:GetDormSceneData(slot1) == nil then
		return false
	end

	return true
end

function slot0.InitDormInfo(slot0, slot1)
	uv0 = {}
	uv1 = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			pos_id = slot6.pos_id,
			exp = slot6.exp or 0,
			archiveIDList = {}
		}

		for slot10, slot11 in ipairs(slot6.archives_id) do
			table.insert(uv0[slot6.id].archiveIDList, slot11)
		end

		if BackHomeCfg[slot6.id].type == 3 and #uv0[slot6.id].archiveIDList > 0 then
			uv1[uv0[slot6.id].archiveIDList[1]] = slot6.id
		end
	end

	slot0:UpdataDormRedPoint()
end

function slot0.GetUnlockRoomNum(slot0)
	slot1 = 0

	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if BackHomeCfg[slot5].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				slot1 = slot1 + 1
			end
		end
	end

	return slot1
end

function slot0.InitDormMap(slot0, slot1)
	uv0 = {}
	uv1 = {}

	if not uv0 then
		print("地图集合数据为空")
	end

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot10 = slot6.pos_id
			uv0[slot6.id] = {
				pos_id = slot10,
				archiveIDList = {}
			}

			for slot10, slot11 in ipairs(slot6.archives_id) do
				table.insert(uv0[slot6.id].archiveIDList, slot11)
			end

			if BackHomeCfg[slot6.id].type == 3 and #uv0[slot6.id].archiveIDList > 0 then
				uv1[uv0[slot6.id].archiveIDList[1]] = slot6.id
			end

			uv0[slot6.id].roomInfo = RoomInfo.New()
			uv0[slot6.id].roomInfo.id = slot6.id
			uv0[slot6.id].roomInfo.sceneName = BackHomeCfg[slot6.id].scene
			slot8 = {}

			if slot6.layout.temp_id == 0 then
				DormData:AddFurnitureInfo(slot8, slot6.layout.front_furnitures, DormConst.TILE_TYPE.WALL_FRONT)
				DormData:AddFurnitureInfo(slot8, slot6.layout.back_furnitures, DormConst.TILE_TYPE.WALL_BEHIND)
				DormData:AddFurnitureInfo(slot8, slot6.layout.left_furnitures, DormConst.TILE_TYPE.WALL_LEFT)
				DormData:AddFurnitureInfo(slot8, slot6.layout.right_furnitures, DormConst.TILE_TYPE.WALL_RIGHT)
				DormData:AddFurnitureInfo(slot8, slot6.layout.floor_furnitures, DormConst.TILE_TYPE.FLOOR)
			end

			if slot6.layout.floor_furnitures then
				for slot12, slot13 in ipairs(slot6.layout.floor_furnitures) do
					if BackHomeFurniture[slot13.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
						uv0[slot6.id].floorID = slot13.furniture_id
					elseif BackHomeFurniture[slot13.furniture_id].type == DormConst.WALL_TYPE_NUM then
						uv0[slot6.id].wallID = slot13.furniture_id
					end
				end
			end

			slot9 = BackHomeCfg[slot6.id].type

			if not uv0[slot6.id].floorID then
				uv0[slot6.id].floorID = slot0:GetOriFloorOrWall(slot9, DormConst.FLOOR_TYPE_NUM)
			end

			if not uv0[slot6.id].wallID then
				uv0[slot6.id].wallID = slot0:GetOriFloorOrWall(slot9, DormConst.WALL_TYPE_NUM)
			end

			uv0[slot6.id].roomInfo.furnitureInfoS = slot8
			uv0[slot6.id].give_furnitures = {}

			for slot13, slot14 in ipairs(slot6.give_furnitures) do
				uv0[slot6.id].give_furnitures[slot14.id] = slot14.num
			end

			slot0:RefreshHasPlaceFurNumInfo(slot6.id)
		end

		for slot5, slot6 in pairs(uv0) do
			slot0:RefreshDormExp(slot5)
		end
	end

	DormSkillData:Init()
	DormData:RefreshPlaceFurNumList(DormEnum.DormSystemType.Dormitory)
	slot0:InitFurPlaceRedPointData()
	slot0:InitFurEditFlag()

	uv2 = manager.time:GetServerTime()

	SendMessageManagerToSDK("backhome_dorm_opt", {
		backhome_type = 0,
		opt_time = -1
	})
end

slot11 = nil

function slot0.InitFurPlaceRedPointData(slot0)
	uv0 = {}

	for slot4, slot5 in pairs(DormConst.DORM_FUR_TYPE_RED_POINT) do
		uv0[slot4] = getData("RedPoint", slot5)
	end
end

function slot0.SaveFurPlaceRedPointData(slot0)
	for slot4, slot5 in pairs(uv0) do
		saveData("RedPoint", DormConst.DORM_FUR_TYPE_RED_POINT[slot4], slot5)
	end

	uv0 = nil
end

slot12 = nil

function slot0.InitFurEditFlag(slot0)
	uv0 = getData("Dorm", "furEditFlag")

	if not uv0 or tostring(uv0) == "userdata: NULL" then
		uv0 = {
			otherHadPlaceFlag = true,
			hadPlaceFlag = true,
			canPlaceFlag = true,
			notPresentedFlag = true
		}
	end
end

function slot0.SaveFurEditFlag(slot0)
	if uv0 then
		saveData("Dorm", "furEditFlag", uv0)
	end
end

function slot0.GetFurEditFlag(slot0)
	return uv0
end

function slot0.GetOriFloorOrWall(slot0, slot1, slot2)
	if slot1 == DormConst.BACKHOME_TYPE.PublicDorm then
		if slot2 == DormConst.FLOOR_TYPE_NUM then
			return DormConst.LOBBY_ORI_FLOOR_ID
		elseif slot2 == DormConst.WALL_TYPE_NUM then
			return DormConst.LOBBY_ORI_WALL_ID
		end
	elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
		if slot2 == DormConst.FLOOR_TYPE_NUM then
			return DormConst.FLOOR_ORI_ID
		elseif slot2 == DormConst.WALL_TYPE_NUM then
			return DormConst.WALL_ORI_ID
		end
	end
end

function slot0.RefreshDormExp(slot0, slot1)
	if uv0[slot1] then
		slot2 = uv0[slot1].give_furnitures
		slot3 = 0

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for slot7, slot8 in pairs(slot2) do
				if BackHomeFurniture[slot7] then
					slot3 = BackHomeFurniture[slot7].dorm_exp * slot8 + slot3
				else
					Debug.LogError("家具id不存在")
				end
			end
		end

		uv0[slot1].exp = slot3
	else
		print("房间数据不存在")
	end
end

function slot0.GetDormMapList(slot0)
	if uv0 then
		return uv0
	end

	print("宿舍地图数据不存在")
end

function slot0.GetDormSceneData(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end

	print("id" .. "号场景数据不存在")
end

function slot0.GetDormIDViaArchive(slot0, slot1)
	if slot1 then
		return uv0[slot1]
	end
end

function slot0.GetArchiveIDViaRoomID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].archiveIDList
	end
end

function slot0.SetDormIDViaArchive(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.UnLockDormArchitecture(slot0, slot1, slot2)
	slot3 = BackHomeCfg[slot1]
	uv0[slot1] = {
		exp = 0,
		pos_id = slot2,
		archiveIDList = {},
		give_furnitures = {}
	}
	slot4 = BackHomeCfg[slot1].type
	uv0[slot1].roomInfo = RoomInfo.New()
	uv0[slot1].roomInfo.id = slot1
	uv0[slot1].roomInfo.sceneName = slot3.scene
	uv0[slot1].roomInfo.furnitureInfoS = {}
	uv0[slot1].floorID = slot0:GetOriFloorOrWall(slot4, DormConst.FLOOR_TYPE_NUM)
	slot9 = slot4
	slot10 = DormConst.WALL_TYPE_NUM
	uv0[slot1].wallID = slot0:GetOriFloorOrWall(slot9, slot10)

	for slot9, slot10 in ipairs(slot3.default_item) do
		slot11 = DormData:GetFurNumInfo(slot10[1])
		slot11.num = slot11.num + 1
		slot11.hasPlaceNum = slot11.hasPlaceNum + 1
	end

	slot0:RefreshHasPlaceFurNumInfo(slot1)
end

function slot0.GetPrivateDormRoomState(slot0, slot1)
	if not slot1 then
		return DormEnum.DormRoomUseState.Lock
	end

	if BackHomeCfg[slot1].type ~= DormConst.BACKHOME_TYPE.PrivateDorm then
		return
	end

	if #uv0[slot1].archiveIDList > 0 then
		return DormEnum.DormRoomUseState.HadPlace
	else
		return DormEnum.DormRoomUseState.Unlock
	end
end

function slot0.RefreshHasPlaceFurNumInfo(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	uv0[slot1] = {}
	slot2 = {}

	for slot7 = 0, uv1[slot1].roomInfo.furnitureInfoS.Length - 1 do
		if not slot2[slot3[slot7].id] then
			slot2[slot8] = 0
		end

		slot2[slot8] = slot2[slot8] + 1
	end

	slot2[uv1[slot1].wallID] = 1
	slot2[uv1[slot1].floorID] = 1
	uv0[slot1] = slot2
end

function slot0.GetHasPlaceFurInfoByRoom(slot0, slot1, slot2)
	if uv0[slot1] then
		return uv0[slot1][slot2] or 0
	end

	print("未找到对应的已放置家具数量信息")
end

function slot0.GetFurHasPlaceTotalNum(slot0, slot1)
	slot2 = 0

	if uv0[slot1] then
		for slot7, slot8 in pairs(slot3) do
			if not DormTools:JudgeFurType(slot7) then
				slot2 = slot2 + slot8
			end
		end
	else
		print("未获取到已摆放家具数量信息")
	end

	return slot2
end

function slot0.GetDormFurListByRoomID(slot0, slot1)
	if uv0[slot1].roomInfo.furnitureInfoS then
		return uv0[slot1].roomInfo.furnitureInfoS
	end
end

function slot0.SyncRoomFurniture(slot0, slot1, slot2, slot3)
	if not uv0[slot1.architecture_id] then
		print("没有场景数据")

		return
	end

	uv0[slot4].roomInfo.furnitureInfoS = slot2

	if not slot3 then
		DormitoryData:SyncRoomFloorAndWall(slot1.furniture_layout.floor_furnitures)
	else
		DormitoryData:SyncRoomFloorAndWall(slot3)
	end

	DormData:RefreshPlaceFurNumList(DormEnum.DormSystemType.Dormitory)
	slot0:ClearFurNumInEditRoom()
	slot0:RefreshHasPlaceFurNumInfo(slot4)
end

function slot0.RevisePrivateDormPosData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.dorm_pos_list) do
		uv0[slot6.architecture_id].pos_id = slot6.pos_id
	end
end

function slot0.GetRoomIDByPosID(slot0, slot1)
	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if slot6.pos_id == slot1 then
				return slot5
			end
		end
	end
end

function slot0.GetDormHerosByArchitecture(slot0, slot1)
	slot2 = DormData:GetHeroInfoList()
	slot3 = {}

	if uv0[slot1].archiveIDList then
		for slot7, slot8 in ipairs(uv0[slot1].archiveIDList) do
			table.insert(slot3, slot2[slot8].hero_id)
		end
	end

	return slot3
end

function slot0.GetDormArchivesByArchitecture(slot0, slot1)
	slot2 = {}

	if uv0[slot1].archiveIDList then
		for slot6, slot7 in ipairs(uv0[slot1].archiveIDList) do
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.CheckHeroInRoom(slot0, slot1, slot2)
	slot3 = slot0:GetDormArchivesByArchitecture(slot1)

	if BackHomeCfg[slot1].type == 2 then
		for slot7, slot8 in ipairs(slot3) do
			if slot8 == slot2 then
				return true
			end
		end
	elseif BackHomeCfg[slot1].type == 3 and DormData:GetHeroInfo(slot3[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
		return true
	end

	return false
end

function slot0.GetDormExp(slot0, slot1)
	if not uv0[slot1].exp then
		uv0[slot1].exp = 0
	end

	return uv0[slot1].exp
end

function slot0.GetDormLevel(slot0, slot1)
	if not slot1 then
		debug.traceback("传入场景id为空")

		return
	end

	slot2 = nil
	slot4 = 0

	if slot0:GetDormExp(slot1) then
		for slot8, slot9 in ipairs(BackHomeDormLevel.all) do
			if slot3 < BackHomeDormLevel[slot9].exp + slot4 then
				slot2 = slot9

				break
			end
		end

		return slot2 or #BackHomeDormLevel.all
	end
end

function slot0.GetCanUseFurNumInRoom(slot0, slot1, slot2)
	slot4 = slot0:GetCacheFurNum(slot2)

	if not DormTools:CheckFurCanUseRoom(slot1, slot2) then
		return 0
	else
		slot5 = DormData:GetFurNumInfo(slot2)

		if BackHomeFurniture[slot2].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			if not DormTools:JudgeFurType(slot2) then
				return slot5.num - slot5.hasPlaceNum - slot4
			else
				if slot0:GetHasPlaceFurInfoByRoom(slot1, slot2) + slot4 >= 1 then
					return 0
				end

				if slot5.num - slot5.hasPlaceNum - slot4 > 0 then
					return 1
				else
					return 0
				end
			end
		elseif slot6 == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY then
			if DormitoryData:GetArchiveIDViaRoomID(slot1)[1] == BackHomeFurniture[slot2].hero_id then
				return slot5.num - slot5.hasPlaceNum - slot4
			end

			return 0
		elseif slot6 == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
				if not DormTools:JudgeFurType(slot2) then
					return slot5.give_num - slot5.hasPlaceNum - slot4
				else
					if slot0:GetHasPlaceFurInfoByRoom(slot1, slot2) + slot4 >= 1 then
						return 0
					end

					if slot5.give_num - slot5.hasPlaceNum - slot4 > 0 then
						return 1
					else
						return 0
					end
				end
			elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1]) then
				slot12 = slot5.give_num - slot5.hasPlaceNum - slot4

				if slot8:GetGiftNum(slot2) - slot0:GetHasPlaceFurInfoByRoom(slot1, slot2) - slot4 < 0 then
					print("可摆放家具计算错误")

					return 0
				end

				return math.min(slot12, slot11)
			end
		end

		print("未找到的类型")

		return 0
	end
end

function slot0.GetHadPlaceFurNumInRoom(slot0, slot1)
	slot2 = {}

	if DormData:GetCanUseFurListByRoomID(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:GetHasPlaceFurInfoByRoom(slot1, slot8) + slot0:GetCacheFurNum(slot8) > 0 then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.GetHadPlaceFlagFurInRoom(slot0, slot1)
	slot2 = {}

	if DormData:GetCanUseFurListByRoomID(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if DormData:GetRoomCanPlaceFurMaxNum(slot1, slot8) - DormitoryData:GetCanUseFurNumInRoom(slot1, slot8) - slot0:GetHasPlaceFurInfoByRoom(slot1, slot8) - slot0:GetCacheFurNum(slot8) > 0 then
				table.insert(slot2, slot8)
			elseif slot9 - slot10 - slot11 - slot12 < 0 then
				print("被占用数量计算错误")
			end
		end
	end

	return slot2
end

function slot0.GetNotPresentedFurInRoom(slot0, slot1)
	slot2 = {}

	if DormData:GetCanUseFurListByRoomID(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if BackHomeFurniture[slot8].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				slot9 = DormData:GetFurNumInfo(slot8)

				if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
					if slot9.give_num < slot9.num then
						table.insert(slot2, slot8)
					end
				elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					slot11 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1])

					if slot9.num - slot9.give_num > 0 and slot11:GetGiftNum(slot8) < BackHomeFurniture[slot8].give_max then
						table.insert(slot2, slot8)
					end
				end
			end
		end
	end

	return slot2
end

function slot0.CheckWallOrFloorCanUseInRoom(slot0, slot1, slot2)
	slot4 = uv0[slot1]
	slot6 = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1])

	if not DormTools:CheckFurCanUseRoom(slot1, slot2) then
		return 0
	else
		slot8 = DormData:GetFurNumInfo(slot2)

		if BackHomeFurniture[slot2].is_give == 0 then
			return slot8.num - slot8.hasPlaceNum
		elseif slot7 == 1 then
			if slot4.wall == slot2 or slot4.floorID == slot2 then
				return 0
			end

			return slot6:GetGiftNum(slot2)
		elseif slot7 == 3 then
			if slot4.wall == slot2 or slot4.floorID == slot2 then
				return 0
			else
				return 1
			end
		end
	end
end

function slot0.ReviseFurNumInEditRoom(slot0, slot1, slot2)
	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot1] then
		uv0[slot1] = 0
	end

	uv0[slot1] = uv0[slot1] + slot2
end

function slot0.ClearFurNumInEditRoom(slot0)
	uv0 = nil
end

function slot0.RestoreRoomAllFurniture(slot0)
	uv0 = {}

	for slot6 = 0, uv1[DormData:GetCurrectSceneID()].roomInfo.furnitureInfoS.Length - 1 do
		if not uv0[slot2[slot6].id] then
			uv0[slot7.id] = 0
		end

		uv0[slot7.id] = uv0[slot7.id] - 1
	end
end

function slot0.GetCacheFurTotalNum(slot0)
	slot1 = 0

	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if not DormTools:JudgeFurType(slot5) then
				slot1 = slot1 + slot6
			end
		end
	end

	return slot1
end

function slot0.GetCacheFurNumInfo(slot0)
	if uv0 then
		return uv0
	end
end

slot13, slot14 = nil

function slot0.GetCacheFurNum(slot0, slot1)
	if uv0 then
		return uv0[slot1] or 0
	end

	return 0
end

function slot0.GetEditCurFloorOrWall(slot0, slot1)
	slot3 = uv0[DormData:GetCurrectSceneID()]

	if slot1 == DormConst.FLOOR_TYPE_NUM then
		return uv1 or slot3.floorID
	else
		return uv2 or slot3.wallID
	end
end

function slot0.CacheWallAndFloorInfo(slot0, slot1, slot2)
	if slot1 then
		uv0 = slot1
	end

	if slot2 then
		uv1 = slot2
	end
end

function slot0.GetCacheWallAndFloorInfo(slot0, slot1)
	if slot1 == DormConst.FLOOR_TYPE_NUM then
		return uv0
	elseif slot1 == DormConst.WALL_TYPE_NUM then
		return uv1
	end
end

function slot0.ClearCacheWallAndFloor(slot0)
	uv0 = nil
	uv1 = nil
end

function slot0.SaveWallAndFloorInfo(slot0)
	slot1 = DormData:GetCurrectSceneID()
	slot2 = {}

	if uv0 then
		table.insert(slot2, uv0)

		uv0 = nil
	else
		table.insert(slot2, uv1[slot1].floorID)
	end

	if uv2 then
		table.insert(slot2, uv2)

		uv2 = nil
	else
		table.insert(slot2, uv1[slot1].wallID)
	end

	return slot2
end

function slot0.SyncRoomFloorAndWall(slot0, slot1)
	if uv0[DormData:GetCurrectSceneID()] then
		for slot6, slot7 in ipairs(slot1) do
			if DormTools:JudgeFurType(slot7.furniture_id) then
				if BackHomeFurniture[slot8].type == DormConst.FLOOR_TYPE_NUM then
					uv0[slot2].floorID = slot8
				elseif BackHomeFurniture[slot8].type == DormConst.WALL_TYPE_NUM then
					uv0[slot2].wallID = slot8
				end
			end
		end
	end

	DormData:RefreshWallAndFloorNumList(DormEnum.DormSystemType.Dormitory)
end

function slot0.RestoreWallAndFloor(slot0)
	slot0:ClearCacheWallAndFloor()

	slot1 = DormData:GetCurrectSceneID()
	slot2 = BackHomeCfg[slot1].type
	slot3 = DormitoryData:GetOriFloorOrWall(slot2, DormConst.WALL_TYPE_NUM)

	DormTools:ChangeDormFloorOrWall(slot3)
	DormTools:ChangeDormFloorOrWall(DormitoryData:GetOriFloorOrWall(slot2, DormConst.FLOOR_TYPE_NUM))

	if slot3 ~= DormitoryData:GetDormSceneData(slot1).wallID then
		DormitoryData:ReviseFurNumInEditRoom(slot5.wallID, -1)
		DormitoryData:CacheWallAndFloorInfo(nil, slot3)
	end

	if slot4 ~= slot5.floorID then
		DormitoryData:ReviseFurNumInEditRoom(slot5.floorID, -1)
		DormitoryData:CacheWallAndFloorInfo(slot4, nil)
	end
end

function slot0.InitTemplateDorm(slot0, slot1)
	uv0 = {}
	uv1 = slot1.exhibition_id or 0

	for slot5, slot6 in ipairs(slot1.template) do
		slot7 = {
			id = slot6.id,
			type = slot6.type,
			name = slot6.name,
			pos = slot6.pos
		}
		slot8 = {}

		DormData:AddFurnitureInfo(slot8, slot6.front_furnitures, DormConst.TILE_TYPE.WALL_FRONT)
		DormData:AddFurnitureInfo(slot8, slot6.back_furnitures, DormConst.TILE_TYPE.WALL_BEHIND)
		DormData:AddFurnitureInfo(slot8, slot6.left_furnitures, DormConst.TILE_TYPE.WALL_LEFT)
		DormData:AddFurnitureInfo(slot8, slot6.right_furnitures, DormConst.TILE_TYPE.WALL_RIGHT)
		DormData:AddFurnitureInfo(slot8, slot6.floor_furnitures, DormConst.TILE_TYPE.FLOOR)

		if slot6.floor_furnitures then
			for slot12, slot13 in ipairs(slot6.floor_furnitures) do
				if BackHomeFurniture[slot13.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
					slot7.floorID = slot13.furniture_id
				elseif BackHomeFurniture[slot13.furniture_id].type == DormConst.WALL_TYPE_NUM then
					slot7.wallID = slot13.furniture_id
				end
			end
		end

		slot9 = slot6.type

		if not slot7.floorID then
			slot7.floorID = slot0:GetOriFloorOrWall(slot9, DormConst.FLOOR_TYPE_NUM)
		end

		if not slot7.wallID then
			slot7.wallID = slot0:GetOriFloorOrWall(slot9, DormConst.WALL_TYPE_NUM)
		end

		slot10 = RoomInfo.New()
		slot10.furnitureInfoS = slot8
		slot7.furnitureInfoS = slot10.furnitureInfoS
		uv0[slot6.id] = DormRoomTemplate.New(slot7)
	end
end

function slot0.GetTemplateDorm(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7.type == slot1 then
			table.insert(slot2, slot6)
		end
	end
end

function slot0.GetTemplateTotalNum(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(uv0) do
		slot1 = slot1 + 1
	end

	return slot1
end

function slot0.GetDormTemplateInfo(slot0, slot1)
	if uv0 and uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.GetDormTemplateInfoByPosID(slot0, slot1, slot2)
	for slot6, slot7 in pairs(uv0) do
		if slot7.posID == slot1 and slot2 == slot7.type then
			return slot6
		end
	end
end

function slot0.DeleteDormTemplateInfo(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1]:Dispose()

		uv0[slot1] = nil
	else
		print("不存在家具模板信息")
	end
end

function slot0.SaveFurTemplateInfo(slot0, slot1)
	slot2 = nil
	slot2 = (slot1.architecture_id == 0 or uv0[slot3]) and uv0[DormData:GetCurrectSceneID()]

	if uv1[slot1.id] then
		slot5 = uv1[slot4]
		slot5.id = slot1.id
		slot5.type = slot1.type
		slot5.name = slot1.name
		slot5.posID = slot1.pos
		slot5.furnitureInfoS = slot2.roomInfo.furnitureInfoS
		slot5.floorID = slot2.floorID
		slot5.wallID = slot2.wallID
	else
		uv1[slot4] = DormRoomTemplate.New({
			id = slot1.id,
			type = slot1.type,
			name = slot1.name,
			pos = slot1.pos,
			furnitureInfoS = slot2.roomInfo.furnitureInfoS,
			floorID = slot2.floorID,
			wallID = slot2.wallID
		})
	end
end

function slot0.RefreshTemplateExhibit(slot0, slot1, slot2)
	uv0[slot2] = {}

	for slot6, slot7 in ipairs(slot1) do
		while true do
			if slot7.architecture_id == 0 then
				break
			end

			slot11 = slot7.furniture_num
			uv0[slot2][slot7.user_id] = {
				nick = slot7.nick,
				level = slot7.level,
				icon = slot7.icon,
				architecture_id = slot7.architecture_id,
				furniture_num = slot11,
				heroIDList = {}
			}

			for slot11, slot12 in ipairs(slot7.hero_id_list) do
				table.insert(uv0[slot2][slot7.user_id].heroIDList, slot12)
			end

			break
		end
	end
end

function slot0.GetTemplateExhibitList(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot1] then
		DormAction:AskFurTemplateExhibitList(slot1)
	else
		return uv0[slot1]
	end
end

function slot0.GetExhibitListByUserID(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		for slot10, slot11 in pairs(slot6) do
			if slot1 == slot10 then
				return slot11, slot5
			end
		end
	end
end

function slot0.RefreshCurTemplateExhibit(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot2 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot4 = DormConst.DORM_VISIT_LOBBY
	elseif slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot4 = DormConst.DORM_VISIT_PRIVATE
	end

	uv0[slot4] = {
		roomInfo = RoomInfo.New()
	}
	uv0[slot4].roomInfo.id = slot4
	uv0[slot4].roomInfo.sceneName = BackHomeCfg[slot4].scene
	slot6 = {}

	DormData:AddFurnitureInfo(slot6, slot1.left_furnitures, DormConst.TILE_TYPE.WALL_LEFT)
	DormData:AddFurnitureInfo(slot6, slot1.right_furnitures, DormConst.TILE_TYPE.WALL_RIGHT)
	DormData:AddFurnitureInfo(slot6, slot1.front_furnitures, DormConst.TILE_TYPE.WALL_FRONT)
	DormData:AddFurnitureInfo(slot6, slot1.back_furnitures, DormConst.TILE_TYPE.WALL_BEHIND)
	DormData:AddFurnitureInfo(slot6, slot1.floor_furnitures, DormConst.TILE_TYPE.FLOOR)

	if slot1.floor_furnitures then
		for slot10, slot11 in ipairs(slot1.floor_furnitures) do
			if BackHomeFurniture[slot11.furniture_id].type == DormConst.FLOOR_TYPE_NUM then
				uv0[slot4].floorID = slot11.furniture_id
			elseif BackHomeFurniture[slot11.furniture_id].type == DormConst.WALL_TYPE_NUM then
				uv0[slot4].wallID = slot11.furniture_id
			end
		end
	end

	slot7 = nil

	if slot4 == DormConst.DORM_VISIT_LOBBY then
		slot7 = DormConst.BACKHOME_TYPE.PublicDorm
	elseif slot4 == DormConst.DORM_VISIT_PRIVATE then
		slot7 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	if not uv0[slot4].floorID then
		uv0[slot4].floorID = slot0:GetOriFloorOrWall(slot7, DormConst.FLOOR_TYPE_NUM)
	end

	if not uv0[slot4].wallID then
		uv0[slot4].wallID = slot0:GetOriFloorOrWall(slot7, DormConst.WALL_TYPE_NUM)
	end

	uv0[slot4].archiveIDList = slot0:GetExhibitListByUserID(slot3).heroIDList
	uv0[slot4].roomInfo.furnitureInfoS = slot6
end

function slot0.SetCurTemplateExhibit(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCurTemplateExhibit(slot0)
	if uv0 then
		return uv0
	end

	print("没有展示宿舍id")
end

slot15 = nil

function slot0.SetCurVisitUserID(slot0, slot1)
	if slot1 then
		uv0 = slot1
	end
end

function slot0.GetCurVisitHeroList(slot0)
	if uv0 then
		return slot0:GetExhibitListByUserID(uv0).heroIDList
	else
		print("未找到参观用户ID")
	end
end

function slot0.GetCurVisitPlayerType(slot0)
	if uv0 then
		slot1, slot2 = slot0:GetExhibitListByUserID(uv0)

		return slot2
	else
		print("未找到参观用户ID")
	end
end

function slot0.GetVisitUserID(slot0)
	slot1 = nil

	if uv0 then
		return uv0
	end
end

function slot0.ClearVisitRoomData(slot0)
	if uv0[DormConst.DORM_VISIT_LOBBY] then
		uv0[DormConst.DORM_VISIT_LOBBY] = nil
	end

	if uv0[DormConst.DORM_VISIT_PRIVATE] then
		uv0[DormConst.DORM_VISIT_PRIVATE] = nil
	end

	uv1 = nil
end

function slot0.GetDormLevelAward(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8 = slot2 + 1, slot3 do
		for slot15, slot16 in ipairs(BackHomeHeroCfg[DormData:GetHeroInfo(slot1).canUseHero[1]].level_reward[slot8]) do
			if BackHomeDormLevelRewardCfg[slot16].type == 3 then
				table.insert(slot4, slot17.reward)
			end
		end
	end

	getReward(mergeReward(slot4))
end

function slot0.UpdataDormRedPoint(slot0, slot1)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	if slot1 == false then
		manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 0)

		slot4 = {}

		for slot8, slot9 in pairs(DormData:GetHeroInfoList()) do
			if GameSetting.dorm_hero_set_level.value[1] <= DormData:GetHeroInfo(slot8):GetHeroFavorability() then
				table.insert(slot4, slot8)
			end
		end

		saveData("RedPoint", RedPointConst.DORM_PLACEMENT, slot4)

		return
	end

	slot3 = getData("RedPoint", RedPointConst.DORM_PLACEMENT)
	slot5 = false

	for slot9, slot10 in pairs(DormData:GetHeroInfoList()) do
		if not DormitoryData:GetDormIDViaArchive(slot9) and GameSetting.dorm_hero_set_level.value[1] <= DormData:GetHeroInfo(slot9):GetHeroFavorability() then
			slot5 = true

			if slot3 then
				for slot16, slot17 in ipairs(slot3) do
					if slot9 == slot17 then
						slot5 = false

						break
					end
				end
			end
		end
	end

	slot6 = false

	for slot10, slot11 in pairs(uv0) do
		if BackHomeCfg[slot10].type == DormConst.BACKHOME_TYPE.PrivateDorm and (not slot11.archiveIDList or #slot11.archiveIDList == 0) then
			slot6 = true
		end
	end

	if slot5 and slot6 then
		manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 1)
	end
end

function slot0.UpdataDormFurRedPoint(slot0, slot1, slot2)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	slot4 = DormConst.DORM_FUR_TYPE_RED_POINT[slot2]

	if tostring((uv0[slot2] or {})[slot1]) == "userdata: NULL" then
		slot6 = {}
	end

	slot6 = slot6 or {}
	slot7 = DormData:GetRoomCanUseFurList(slot1)

	if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for slot11, slot12 in ipairs(slot7) do
			if BackHomeFurniture[slot12].type == slot2 then
				slot13 = DormData:GetFurNumInfo(slot12).num
				slot14 = 0

				for slot18, slot19 in ipairs(slot6) do
					if slot19.furID == slot12 then
						slot14 = slot19.num
					end
				end

				if slot14 < slot13 then
					manager.redPoint:setTip(slot4, 1)

					return
				end
			end
		end
	elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		for slot11, slot12 in ipairs(slot7) do
			if BackHomeFurniture[slot12].type == slot2 then
				slot13 = uv1[slot1].give_furnitures[slot12] or 0
				slot14 = 0

				for slot18, slot19 in ipairs(slot6) do
					if slot19.furID == slot12 then
						slot14 = slot19.num
					end
				end

				if slot14 < slot13 then
					manager.redPoint:setTip(slot4, 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(slot4, 0)
end

function slot0.CloseDormFurRedPoint(slot0, slot1, slot2, slot3)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		return
	end

	slot5 = DormConst.DORM_FUR_TYPE_RED_POINT[slot2]

	if tostring((uv0[slot2] or {})[slot1]) == "userdata: NULL" then
		slot7 = {}
	end

	slot7 = slot7 or {}

	if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for slot11, slot12 in ipairs(slot3) do
			slot13 = slot12.furID
			slot14 = false

			for slot18, slot19 in ipairs(slot7) do
				if slot19.furID == slot13 then
					slot19.num = DormData:GetFurNumInfo(slot13).num
					slot14 = true

					break
				end
			end

			if not slot14 then
				table.insert(slot7, {
					furID = slot13,
					num = DormData:GetFurNumInfo(slot13).num
				})
			end
		end
	elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		for slot11, slot12 in pairs(uv1[slot1].give_furnitures) do
			slot13 = false

			for slot17, slot18 in ipairs(slot7) do
				if slot18.furID == slot11 then
					slot18.num = slot12
					slot13 = true

					break
				end
			end

			if not slot13 then
				table.insert(slot7, {
					furID = slot11,
					num = slot12
				})
			end
		end
	end

	if not uv0[slot2] then
		uv0[slot2] = {}
	end

	uv0[slot2][slot1] = slot7

	manager.redPoint:setTip(slot5, 0)
end

slot16 = nil

function slot0.SetFloor(slot0, slot1)
	uv0 = slot1
end

function slot0.GetFloor(slot0)
	return uv0
end

slot17 = nil

function slot0.SetSelFurIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSelFurIndex(slot0)
	return uv0
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(uv0) do
		slot5:Dispose()
	end

	uv1 = {}

	for slot4, slot5 in pairs(uv2) do
		slot5.roomInfo = nil
		slot5.floorID = nil
		slot5.wallID = nil
		slot5.give_furnitures = nil
	end

	uv3 = nil
	uv4 = nil

	slot0:SaveFurPlaceRedPointData()
	slot0:SaveFurEditFlag()
	DormSkillData:Dispose()

	uv5 = manager.time:GetServerTime()

	SendMessageManagerToSDK("backhome_dorm_opt", {
		backhome_type = 0,
		opt_time = uv5 - uv6
	})

	uv6 = nil
	uv5 = nil
end

return slot0
