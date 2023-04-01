slot1 = nil
slot2 = nil
slot3 = nil
slot4 = nil
slot5 = nil
slot6, slot7 = nil

return {
	CheckToEnterDormScene = function (slot0, slot1)
		uv0 = slot1

		uv1:EnterDormMap(slot1)
	end,
	EnterDormMap = function (slot0, slot1)
		DormData:SetCurrentScene(slot1)
		StartDormMode(uv0:CreateDormDataForExchange(slot1))
	end,
	CreateDormDataForExchange = function (slot0, slot1)
		slot2 = GetDormDataForExcehange()
		slot3 = BackHomeCfg[slot1]
		slot2.sceneName = slot3.scene
		slot2.dormMapCfg = BackHomeCfg.AllMapCfg

		if slot3.type == 4 then
			slot2.sceneType = 2
		elseif slot3.type == 5 then
			slot2.sceneType = 3
		else
			slot2.sceneType = slot3.type
		end

		slot2.furnitureConfigs = BackHomeFurniture.AllFurnitureConfig
		slot2.mapFurnitureInfoS = RoomInfo.New()
		slot2.mapFurnitureInfoS.id = slot1
		slot2.mapFurnitureInfoS.sceneName = slot3.scene
		slot2.mapFurnitureInfoS.furnitureInfoS = DormData:GetDormSceneData(slot1).roomInfo.furnitureInfoS

		return slot2
	end,
	ChangeDormScene = function (slot0, slot1, slot2)
		DormData:SetCurrentScene(slot1)
		ChangeDormSceneLua(uv0:CreateDormDataForExchange(slot1), slot2)
	end,
	EnterDormMap2 = function (slot0)
		slot1 = GetDormDataForExcehange()
		slot1.sceneName = slot0
		slot1.dormMapCfg = BackHomeCfg.AllMapCfg
		slot1.furnitureConfigs = BackHomeFurniture.AllFurnitureConfig

		StartDormMode(slot1)
	end,
	GetDormDetialInfo = function (slot0)
		manager.net:SendWithLoadingNew(39002, {
			nothing = 1
		}, 39003, uv0.GetDormDetialInfoCallBack)
	end,
	GetDormDetialInfoCallBack = function (slot0)
		DormData:InitFurnitureInfoList(slot0.furnitures)
		DormitoryData:InitTemplateDorm(slot0)
		DormitoryData:InitDormMap(slot0.dorms)

		if DormData:GetCurrectSceneID() and BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			DormAction:CheckToEnterDormScene(slot1)
		else
			DormAction:CheckToEnterDormScene(DormConst.PUBLIC_DORM_ID)
		end
	end,
	SetFurListInMap = function (slot0, slot1, slot2, slot3)
		if slot2 == nil then
			uv0 = slot3
			slot4 = {
				architecture_id = slot1,
				furniture_layout = {
					temp_id = 0,
					left_furnitures = {},
					right_furnitures = {},
					front_furnitures = {},
					back_furnitures = {},
					floor_furnitures = {}
				}
			}

			for slot8 = 0, slot3.Length - 1 do
				slot9 = {
					furniture_id = slot3[slot8].id,
					x = math.floor(slot3[slot8].pos.x * DormConst.POS_PRECISION),
					y = math.floor(slot3[slot8].pos.y * DormConst.POS_PRECISION),
					rotation = math.floor(slot3[slot8].rotation * DormConst.POS_PRECISION)
				}

				if slot3[slot8].tileType == DormConst.TILE_TYPE.FLOOR then
					table.insert(slot4.furniture_layout.floor_furnitures, slot9)
				elseif slot3[slot8].tileType == DormConst.TILE_TYPE.WALL_LEFT then
					table.insert(slot4.furniture_layout.left_furnitures, slot9)
				elseif slot3[slot8].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
					table.insert(slot4.furniture_layout.right_furnitures, slot9)
				elseif slot3[slot8].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
					table.insert(slot4.furniture_layout.back_furnitures, slot9)
				elseif slot3[slot8].tileType == DormConst.TILE_TYPE.WALL_FRONT then
					table.insert(slot4.furniture_layout.front_furnitures, slot9)
				end
			end

			for slot9, slot10 in ipairs(DormitoryData:SaveWallAndFloorInfo()) do
				table.insert(slot4.furniture_layout.floor_furnitures, {
					rotation = 0,
					x = 0,
					y = 0,
					furniture_id = slot10
				})
			end

			manager.net:SendWithLoadingNew(39010, slot4, 39011, uv1.SetFurListInMapCallBack)
		else
			manager.net:SendWithLoadingNew(39010, {
				architecture_id = slot1,
				furniture_layout = {
					temp_id = slot2,
					left_furnitures = {},
					right_furnitures = {},
					front_furnitures = {},
					back_furnitures = {},
					floor_furnitures = {}
				}
			}, 39011, uv1.SetFurListInMapCallBack)
		end
	end,
	SetFurListInMapCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:ClearCacheWallAndFloor()

			slot2 = nil

			if not uv0 then
				slot4 = DormitoryData:GetDormTemplateInfo(slot1.furniture_layout.temp_id)
				uv0 = slot4:GetDormTemplateFurList()
				slot5 = slot4:GetTemplateWallAndFloorInfo()
				slot2 = {}

				table.insert(slot2, {
					furniture_id = slot5.floorID
				})
				table.insert(slot2, {
					furniture_id = slot5.wallID
				})
			end

			DormitoryData:SyncRoomFurniture(slot1, uv0, slot2)
			DormLuaBridge.SyncRoomFurniture(uv0)
			manager.notify:Invoke(DORM_SET_FUR_SUCCESSFUL)

			uv0 = nil
		else
			print("设置家具失败")
		end
	end,
	UnLockDormArchitecture = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(39030, {
			architecture_id = slot1,
			pos_id = slot2
		}, 39031, uv0.UnLockDormArchitectureCallBack)
	end,
	UnLockDormArchitectureCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot6 = slot1.pos_id

			DormitoryData:UnLockDormArchitecture(slot1.architecture_id, slot6)

			for slot6, slot7 in ipairs(BackHomeCfg[slot1.architecture_id].unlock_cost) do
				if slot7 then
					MaterialData:ModifyNum(slot7[1], -slot7[2])
				end
			end

			manager.notify:Invoke(DORM_PRIVATE_DORM_CHANGE, slot1.architecture_id)
		else
			print("解锁宿舍场景失败")
		end
	end,
	DeployHeroInRoom = function (slot0, slot1, slot2, slot3)
		uv0 = slot3
		slot4 = {}

		for slot8, slot9 in ipairs(slot2) do
			table.insert(slot4, slot9)
		end

		manager.net:SendWithLoadingNew(39032, {
			architecture_id = slot1,
			hero_id = slot4
		}, 39033, uv1.DeployHeroInRoomCallBack)
	end,
	DeployHeroInRoomCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormData:RefreshInDormHeroInfo(slot1.architecture_id, slot1.hero_id)

			if uv0 == DormEnum.DormDeployType.Place then
				manager.notify:Invoke(DORM_DRAG_HERO_SUCCESS)
				manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
			elseif uv0 == DormEnum.DormDeployType.ReCall then
				DormTools:ReGenerateDormHeroEntity()
				manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
			elseif uv0 == DormEnum.DormDeployType.Occupy then
				slot3 = DormData:GetHeroArchiveID(slot1.hero_id[1])

				DormitoryData:SetDormIDViaArchive(slot3, slot1.architecture_id)
				DormitoryData:GetDormLevelAward(slot3, 0, 1)
				manager.notify:Invoke(DORM_HERO_OCCUPY, {
					slot3
				})
			end

			uv0 = nil
		else
			print("配置角色到场景中失败")
		end
	end,
	RecallHeroInPrivateDorm = function (slot0, slot1)
		manager.net:SendWithLoadingNew(39034, {
			architecture_id = slot1
		}, 39035, uv0.RecallHeroInPrivateDormCallBack)
	end,
	RecallHeroInPrivateDormCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot3 = DormitoryData:GetDormMapList()[slot1.architecture_id].archiveIDList[1]
			slot4 = 0

			for slot8, slot9 in ipairs(BackHomeCfg.all) do
				if BackHomeCfg[slot9].type == DormConst.BACKHOME_TYPE.PublicDorm then
					slot4 = slot9

					break
				end
			end

			for slot9 = 1, #DormitoryData:GetDormSceneData(slot4).archiveIDList do
				if slot5.archiveIDList[slot9] == slot3 then
					table.remove(slot5.archiveIDList, slot9)

					break
				end
			end

			DormData:GetHeroInfo(slot3):ResetHeroSkill()
			manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
		else
			print("召回角色失败")
		end
	end,
	GiftFurToHero = function (slot0, slot1, slot2, slot3)
		slot4 = {}
		uv0 = slot3

		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, {
				id = slot8,
				num = slot9
			})
		end

		manager.net:SendWithLoadingNew(39036, {
			hero_id = slot1,
			furniture = slot4
		}, 39037, uv1.GiftFurToHeroCallBack)
	end,
	GiftFurToHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.hero_id
			slot3 = DormData:GetHeroTemplateInfo(slot2)
			slot4 = DormitoryData:GetDormIDViaArchive(slot2)

			for slot8, slot9 in ipairs(slot1.furniture) do
				slot3.GiftFur(slot3, slot9.id, slot9.num, uv0)
			end

			uv0 = nil

			if not slot4 then
				Debug.LogError("未获取到场景id")

				return
			end

			manager.notify:Invoke(DORM_REFRESH_GIFT_FUR_LIST)
			DormitoryData:RefreshDormExp(slot4)

			if DormitoryData:GetDormLevel(slot4) ~= DormitoryData:GetDormLevel(slot4) then
				DormitoryData:GetDormLevelAward(slot2, slot5, slot6)
				manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, slot4, slot2)
			end
		else
			print("赠送家具失败")
		end
	end,
	GiftFoodToHero = function (slot0, slot1, slot2)
		uv0 = slot2

		manager.net:SendWithLoadingNew(39038, {
			hero_id = slot1
		}, 39039, uv1.GiftFoodToHeroCallBack)
	end,
	GiftFoodToHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormData:GetHeroTemplateInfo(slot1.hero_id):FeedFood(uv0)

			uv0 = nil

			manager.notify:Invoke(DORM_FEED_FOOD_HERO)
		else
			print("投食失败")
		end
	end,
	SaveFurTemplate = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
		slot9 = {
			id = slot1,
			type = slot2,
			name = slot3,
			architecture_id = slot4,
			left_furnitures = {},
			right_furnitures = {},
			front_furnitures = {},
			back_furnitures = {},
			floor_furnitures = {},
			pos = slot6
		}

		if slot4 == 0 or slot4 > 1000 then
			slot9.architecture_id = 0
			slot9.left_furnitures, slot9.right_furnitures, slot9.back_furnitures, slot9.front_furnitures, slot9.floor_furnitures = slot0.SwitchFurInfoToLayout(slot0, slot5)

			if slot7 then
				table.insert(slot9.floor_furnitures, {
					rotation = 0,
					x = 0,
					y = 0,
					furniture_id = slot7
				})
			end

			if slot8 then
				table.insert(slot9.floor_furnitures, {
					rotation = 0,
					x = 0,
					y = 0,
					furniture_id = slot7
				})
			end
		end

		manager.net:SendWithLoadingNew(39040, slot9, 39041, uv0.SaveFurTemplateCallBack)
	end,
	SwitchFurInfoToLayout = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}
		slot5 = {}
		slot6 = {}

		for slot10 = 0, slot1.Length - 1 do
			slot11 = {
				furniture_id = slot1[slot10].id,
				x = math.floor(slot1[slot10].pos.x * DormConst.POS_PRECISION),
				y = math.floor(slot1[slot10].pos.y * DormConst.POS_PRECISION),
				rotation = math.floor(slot1[slot10].rotation * DormConst.POS_PRECISION)
			}

			if slot1[slot10].tileType == DormConst.TILE_TYPE.FLOOR then
				table.insert(slot6, slot11)
			elseif slot1[slot10].tileType == DormConst.TILE_TYPE.WALL_LEFT then
				table.insert(slot2, slot11)
			elseif slot1[slot10].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
				table.insert(slot3, slot11)
			elseif slot1[slot10].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
				table.insert(slot4, slot11)
			elseif slot1[slot10].tileType == DormConst.TILE_TYPE.WALL_FRONT then
				table.insert(slot5, slot11)
			end
		end

		return slot2, slot3, slot4, slot5, slot6
	end,
	SaveFurTemplateCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:SaveFurTemplateInfo(slot1)
			manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
			ShowTips(GetTips("DORM_MOULD_SAVE_SUCCESS"))
		else
			print("保存模板失败失败")
		end
	end,
	ReviseFurTemplateName = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(39042, {
			id = slot1,
			name = slot2
		}, 39043, uv0.ReviseFurTemplateNameCallBack)
	end,
	ReviseFurTemplateNameCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:GetDormTemplateInfo(slot1.id):ReviseFurTemplateNameInfo(slot1.name)
			manager.notify:Invoke(DOMR_RENAME_TEMPLATE_SUCCESS)
		else
			print("修改家具模板名称失败")
		end
	end,
	DeleteFurTemplate = function (slot0, slot1)
		manager.net:SendWithLoadingNew(39044, {
			id = slot1
		}, 39045, uv0.DeleteFurTemplateCallBack)
	end,
	DeleteFurTemplateCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:DeleteDormTemplateInfo(slot1.id)
			manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
		else
			print("删除家具模板失败")
		end
	end,
	RevisePrivateDormPos = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, {
				architecture_id = slot7.roomID,
				pos_id = slot7.posID
			})
		end

		manager.net:SendWithLoadingNew(39046, {
			dorm_pos_list = slot2
		}, 39047, uv0.RevisePrivateDormPosCallBack)
	end,
	RevisePrivateDormPosCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:RevisePrivateDormPosData(slot1)
		else
			print("修改私人宿舍位置失败")
		end
	end,
	AskFurTemplateExhibitList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(39048, {
			type = slot1
		}, 39049, uv0.AskFurTemplateExhibitListCallBack)
	end,
	AskFurTemplateExhibitListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:RefreshTemplateExhibit(slot0.exhibition_brief, slot1.type)
			manager.notify:Invoke(DORM_REFRESH_TEMPLATE_EXHI, #slot0.exhibition_brief)
		else
			print("请求查看展览宿舍场景列表失败")
		end
	end,
	AskSingleFurTemplateExhibit = function (slot0, slot1, slot2)
		uv0 = slot2
		uv1 = slot1

		manager.net:SendWithLoadingNew(39050, {
			user_id = slot1
		}, 39051, uv2.AskSingleFurTemplateExhibitCallBack)
	end,
	AskSingleFurTemplateExhibitCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:RefreshCurTemplateExhibit(slot0, uv0, uv1)

			if uv0 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
				uv2:CheckToEnterDormScene(DormConst.DORM_VISIT_LOBBY)
			elseif uv0 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
				uv2:CheckToEnterDormScene(DormConst.DORM_VISIT_PRIVATE)
			end

			uv0 = nil
			uv1 = nil
		else
			print("请求查看单个展览场景详情失败")
		end
	end,
	SetFurTemplateExhibit = function (slot0, slot1)
		manager.net:SendWithLoadingNew(39052, {
			architecture_id = slot1
		}, 39053, uv0.SetFurTemplateExhibitCallBack)
	end,
	SetFurTemplateExhibitCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:SetCurTemplateExhibit(slot1.architecture_id)
			manager.notify:Invoke(DORM_REFRESH_EXIBIT)
		else
			print("设置展览场景失败")
		end
	end
}
