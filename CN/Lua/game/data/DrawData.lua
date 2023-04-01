slot0 = singletonClass("DrawData")
slot1 = {}
slot2 = false
slot3 = 0
slot4 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = false
	uv2 = 0
	uv3 = {}
	slot0.newHeroFlag_ = false
end

function slot0.InitPool(slot0, slot1)
	uv0 = {}

	for slot6, slot7 in ipairs(slot1.draw_info_list) do
		uv0[slot7.id] = {
			ssr_draw_times = slot7.ssr_draw_times,
			up = slot7.up,
			up_times = slot7.up_times
		}
	end

	uv1 = slot1.today_draw_times
	uv2 = slot1.first_ssr_draw_flag
end

function slot0.UpdatePool(slot0, slot1, slot2, slot3)
	if uv0[slot1] then
		uv0[slot1].ssr_draw_times = slot2
	else
		uv0[slot1] = {
			ssr_draw_times = slot2
		}
	end

	uv1 = slot3
end

function slot0.TodayDrawTimesChange(slot0, slot1)
	uv0 = uv0 + slot1
end

function slot0.GetTodayDrawTimes(slot0)
	return uv0
end

function slot0.GetIsFirstSSR(slot0)
	return uv0
end

function slot0.GetPoolDrawTimes(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].ssr_draw_times or 0
	end

	return 0
end

function slot0.SetPollUpID(slot0, slot1, slot2)
	if uv0[slot1] then
		if slot2 ~= uv0[slot1].up then
			uv0[slot1].up = slot2
			uv0[slot1].up_times = (uv0[slot1].up_times or 0) + 1
		end
	else
		uv0[slot1] = {
			up_times = 1,
			up = slot2
		}
	end
end

function slot0.GetPollUpID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].up or 0
	end

	return 0
end

function slot0.GetPoolUpTimes(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].up_times or 0
	end

	return 0
end

function slot0.SetDrawRecord(slot0, slot1, slot2)
	if not slot2 then
		uv0[slot1] = nil
	else
		uv0[slot1] = {
			ssr_draw_times = slot2.ssr_draw_times,
			draw_record_list = {}
		}

		for slot6 = 1, #slot2.draw_record_list do
			slot7 = slot2.draw_record_list[#slot2.draw_record_list - slot6 + 1]
			slot8 = slot7.item

			table.insert(uv0[slot1].draw_record_list, {
				item = {
					id = slot8.id,
					num = slot8.num
				},
				draw_timestamp = slot7.draw_timestamp
			})
		end
	end
end

function slot0.GetDrawRecord(slot0, slot1)
	return uv0[slot1]
end

slot5 = {}

function slot0.SetServantRedPoint(slot0, slot1, slot2)
	slot3 = string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, slot1, slot0:GetPollUpID(slot1))

	manager.redPoint:setTip(slot3, slot2)

	uv0[slot3] = true
end

function slot0.ResetServantRedPoint(slot0)
	for slot4, slot5 in pairs(uv0) do
		manager.redPoint:setTip(slot4, 0)
	end
end

function slot0.SetNewHeroFlag(slot0, slot1)
	slot0.newHeroFlag_ = slot1
end

function slot0.GetNewHeroFlag(slot0)
	return slot0.newHeroFlag_
end

function slot0.IsOnePrefabPool(slot0, slot1)
	if not DrawPoolCfg[slot1] then
		CustomLog.Log(debug.traceback(string.format("null")))
	end

	return slot2.pool_type == 3 and #slot2.optional_lists > 2
end

function slot0.GetUpRemainTime(slot0, slot1)
	return DrawPoolCfg[slot1].pool_change - slot0:GetPoolUpTimes(slot1)
end

return slot0
