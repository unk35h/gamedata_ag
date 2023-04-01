slot0 = singletonClass("IllustratedData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = {}
slot8 = {}
slot9 = 0
slot10 = {}
slot11 = {}
slot12 = {}
slot13 = {}
slot14 = {}
slot15 = {}

function slot16(slot0)
	if slot0 == CollectConst.INFORMATION then
		return uv0
	end

	if slot0 == CollectConst.ENEMY then
		return uv1
	end

	if slot0 == CollectConst.SERVANT then
		return uv2
	end

	if slot0 == CollectConst.EQUIP then
		return uv3
	end

	if slot0 == CollectConst.PLOT then
		return uv4
	end

	if slot0 == CollectConst.ILLUSTRATION then
		return uv5
	end

	if slot0 == CollectConst.WORLDVIEW then
		return uv6
	end
end

function slot0.InitData(slot0, slot1)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = {}
	uv6 = {}

	for slot5, slot6 in ipairs(slot1.intelligence_reward) do
		uv0[slot6.id] = {
			id = slot6.id,
			progress = slot6.progress,
			complete_flag = slot6.complete_flag
		}
	end

	for slot5, slot6 in ipairs(slot1.enemy_info) do
		uv1[slot6.id] = {
			id = slot6.id,
			times = slot6.times,
			is_view = slot6.is_view
		}
	end

	for slot5, slot6 in ipairs(slot1.servant_info) do
		uv2[slot6.id] = {
			id = slot6.id,
			is_view = slot6.is_view
		}
	end

	for slot5, slot6 in ipairs(slot1.equip_info) do
		slot10 = slot6.is_view
		uv3[slot6.suit] = {
			suit = slot6.suit,
			pos_list = {},
			is_view = slot10
		}

		for slot10, slot11 in ipairs(slot6.pos_list) do
			uv3[slot6.suit].pos_list[slot11] = 1
		end
	end

	for slot5, slot6 in ipairs(slot1.plot_info) do
		uv4[slot6.id] = {
			id = slot6.id,
			is_view = slot6.is_view
		}
	end

	for slot5, slot6 in ipairs(slot1.inbetweening_info) do
		uv5[slot6.id] = {
			id = slot6.id,
			is_receive = slot6.is_receive,
			is_view = slot6.is_view
		}
	end

	for slot5, slot6 in ipairs(slot1.affix_info) do
		uv6[slot6.id] = {
			id = slot6.id,
			is_view = slot6.is_view
		}
	end

	uv7:InitComData()
end

function slot0.GetIntelligenceReward(slot0)
	return uv0
end

function slot0.GetEnemyInfo(slot0)
	return uv0
end

function slot0.GetServantInfo(slot0)
	return uv0
end

function slot0.GetEquipInfo(slot0)
	return uv0
end

function slot0.GetPlotInfo(slot0)
	return uv0
end

function slot0.GetIllustrationInfo(slot0)
	return uv0
end

function slot0.GetAffixInfo(slot0)
	return uv0
end

function slot0.GetInfoIsView(slot0, slot1, slot2)
	if not uv0(slot1)[slot2] then
		return 0
	end

	return slot3[slot2].is_view
end

function slot0.ModifyEnemyInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			id = slot6.id,
			times = slot6.times,
			is_view = slot6.is_view
		}
	end
end

function slot0.ModifyIntelligenceReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			id = slot6.id,
			progress = slot6.progress,
			complete_flag = slot6.complete_flag
		}
	end
end

function slot0.ModifyIllustrationInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			id = slot6.id,
			is_receive = slot6.is_receive,
			is_view = slot6.is_view
		}
	end
end

function slot0.ModifyAffixInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			id = slot6.id,
			is_view = slot6.is_view
		}
	end
end

function slot0.ModifyServantInfo(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			is_view = 0,
			id = slot1
		}
	end
end

function slot0.ModifyEquipInfo(slot0, slot1, slot2)
	if not uv0[slot1] then
		uv0[slot1] = {
			is_view = 0,
			suit = slot1,
			pos_list = {}
		}
	end

	uv0[slot1].pos_list[slot2] = 1
end

function slot0.ModifyPlot(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			is_view = 0,
			id = slot1
		}
	end
end

function slot0.GetIsView(slot0, slot1, slot2)
	slot3 = nil

	if slot2 == CollectConst.ENEMY then
		slot3 = uv0[slot1]
	elseif slot2 == CollectConst.SERVANT then
		slot3 = uv1[slot1]
	elseif slot2 == CollectConst.EQUIP then
		slot3 = uv2[slot1]
	elseif slot2 == CollectConst.PLOT then
		slot3 = uv3[slot1]
	elseif slot2 == CollectConst.ILLUSTRATION then
		slot3 = uv4[slot1]
	elseif slot2 == CollectConst.WORLDVIEW then
		slot3 = uv5[slot1]
	else
		error("未知类型")
	end

	if slot3 == nil then
		return 0
	end

	return slot3.is_view
end

function slot0.ModifyView(slot0, slot1, slot2)
	if slot2 == CollectConst.ENEMY then
		uv0[slot1].is_view = 1
	elseif slot2 == CollectConst.SERVANT then
		uv1[slot1].is_view = 1
	elseif slot2 == CollectConst.EQUIP then
		uv2[slot1].is_view = 1
	elseif slot2 == CollectConst.PLOT then
		uv3[slot1].is_view = 1
	elseif slot2 == CollectConst.ILLUSTRATION then
		uv4[slot1].is_view = 1
	elseif slot2 == CollectConst.WORLDVIEW then
		uv5[slot1].is_view = 1
	else
		error("未知类型")
	end
end

function slot0.GetExistServant(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			is_view = 0,
			id = slot1
		}

		return false
	end

	return true
end

function slot0.ModifyData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot8 = slot1.id

		if not uv0[slot1.type] then
			uv0[slot7] = {}
		end

		uv0[slot7][slot8] = {
			id = slot1.id,
			progress = slot1.progress,
			complete_flag = slot1.complete_flag
		}
	end
end

function slot0.GetCollectionProgress(slot0, slot1, slot2)
	return uv0[slot1][slot2].progress
end

function slot0.SetBgm(slot0, slot1)
	uv0 = slot1
end

function slot0.GetBgm(slot0)
	return uv0
end

function slot0.GetAllLoadingSet(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		table.insertto(slot1, uv0[slot5])
	end

	return slot1
end

function slot0.GetLoadingSetByType(slot0, slot1)
	return uv0[slot1] or {}
end

function slot0.SaveLoadingSet(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		if not uv0[CollectPictureCfg[slot6].type] then
			uv0[slot7] = {}
		end

		table.insert(uv0[slot7], slot6)
	end

	uv1:ResetLoading()
end

function slot0.ChangeLoadingSet(slot0, slot1, slot2)
	slot3 = CollectPictureCfg[slot2].type

	if slot1 then
		if not uv0[slot3] then
			uv0[slot3] = {}
		end

		table.insert(uv0[slot3], slot2)
	else
		table.remove(uv0[slot3], table.indexof(uv0[slot3], slot2))
	end

	uv1:ResetLoading()
end

function slot0.IsInLoadingSet(slot0, slot1)
	return uv0[CollectPictureCfg[slot1].type] and table.indexof(uv0[slot2], slot1) ~= false
end

function slot0.InitComData(slot0)
	uv0 = {}
	uv1 = {}

	for slot4, slot5 in ipairs(LoadingTipsPoolCfg.all) do
		if LoadingTipsPoolCfg[slot5].loading_picture and slot7 ~= "" then
			table.insert(uv0, slot5)
		else
			table.insert(uv1, slot5)
		end
	end
end

function slot0.ResetLoading(slot0)
	uv0 = deepClone(uv1)
	uv2 = deepClone(LoadingTipsPicturePoolCfg.all)
	uv3 = deepClone(uv4:GetAllLoadingSet())
end

function slot0.GetRandomTips(slot0)
	if #uv0 <= 0 and #uv1 <= 0 and #uv2 <= 0 then
		uv3:ResetLoading()
	end

	slot1 = #uv0
	slot2 = #uv4
	slot3 = #uv2

	if #uv1 <= 0 then
		slot2 = 0
	end

	if math.random(1, slot1 + slot2 + slot3) <= slot1 then
		slot7 = LoadingTipsPoolCfg[uv0[slot4]]
		slot11 = slot4

		table.remove(uv0, slot11)

		for slot11, slot12 in ipairs(uv1) do
			if LoadingTipsPicturePoolCfg[slot12].loading_picture == slot7.loading_picture then
				table.remove(uv1, slot11)

				break
			end
		end

		return slot7.title, slot7.tips, slot7.loading_picture, true
	elseif slot4 <= slot1 + slot2 then
		slot7 = LoadingTipsPoolCfg[uv4[slot4 - slot1]]
		slot8 = math.random(1, #uv1)
		slot10 = LoadingTipsPicturePoolCfg[uv1[slot8]].loading_picture
		slot14 = slot8

		table.remove(uv1, slot14)

		for slot14, slot15 in ipairs(uv0) do
			if LoadingTipsPoolCfg[slot15].loading_picture == slot10 then
				table.remove(uv0, slot14)

				break
			end
		end

		return slot7.title, slot7.tips, slot10, true
	else
		slot5 = slot4 - slot1 - slot2
		slot7 = CollectPictureCfg[uv2[slot5]]

		table.remove(uv2, slot5)

		return slot7.name, slot7.desc, slot7.picture, false
	end
end

return slot0
