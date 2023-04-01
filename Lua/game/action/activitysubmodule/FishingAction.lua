slot1 = false
slot2 = manager.notify

slot2:RegistListener(RARE_FISH_CHANGE, function (slot0)
	uv0.CheckGroupRewardRedPoint()
end)

return {
	CheckReceiveRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.FISHING_RECEIVE_REWARD, #FishingData:GetFishReceiveInfo() > 0 and 1 or 0)
	end,
	CheckScoreRewardRedPoint = function ()
		slot0 = nil

		if FishingData:GetActivityData() then
			slot0 = slot1.score
		end

		slot2 = false
		slot6 = ActivityConst.SUMMER_FISHING

		for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot6]) do
			if ActivityPointRewardCfg[slot7].need <= slot0 then
				if not table.indexof(FishingData:GetActivityData().received_award_list, slot8.id) then
					slot2 = true

					break
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.FISHING_SCORE_REWARD, slot2 and 1 or 0)
	end,
	CheckGroupRewardRedPoint = function ()
		slot0 = false

		for slot4, slot5 in ipairs(ActivitySummerFishGroupCfg.all) do
			slot6 = true

			for slot11, slot12 in ipairs(ActivitySummerFishGroupCfg[slot5].group[1]) do
				slot13 = nil

				if not (FishingData:GetActivityData().fish_infos[slot12] and slot14.num > 0 and true or false) then
					slot6 = false

					break
				end
			end

			if table.indexof(FishingData:GetActivityData().received_constitute_list, slot7.id) then
				-- Nothing
			elseif slot6 then
				slot0 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.FISHING_GROUP_REWARD, slot0 and 1 or 0)
	end,
	ReadUnFinishRedPoint = function ()
		saveData("fishing", "unfinish", _G.gameTimer:GetNextDayFreshTime())
		uv0.CheckUnFinishRedPoint()
	end,
	CheckUnFinishRedPoint = function ()
		slot0 = getData("fishing", "unfinish")
		slot1, slot2 = nil
		slot3 = 0

		if FishingData:GetActivityData() then
			slot3 = slot4.score
		end

		slot1 = #FishingData:GetActivityData().received_award_list < #ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_FISHING]
		slot2 = #FishingData:GetActivityData().received_constitute_list < #ActivitySummerFishGroupCfg.all

		if slot0 ~= nil and manager.time:GetServerTime() < slot0 then
			manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 0)
		elseif slot2 or slot1 then
			manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 1)
		else
			manager.redPoint:setTip(RedPointConst.FISHING_NOT_FINISH, 0)
		end
	end,
	Init = function ()
		if uv0 then
			return
		end

		slot0 = manager.redPoint

		slot0:addGroup(RedPointConst.FISHING .. "_" .. ActivityConst.SUMMER_FISHING, {
			RedPointConst.FISHING_SCORE_REWARD,
			RedPointConst.FISHING_GROUP_REWARD,
			RedPointConst.FISHING_NOT_FINISH
		})

		slot0 = manager.net

		slot0:Bind(60001, function (slot0)
			FishingData:Reset()
			FishingData:InitFromServer(slot0.info)
			uv0.CheckScoreRewardRedPoint()
			uv0.CheckGroupRewardRedPoint()
			uv0.CheckUnFinishRedPoint()
		end)

		uv0 = true
	end,
	EndingFishing = function (slot0, slot1, slot2, slot3)
		slot5 = manager.net

		slot5:SendWithLoadingNew(60002, {
			info = {
				score = slot1,
				treasure = slot2
			},
			activity_id = slot0
		}, 60003, function (slot0, slot1)
			if isSuccess(slot0.result) then
				FishingData:OnFishingResult(slot0.result_score, slot0.fish_info, slot1.info.treasure)
				uv0.CheckScoreRewardRedPoint()

				if uv1 ~= nil then
					uv1(slot2, slot3)
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	UpdateRequest = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60004, {
			request_info = slot1,
			activity_id = slot0
		}, 60005, uv0.OnUpdateRequestCallback)
	end,
	OnUpdateRequestCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			FishingData:UpdateRequest(slot1.request_info)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetReceiveInfo = function (slot0, slot1)
		slot3 = manager.net

		slot3:SendWithLoadingNew(60006, {
			activity_id = slot0
		}, 60007, function (slot0, slot1)
			if isSuccess(slot0.result) then
				FishingData:OnReceiveInfoGet(slot0.fish_receive)
				uv0.CheckReceiveRedPoint()

				if uv1 ~= nil then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetFriendsFish = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60008, {
			activity_id = slot0,
			sender_id = slot1,
			timestamp = slot2
		}, 60009, uv0.OnGetFriendsFishCallback)
	end,
	OnGetFriendsFishCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			FishingData:OnReceiveFriendsFish(slot1.sender_id, slot1.timestamp, slot0.fish_info)
			uv0.CheckReceiveRedPoint()
			ShowTips("FISHING_RECEIVE_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	GiveRareFish = function (slot0, slot1, slot2, slot3)
		slot5 = manager.net

		slot5:SendWithLoadingNew(60010, {
			activity_id = slot0,
			fish_id = slot1,
			receiver_id = slot2
		}, 60011, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ShowTips("FISHING_GIVE_SUCCESS")
				FishingData:OnGiveComplete(slot1.receiver_id, slot1.fish_id, 1)

				if uv0 ~= nil then
					uv0()
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	GetBonus = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60012, {
			activity_id = slot0,
			award_id = slot1
		}, 60013, uv0.OnGetBonusCallback)
	end,
	OnGetBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			FishingData:OnGetScoreReward(slot1.award_id)
			uv0.CheckScoreRewardRedPoint()
			getReward(ActivityPointRewardCfg[slot1.award_id].reward_item_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetConstituteFishBonus = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60014, {
			activity_id = slot0,
			constitute_id = slot1
		}, 60015, uv0.OnConstituteFishCallback)
	end,
	OnConstituteFishCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			FishingData:OnGetGroupReward(slot1.constitute_id)
			uv0.CheckGroupRewardRedPoint()
			getReward(ActivitySummerFishGroupCfg[slot1.constitute_id].reward_item_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetFriendNeedFish = function (slot0, slot1)
		slot3 = manager.net

		slot3:SendWithLoadingNew(60016, {
			activity_id = slot0
		}, 60017, function (slot0, slot1)
			if isSuccess(slot0.result) then
				FishingData:OnFriendRequestFishInfoGet(slot0.friend_need_list)

				if uv0 ~= nil then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	FishingBuyFish = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60018, {
			activity_id = slot0,
			goods_id = slot1,
			num = slot2
		}, 60019, uv0.OnFishingBuyFishCallback)
	end,
	OnFishingBuyFishCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ShowTips("TRANSACTION_SUCCESS")
			CurrencyData:CurrencyModify(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN, -RareFishCfg[slot1.goods_id].price * slot1.num)
			FishingData:OnBuySuccess(slot1.goods_id, slot1.num, slot0.info[1])
			manager.notify:Invoke(FISHING_BUY_SUCCESS, slot1.goods_id)
		else
			ShowTips(slot0.result)
		end
	end
}
