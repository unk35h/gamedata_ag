slot1 = manager.net

slot1:Bind(46011, function (slot0)
	WeaponServantData:InitServant(slot0)
	uv0.CheckRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_MODIFY, function ()
	uv0.CheckRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(MATERIAL_LIST_UPDATE, function ()
	uv0.CheckRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(WEAPON_SERVANT_LIST_UPDATE, function ()
	uv0.CheckRedPoint()
end)

return {
	TouchRedPoint = function ()
		uv0.touched = true

		uv0.CheckRedPoint()
	end,
	CheckRedPoint = function ()
		if uv0.touched == true then
			manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, 0)

			return
		end

		slot1 = false

		for slot5, slot6 in pairs(GameSetting.exclusive_weapon_servant_cost.value) do
			slot9 = 0

			if WeaponServantData:GetWeaponServantById(slot6[2][1][1]) then
				slot9 = #slot8
			end

			slot11 = 0

			if MaterialData:GetMaterial(slot7[2][1]) then
				slot11 = slot10.num
			end

			if slot7[2][2] <= slot11 and slot7[1][2] <= slot9 then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, slot1 and 1 or 0)
	end,
	ServantPromote = function (slot0, slot1, slot2, slot3)
		uv0.costMoney = slot3

		manager.net:SendWithLoadingNew(46012, {
			refined_type = slot0,
			uid = slot1,
			cost_uid = slot2
		}, 46013, uv0.OnServantPromote)
	end,
	OnServantPromote = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponServantData:ServantPromote(slot1.uid, slot1.cost_uid)

			if not slot1.cost_uid and ServantTools.ServantBreakMaterialCost(WeaponServantData:GetServantDataByUID(slot1.uid).id, WeaponServantCfg[WeaponServantData:GetServantDataByUID(slot1.uid).id].starlevel) then
				MaterialData:ModifyNum(slot3[1], -slot3[2])
			end

			CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_GOLD, -uv0.costMoney)
			manager.notify:CallUpdateFunc(SERVANT_PROMOTE, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantReplace = function (slot0, slot1)
		manager.net:SendWithLoadingNew(46020, {
			hero_id = slot0,
			servant_id = slot1
		}, 46021, uv0.OnServantReplace)
	end,
	OnServantReplace = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if ServantTools.GetServantMap()[slot1.servant_id] then
				HeroAction.ServantReplace(slot3, 0)
			end

			HeroAction.ServantReplace(slot1.hero_id, slot1.servant_id)
			manager.notify:CallUpdateFunc(SERVANT_REPLACE, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantLock = function (slot0)
		manager.net:SendWithLoadingNew(46014, {
			uid = slot0,
			is_lock = WeaponServantData:GetServantDataByUID(slot0).locked == 1 and 0 or 1
		}, 46015, uv0.OnServantLock)
	end,
	OnServantLock = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponServantData:ServantLock(slot1.uid, slot1.is_lock)
			manager.notify:CallUpdateFunc(SERVANT_LOCK, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantMerge = function (slot0, slot1)
		manager.net:SendWithLoadingNew(46030, {
			servant_id = slot0,
			cost_uid_list = slot1
		}, 46031, uv0.OnServantMerge)
	end,
	OnServantMerge = function (slot0, slot1)
		slot2 = tonumber(slot0.servant_uid)

		if isSuccess(slot0.result) then
			slot3 = WeaponServantCfg[slot1.servant_id]
			slot4 = {}

			for slot8, slot9 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
				if slot9[1] == slot3.race then
					slot4 = slot9[2]
				end
			end

			CurrencyData:CurrencyModify(slot4[2][1], -1 * slot4[2][2])
			WeaponServantData:ServantLock(slot2, WeaponServantData:GetServantDataByUID(slot1.cost_uid_list[1]).locked)
			WeaponServantData:CostServantS(slot1.cost_uid_list)

			slot11 = slot2

			WeaponServantData:SetServantMergeMap(slot1.cost_uid_list[1], slot11)

			slot7 = ServantTools.GetServantMap()

			for slot11, slot12 in ipairs(slot1.cost_uid_list) do
				if slot7[slot12] then
					HeroData:ServantReplace(slot13, slot2)
				end
			end

			IllustratedAction.ModifyServantInfo(slot1.servant_id)
			manager.notify:CallUpdateFunc(SERVANT_MERGE_RESULT, slot0, slot1)
		elseif TipsCfg[slot0.result] then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantDecompose = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot5)
		end

		manager.net:SendWithLoadingNew(46032, {
			servant_list = slot1
		}, 46033, uv0.OnServantDecompose)
	end,
	OnServantDecompose = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(SERVANT_DECOMPOSE_RESULT, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end
}
