slot1 = nil
slot2 = manager.net

slot2:Bind(58001, function (slot0)
	DormData:InitHeroInfo(slot0.backhome_hero, slot0.last_fatigue_update_time)
	DormitoryData:InitDormInfo(slot0.dorm)
	CanteenData:InitCanteenInfo(slot0.canteens)
	CanteenData:InitFurnitureLevel(slot0.canteen_furnitures)
	CanteenData:InitCanteenIngredient(slot0.ingredients)
	CanteenData:UpdateCanteenNotify()
end)

slot2 = manager.net

slot2:Bind(58023, function (slot0)
	slot4 = slot0

	CanteenData:RefreshAutoAwardInfo(slot4)

	for slot4, slot5 in ipairs(slot0.del_ingredients) do
		CanteenData:ReduceFoodIngredients(slot5.id, slot5.num)
	end

	for slot4, slot5 in ipairs(slot0.fatigue_list) do
		if slot5 then
			DormData:SetHeroFatigue(slot5.archives_id, slot5.fatigue)
		end
	end

	for slot4, slot5 in ipairs(slot0.signature_dish) do
		if slot5 then
			CanteenData:ReviseSignFoodInfo(slot5)
		end
	end

	for slot4, slot5 in ipairs(slot0.food) do
		if slot5 then
			CanteenData:UpdataFoodProficiency(slot5)
		end
	end

	CanteenData:UpdateCanteenNotify()
end)

slot2 = manager.net

slot2:Bind(58027, function (slot0)
	for slot4, slot5 in ipairs(slot0.fatigue_list) do
		if DormData:GetHeroInfo(slot5.archives_id) then
			slot7:SetFatigue(slot5.fatigue)
		end
	end
end)

return {
	SendTaskDispatchInfo = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		if slot3 == nil then
			slot4 = nil
		else
			for slot8, slot9 in ipairs(slot3) do
				table.insert(slot4, slot9)
			end
		end

		manager.net:SendWithLoadingNew(58002, {
			architecture_id = slot1,
			pos = slot2,
			hero_list = slot4
		}, 58003, uv0.OnSolveTaskDispatchCallBack)
	end,
	OnSolveTaskDispatchCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenData:ConfirmEntrustListCallBack(slot1)
		else
			print("委托派遣失败")
			CanteenData:RemoveCurEntrustCharacterList()
		end
	end,
	SetCharacterJob = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58004, {
			architecture_id = DormConst.CANTEEN_ID,
			type = slot1,
			hero_id = slot2[1]
		}, 58005, uv0.OnSetCharacterJobCallBack)
	end,
	OnSetCharacterJobCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(DormData:GetArchiveIDByJobType(slot1.type)) do
				slot8 = DormData:GetHeroInfo(slot7)
				slot8.jobType = nil

				slot8:BackToDorm()
			end

			if slot1.hero_id > 0 then
				slot3 = slot1.hero_id
				slot4 = DormData:GetHeroTemplateInfo(slot3)

				slot4:SetCurHeroID(slot3)
				slot4:SetJob(slot1.type)
				slot4:GoToCanteen()
			end

			DormData:RefreshCanteenJobList()

			slot3 = DormEnum.RestaurantJobToClientMap[slot1.type]

			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close or CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Start then
				manager.notify:Invoke(DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE, slot3)
			elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
				manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
			end

			manager.notify:Invoke(CANTEEN_SET_JOG_SUCCESS)
		else
			print("设置打工人失败")
		end
	end,
	ReceiveCanteenAutoAward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58006, {
			architecture_id = slot1
		}, 58007, uv0.OnCanteenAutoAwardCallBack)
	end,
	OnCanteenAutoAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenData:ReceiveAutoEarSuccess(slot0.earnings)
		else
			print("领取自动奖励失败")
		end
	end,
	ChangeCanteenMode = function (slot0, slot1, slot2)
		slot3 = nil

		if slot2 == DormEnum.RestaurantMode.RestaurantAuto then
			slot3 = 0
		elseif slot2 == DormEnum.RestaurantMode.RestaurantManual then
			slot3 = 1
		end

		if slot3 then
			manager.net:SendWithLoadingNew(58008, {
				architecture_id = slot1,
				cmd = slot3
			}, 58009, uv0.ChangeCanteenModeCallBack)
		end
	end,
	ChangeCanteenModeCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			if slot1.cmd == 0 then
				slot2 = DormEnum.RestaurantMode.RestaurantAuto
			elseif slot1.cmd == 1 then
				slot2 = DormEnum.RestaurantMode.RestaurantManual
			end

			CanteenData:ChangeCanteenStateSusscee(slot2)
		else
			print("切换模式失败")
		end
	end,
	GetCanteenDetailInfo = function (slot0)
		manager.net:SendWithLoadingNew(58010, {
			nothing = 1
		}, 58011, uv0.GetCanteenDetailInfoCallBack)
	end,
	GetCanteenDetailInfoCallBack = function (slot0)
		if isSuccess(slot0.result) then
			CanteenData:InitCanteenMapData(slot0)
			CanteenData:InitCanteenIngredient(slot0.ingredients)
			CanteenData:InitFoodProficiency(slot0.food)
			DormAction:CheckToEnterDormScene(DormConst.CANTEEN_ID)
			CanteenData:UpdateCanteenNotify()
		else
			print("获取餐厅详情失败")
		end
	end,
	RefreshEntrust = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58012, {
			architecture_id = slot1,
			pos = slot2
		}, 58013, uv0.RefreshEntrustCallBack)
	end,
	RefreshEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {
				refresh_times = 1,
				pos = slot0.entrust.pos,
				id = slot0.entrust.id,
				hero_list = {},
				tags = {},
				start_time = slot0.entrust.start_time
			}

			for slot6, slot7 in ipairs(slot0.entrust.hero_list) do
				table.insert(slot2.hero_list, slot7)
			end

			for slot6, slot7 in ipairs(slot0.entrust.tags) do
				table.insert(slot2.tags, slot7)
			end

			CanteenData:RefreshSingleEntrust(slot2)
			manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, slot2.pos)
		else
			print("刷新委托失败")
		end
	end,
	SendSignFoodInfo = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58014, {
			architecture_id = DormConst.CANTEEN_ID,
			food_id = slot1,
			sell_num = slot2
		}, 58015, uv0.SetSignFoodCallBack)
	end,
	SetSignFoodCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if slot1.sell_num > 0 then
				CanteenData:PushFoodToSignList(slot1.food_id, slot1.sell_num)
			else
				CanteenData:RemoveChooseFoodList(slot1.food_id)
			end

			CanteenData:RefreshCanOrderFoodList()
			manager.notify:Invoke(CANTEEN_SET_SIGNFOOD_SUCCESS)
		else
			print("招牌菜设置失败")
		end
	end,
	CanteenFurnitureUpgrade = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58016, {
			uid = slot1
		}, 58017, uv0.CanteenFurnitureUpgradeCallBack)
	end,
	CanteenFurnitureUpgradeCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenData:FurLevelUpCallBack(slot1.uid)
			DormSkillData:CalCanSignFoodNum()
			DormSkillData:CalInComeStorageMaxNum()
			manager.notify:Invoke(CANTEEN_FUR_LEVEL_UP)
		else
			print("家具升级失败")
		end
	end,
	ReceiveEntrustAward = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3, slot8)
		end

		manager.net:SendWithLoadingNew(58018, {
			architecture_id = slot1,
			pos = slot3
		}, 58019, uv0.ReceiveEntrustAwardCallBack)
	end,
	ReceiveEntrustAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot6, slot7 in ipairs(slot0.extra_reward) do
				table.insert(slot2, {
					pos = slot7.pos,
					extra_reward = slot7.extra_reward
				})
			end

			slot3 = {}

			if slot0.entrust then
				for slot7, slot8 in ipairs(slot0.entrust) do
					slot9 = {
						pos = slot8.pos,
						id = slot8.id,
						hero_list = {},
						tags = {},
						num_max = slot8.num_max,
						refresh_times = slot8.refresh_times,
						start_time = slot8.start_time
					}

					for slot13, slot14 in ipairs(slot8.hero_list) do
						table.insert(slot9.hero_list, slot14)
					end

					for slot13, slot14 in ipairs(slot8.tags) do
						table.insert(slot9.tags, slot14)
					end

					table.insert(slot3, slot9)
				end
			end

			CanteenData:EntrustEndDeductFatigue(slot1.pos)

			slot7 = CANTEEN_DISPATCH_REWARD_SUCCESS
			slot8 = slot1

			manager.notify:Invoke(slot7, slot8, slot2)

			for slot7, slot8 in ipairs(slot3) do
				CanteenData:RefreshSingleEntrust(slot8)
			end
		else
			print("领取奖励失败")
		end
	end,
	CanteenManualSettlement = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, {
				food_id = slot8.food_id,
				quality = slot8.quality,
				guest_uid = slot8.guest_uid,
				guest_id = slot8.guest_id,
				special_event = slot8.special_event,
				evaluate = slot8.evaluate
			})
		end

		manager.net:SendWithLoadingNew(58020, {
			architecture_id = slot1,
			oper_list = slot3
		}, 58021, uv0.CanteenManualSettlementCallBack)
	end,
	CanteenManualSettlementCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot5 = CANTEEN_MANUAL_REWARD_CALLBACK

			manager.notify:Invoke(slot5)

			for slot5, slot6 in ipairs(slot1.oper_list) do
				CanteenData:AddFoodProficiency(slot6.food_id, slot6.quality)
			end
		else
			print("手动模式结算失败")
		end
	end,
	UnLockEntrust = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58024, {
			pos = slot1
		}, 58025, uv0.UnLockEntrustCallBack)
	end,
	UnLockEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {
				pos = slot3.pos,
				id = slot3.id,
				hero_list = {}
			}
			slot3 = slot0.entrust

			for slot7, slot8 in ipairs(slot3.hero_list) do
				table.insert(slot2.hero_list, slot8)
			end

			slot2.tags = {}

			for slot7, slot8 in ipairs(slot3.tags) do
				table.insert(slot2.tags, {
					type = slot8.type,
					tag = slot8.tag
				})
			end

			slot2.num_max = slot3.num_max
			slot2.refresh_times = slot3.refresh_times
			slot2.start_time = slot3.start_time

			CanteenData:RefreshSingleEntrust(slot2)
			manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, slot2.pos)
		else
			print("解锁委托栏失败")
		end
	end
}
