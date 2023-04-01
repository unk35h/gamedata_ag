slot1 = manager.net

slot1:Bind(52001, function (slot0)
	IllustratedData:InitData(slot0)
	uv0.UpdateEnemyRedPoint()
	uv0.UpdateWorldViewRedPoint()
	uv0.UpdateIllustrationRedPoint()
end)

slot1 = manager.net

slot1:Bind(52007, function (slot0)
	IllustratedData:ModifyIntelligenceReward(slot0.intelligence_reward)
end)

slot1 = manager.net

slot1:Bind(52009, function (slot0)
	IllustratedData:ModifyEnemyInfo(slot0.enemy_info)
	uv0.UpdateEnemyRedPoint()
end)

slot1 = manager.net

slot1:Bind(52011, function (slot0)
	IllustratedData:ModifyIllustrationInfo(slot0.inbetweening_info)
	uv0.UpdateIllustrationRedPoint()
end)

slot1 = manager.net

slot1:Bind(52013, function (slot0)
	IllustratedData:ModifyAffixInfo(slot0.affix_info)
	uv0.UpdateWorldViewRedPoint()
end)

slot1 = manager.net

slot1:Bind(52021, function (slot0)
	IllustratedData:SaveLoadingSet(slot0.id_list)
end)

slot1 = manager.net

slot1:Bind(12029, function (slot0)
	IllustratedData:SetBgm(slot0.id)
end)

return {
	ModifyServantInfo = function (slot0)
		IllustratedData:ModifyServantInfo(slot0)
	end,
	ModifyEquipInfo = function (slot0, slot1)
		IllustratedData:ModifyEquipInfo(slot0, slot1)
	end,
	ModifyPlot = function (slot0)
		IllustratedData:ModifyPlot(slot0)
	end,
	ReceiveIllustrationReward = function (slot0)
		manager.net:SendWithLoadingNew(52004, {
			id_list = slot0
		}, 52005, uv0.OnReceiveIllustrationReward)
	end,
	OnReceiveIllustrationReward = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		else
			for slot5, slot6 in ipairs(slot1.id_list) do
				IllustratedData:GetIllustrationInfo()[slot6].is_receive = 1
			end

			uv0.UpdateIllustrationRedPoint()
			manager.notify:CallUpdateFunc(ILLU_RECEIVE_REWARD, slot0, slot1)
		end
	end,
	ViewIllustration = function (slot0, slot1)
		manager.net:SendWithLoadingNew(52014, {
			id = slot0,
			type = slot1
		}, 52015, uv0.OnViewIllustration)
		IllustratedData:ModifyView(slot0, slot1)

		if slot1 == CollectConst.INFORMATION then
			-- Nothing
		elseif slot1 == CollectConst.ENEMY then
			uv0.UpdateEnemyRedPoint()
		elseif slot1 == CollectConst.PLOT then
			-- Nothing
		elseif slot1 == CollectConst.ILLUSTRATION then
			uv0.UpdateIllustrationRedPoint()
		elseif slot1 == CollectConst.WORLDVIEW then
			uv0.UpdateWorldViewRedPoint()
		end
	end,
	OnViewIllustration = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SaveLoadingSet = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insertto(slot1, slot0[slot5])
		end

		manager.net:SendWithLoadingNew(52016, {
			all_id_list = slot1
		}, 52017, uv0.OnSaveLoadingSet)
	end,
	OnSaveLoadingSet = function (slot0, slot1)
		if isSuccess(slot0.result) then
			IllustratedData:SaveLoadingSet(slot1.all_id_list)
			manager.notify:CallUpdateFunc(SAVE_LOADING_SET)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeLoadingSet = function (slot0, slot1)
		manager.net:SendWithLoadingNew(52018, {
			type = slot0,
			id = slot1
		}, 52019, uv0.OnChangeLoadingSet)
	end,
	OnChangeLoadingSet = function (slot0, slot1)
		if isSuccess(slot0.result) then
			IllustratedData:ChangeLoadingSet(slot1.type, slot1.id)
			manager.notify:CallUpdateFunc(SAVE_LOADING_SET)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateServantRedPoint = function ()
		slot1 = IllustratedData

		uv0.UpdateIlluRedPoint(RedPointConst.ILLU_SERVANT, slot1:GetServantInfo(), function (slot0)
			return slot0.is_view == 0
		end)
	end,
	UpdateEquipRedPoint = function ()
		slot1 = IllustratedData

		uv0.UpdateIlluRedPoint(RedPointConst.ILLU_EQUIP, slot1:GetEquipInfo(), function (slot0)
			return slot0.is_view == 0
		end)
	end,
	UpdateEnemyRedPoint = function ()
		slot0 = IllustratedData:GetEnemyInfo()

		for slot4, slot5 in pairs(CollectMonsterCfg.get_id_list_by_race) do
			slot6 = false

			for slot10, slot11 in pairs(slot0) do
				if CollectMonsterCfg[slot11.id].race == slot4 and slot11.is_view == 0 then
					slot6 = true

					break
				end
			end

			manager.redPoint:setTip(RedPointConst["ILUU_ENEMY" .. slot4], slot6 and 1 or 0)
		end

		uv0.UpdateIlluRedPoint(RedPointConst.ILUU_ENEMY, slot0, function (slot0)
			return slot0.is_view == 0
		end)
	end,
	UpdateWorldViewRedPoint = function ()
		slot1 = IllustratedData

		uv0.UpdateIlluRedPoint(RedPointConst.ILLU_WORLDVIEW, slot1:GetAffixInfo(), function (slot0)
			return slot0.is_view == 0
		end)
	end,
	UpdateIlluRedPoint = function (slot0, slot1, slot2)
		if not getData("IlluRedPoint", slot0) then
			slot3 = {}

			for slot7, slot8 in pairs(slot1) do
				if slot2(slot8) then
					if not slot3[1] then
						slot3[1] = 1
					else
						slot3[2] = (slot3[2] or 0) + 1
					end
				end
			end

			slot3[1] = slot3[1] or 0
			slot3[2] = slot3[2] or 0

			saveData("IlluRedPoint", slot0, slot3)
		else
			slot4 = slot3[2]
			slot5 = 0

			for slot9, slot10 in pairs(slot1) do
				if slot2(slot10) then
					slot5 = slot5 + 1
				end
			end

			if slot4 < slot5 then
				slot3[1] = 1
				slot3[2] = slot5

				saveData("IlluRedPoint", slot0, slot3)
			else
				slot3[2] = slot5

				saveData("IlluRedPoint", slot0, slot3)
			end
		end

		manager.redPoint:setTip(slot0, slot3[1])
	end,
	SetIlluRedPoint = function (slot0)
		slot1 = manager.redPoint

		slot1:setTip(slot0, 0)

		slot1 = nil

		function slot2(slot0)
			return slot0.is_view == 0
		end

		if slot0 == RedPointConst.ILLU_WORLDVIEW then
			slot1 = IllustratedData:GetAffixInfo()
		elseif slot0 == RedPointConst.ILLU_EQUIP then
			slot1 = IllustratedData:GetEquipInfo()
		elseif slot0 == RedPointConst.ILLU_SERVANT then
			slot1 = IllustratedData:GetServantInfo()
		elseif slot0 == RedPointConst.ILUU_ENEMY then
			slot1 = IllustratedData:GetEnemyInfo()
		else
			error("为实现的类型")
		end

		slot3 = 0

		for slot7, slot8 in pairs(slot1) do
			if slot2(slot8) then
				slot3 = slot3 + 1
			end
		end

		saveData("IlluRedPoint", slot0, {
			0,
			slot3
		})
	end,
	UpdateIllustrationRedPoint = function ()
		slot0 = IllustratedData:GetIllustrationInfo()

		for slot4 = 1, 4 do
			manager.redPoint:setTip(RedPointConst["ILLU_ILLUSTRATION" .. slot4], 0)
		end

		for slot4, slot5 in pairs(slot0) do
			if slot5.is_receive == 0 then
				manager.redPoint:setTip(RedPointConst["ILLU_ILLUSTRATION" .. CollectPictureCfg[slot5.id].type], 1)
			end
		end
	end,
	QuerySetBgm = function (slot0)
		manager.net:SendWithLoadingNew(12026, {
			id = slot0
		}, 12027, uv0.OnQuerySetBgmBack)
	end,
	OnQuerySetBgmBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			IllustratedData:SetBgm(slot1.id)
			manager.notify:CallUpdateFunc(SET_BGM_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end
}
