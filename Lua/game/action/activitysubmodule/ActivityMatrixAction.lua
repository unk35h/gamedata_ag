slot1 = manager.net

slot1:Bind(26001, function (slot0)
	ActivityMatrixData:InitMatrixUser(slot0.matrix)
	uv0.CheckRewardRedPonit()
	uv0.CheckReadRedPonit()
end)

slot1 = manager.net

slot1:Bind(26005, function (slot0)
	ActivityMatrixData:InitMatrixOver(slot0.end_info)
end)

slot1 = manager.net

slot1:Bind(26007, function (slot0)
	ActivityMatrixData:InitMatrixClue(slot0)
	uv0.CheckClueRedPoint(slot0.activity_id)
end)

slot1 = manager.notify

slot1:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		uv0.CheckRewardRedPonit()
		uv0.CheckReadRedPonit()
	end

	if slot1 == ActivityTemplateConst.SINGLE_MATRIX then
		uv0.CheckClueRedPoint(slot0)
	end
end)

slot1, slot2 = nil
slot3 = nil
slot4 = nil
slot5 = nil

return {
	QueryStartMatrix = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(26012, {
			select_hero_list = slot0,
			activity_id = slot1,
			custom_affix_id_list = slot2
		}, 26013, uv0.StartMatrixCallBack)
	end,
	StartMatrixCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			JumpTools.GoToSystem("/matrixBlank/activityMatrixOrigin", {
				matrix_activity_id = slot1.activity_id
			})
			ActivityMatrixData:SetMatrixBattleHeroTeam(slot1.activity_id, nil)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryNextProgress = function (slot0, slot1)
		uv0 = ActivityMatrixData:GetMatrixPhaseData(slot0)
		uv1 = ActivityMatrixData:GetTierID(slot0)

		manager.net:SendWithLoadingNew(26010, {
			activity_id = slot0,
			params = slot1 or {
				0
			}
		}, 26011, uv2.NextProgressCallBack)
	end,
	NextProgressCallBack = function (slot0, slot1)
		slot2 = slot1.activity_id

		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)

			if ActivityMatrixData:GetGameState(slot2) == MatrixConst.STATE_TYPE.STARTED then
				slot5 = slot1.params and slot1.params[1]

				if MatrixConst.PHASE_TYPE.REWARD == uv0:GetPhase() then
					slot6 = false

					if not slot5 then
						slot6 = true
						slot5 = uv0:GetGiveUpItemId() or 0
					end

					uv1.DoReward(slot5, slot6, slot2)
				elseif MatrixConst.PHASE_TYPE.ACTION == slot4 then
					if MatrixConst.EVENT_TYPE.INCIDENT == ActivityMatrixEventTemplateCfg[uv0:GetParams()[1]].event_type then
						uv1.DoEffect(MatrixChanceCfg[slot5].toll)
					end

					uv1.DoAfterEvnet(slot2, uv2)
				end

				if ActivityMatrixData:GetMatrixPhaseData(slot2):GetPhase() == 2 then
					uv1.DoEvent(slot2)
				end
			elseif slot3 == MatrixConst.STATE_TYPE.SUCCESS or slot3 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/matrixOver")
			else
				OpenPageUntilLoaded("/matrixBlank/matrixPrepare")
			end

			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end

		uv0 = nil
		uv2 = nil
	end,
	DoEvent = function (slot0)
		if not (ActivityMatrixData:GetMatrixPhaseData(slot0):GetParams()[1] and ActivityMatrixEventTemplateCfg[slot2]) then
			error("ActivityMatrixEventTemplateCfg cant find event by id :" .. slot2)

			return
		end

		if MatrixConst.EVENT_TYPE.SHOP == slot3.event_type then
			JumpTools.GoToSystem("/matrixBlank/activityMatrixProcessShop", {
				matrix_activity_id = slot0,
				shops = slot1:GetShops()
			})
		elseif MatrixConst.EVENT_TYPE.INCIDENT ~= slot3.event_type then
			BattleController.GetInstance():LaunchBattle(BattleActivityMatrixTemplate.New(slot1:GetData(), slot0))
		end
	end,
	DoReward = function (slot0, slot1, slot2)
		if not MatrixItemCfg[slot0] then
			return
		end

		if MatrixConst.ITEM_TYPE.ITEM == slot3.matrix_item_type then
			-- Nothing
		elseif MatrixConst.ITEM_TYPE.EFFECT == slot3.matrix_item_type then
			uv0.DoEffect(slot3.params[1] or 0)
		end
	end,
	DoAfterEvnet = function (slot0, slot1)
	end,
	DoEffect = function (slot0)
		if not MatrixEffectCfg[slot0] then
			return
		end
	end,
	QueryMatrixOver = function (slot0)
		manager.net:SendWithLoadingNew(26020, {
			activity_id = slot0
		}, 26021, uv0.MatrixOverCallBack)
	end,
	MatrixOverCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.NOTSTARTED, slot0.progress)
			JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
				main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(slot1.activity_id),
				matrix_activity_id = slot1.activity_id
			})
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryMatrixGiveUp = function (slot0)
		manager.net:SendWithLoadingNew(26024, {
			activity_id = slot0
		}, 26025, uv0.MatrixGiveUpCallBack)
	end,
	MatrixGiveUpCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.FAIL, slot0.progress)
			JumpTools.GoToSystem("/matrixBlank/activityMatrixOver", {
				matrix_activity_id = slot1.activity_id
			})
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	BuyShopItem = function (slot0, slot1, slot2, slot3)
		slot5, slot6 = ActivityMatrixData:GetMatrixPhaseData(slot0):GetData()

		for slot10, slot11 in ipairs(slot6) do
			if slot11.index == slot1 then
				uv0 = slot11

				manager.net:SendWithLoadingNew(26010, {
					activity_id = slot0,
					params = {
						2,
						slot1,
						slot2,
						slot3 or 0
					}
				}, 26011, uv1.OnBuyShopItem)

				return
			end
		end
	end,
	OnBuyShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			ShowTips("TRANSACTION_SUCCESS")
			manager.notify:CallUpdateFunc(MATRIX_SHOP_BUY_SUCCESS)

			if uv0 ~= nil then
				uv1.DoReward(uv0.id)

				uv0 = nil
			end

			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRefreshShopItem = function (slot0)
		slot4 = ActivityMatrixData:GetShopFressRefreshTimes(slot0)

		if ActivityMatrixData:GetMatrixPhaseData(slot0):GetData() < ActivityMatrixData:GetShoRefreshTimes(slot0) then
			slot5 = GameSetting.matrix_shop_refresh_cost_item_list.value

			if slot4 <= slot2 then
				if ActivityMatrixData:GetMatrixCoint(slot0) < slot5[math.min(slot2 - slot4 + 1, #slot5)][2] then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

					return
				end

				manager.net:SendWithLoadingNew(26010, {
					activity_id = slot0,
					params = {
						1
					}
				}, 26011, uv0.OnRefrshShopItem)
			else
				manager.net:SendWithLoadingNew(26010, {
					activity_id = slot0,
					params = {
						1
					}
				}, 26011, uv0.OnRefrshShopItem)
			end
		end
	end,
	OnRefrshShopItem = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityMatrixData:UpdateMatrixProcess(slot1.activity_id, MatrixConst.STATE_TYPE.STARTED, slot0.progress)
			ShowTips("ASTROLABE_RESET")
			manager.notify:CallUpdateFunc(MATRIX_USER_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRankList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(65000, {
			start = 1,
			stop = 100,
			activity_id = slot1,
			version = ActivityMatrixData:GetRankVersion(slot1)
		}, 65001, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if slot0.version ~= uv0 or uv0 == 0 then
					ActivityMatrixData:SetRankData(uv1, slot0)
					manager.notify:CallUpdateFunc(ACTIVITY_MATRIX_RANK_UPDATE)
				end
			else
				ShowTips(slot0.result)
			end
		end)

		if GuildData:GetGuildInfo().id ~= nil then
			slot5 = manager.net

			slot5:SendWithLoadingNew(33302, {
				activity_id = slot1
			}, 33303, function (slot0, slot1)
				if isSuccess(slot0.result) then
					ActivityMatrixData:SetGuildRankData(uv0, slot0)
					manager.notify:CallUpdateFunc(ACTIVITY_MATRIX_RANK_UPDATE)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end,
	OnReceivePointReward = function (slot0, slot1)
		ActivityMatrixData:OnReceivePointReward(slot0, slot1)
		uv0.CheckRewardRedPonit()
	end,
	CheckRewardRedPonit = function ()
		slot0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

		for slot4, slot5 in ipairs(slot0) do
			if ActivityData:GetActivityIsOpen(slot5) then
				slot7 = false

				for slot11, slot12 in ipairs(ActivityCfg[slot5].sub_activity_list) do
					if ActivityMatrixData:GetMatrixPointCanReward(slot12) then
						slot7 = true

						break
					end
				end

				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, slot5), slot7 and 1 or 0)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, slot5), 0)
			end
		end
	end,
	CheckReadRedPonit = function ()
		slot0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}

		for slot4, slot5 in ipairs(slot0) do
			slot6 = ActivityCfg[slot5]
			slot7 = false

			if ActivityData:GetActivityIsOpen(slot5) then
				for slot11, slot12 in ipairs(slot6.sub_activity_list) do
					if uv0.CheckSubReadRedPonit(slot12) then
						slot7 = true

						break
					end
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, slot5), slot7 and 1 or 0)
		end
	end,
	CheckSubReadRedPonit = function (slot0)
		if not ActivityMatrixData:GetRead(slot0) then
			slot2 = ActivityMatrixCfg[slot0]

			if ActivityMatrixData:GetMatrixData(slot0) and slot1.point == 0 and MatrixConst.STATE_TYPE.NOTSTARTED == slot1.game_state and ActivityMatrixData:GetIsClearance(slot2.preconditions) and ActivityData:GetActivityIsOpen(slot0) then
				return true
			end
		end

		return false
	end,
	SetActivityMtairxRead = function (slot0, slot1)
		if not ActivityMatrixData:GetIsClearance(ActivityMatrixCfg[slot1].preconditions) or not ActivityData:GetActivityIsOpen(slot1) then
			return
		end

		ActivityMatrixData:SetRead(slot1)

		slot4 = false

		for slot8, slot9 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if uv0.CheckSubReadRedPonit(slot9) then
				slot4 = true

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, slot0), slot4 and 1 or 0)
	end,
	CheckClueRedPoint = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) then
			for slot5, slot6 in ipairs(ActivityMatrixData:GetMatrixClue(slot0)) do
				if not ActivityMatrixData:GetClueRead(slot0, slot6.clue_id) then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot0), 1)

					return
				end
			end

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot0), 0)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot0), 0)
		end
	end,
	SetClueRead = function (slot0, slot1)
		ActivityMatrixData:SetClueRead(slot0, slot1)
		uv0.CheckClueRedPoint(slot0)
	end,
	GetSelectCamp = function ()
		if not uv0 then
			uv0 = getData("AcvityMatrixClue", "selectCamp")
		end

		if type(uv0) ~= "number" then
			uv0 = 1
		end

		return uv0
	end,
	SetSelectCamp = function (slot0)
		uv0 = slot0

		saveData("AcvityMatrixClue", "selectCamp", uv0)
	end,
	GetSelectClue = function ()
		if not uv0 then
			uv0 = 1
		end

		return uv0
	end,
	SetSelectClue = function (slot0)
		uv0 = slot0
	end
}
