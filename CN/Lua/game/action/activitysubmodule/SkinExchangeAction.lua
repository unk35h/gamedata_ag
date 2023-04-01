slot1 = false
slot2 = {}

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true
		slot0 = SkinExchangeData

		slot0:Init()

		uv1 = {
			all = {}
		}
		slot0 = manager.net

		slot0:Bind(60069, function (slot0)
			SkinExchangeData:SetData(slot0)

			if ActivitySkinExchangeCfg[slot0.activity_id] then
				slot2 = ActivitySkinExchangeCfg[slot1].cost or {}

				for slot6, slot7 in ipairs(slot2) do
					if not uv0[slot7[1]] then
						uv0[slot8] = {}

						table.insert(uv0.all, slot8)
					end

					table.insert(uv0[slot8], slot1)
				end
			end
		end)

		slot0 = manager.notify

		slot0:RegistListener(CURRENCY_UPDATE, function (slot0)
			slot1, slot2 = nil

			if uv0[slot0] then
				for slot6, slot7 in ipairs(uv0[slot0]) do
					manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. slot7, SkinExchangeTool.IsCanExchange(slot7) and 1 or 0)
				end
			end
		end)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. slot0, SkinExchangeTool.IsCanExchange(slot0) and 1 or 0)
	end,
	ExchangeSkin = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60066, {
			activity_id = slot1
		}, 60067, handler(slot0, slot0.OnExchangeSkin))
	end,
	OnExchangeSkin = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			SkinExchangeData:SetState(slot2.activity_id)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_" .. slot2.activity_id, 0)
			manager.notify:CallUpdateFunc(ACTIVITY_SKIN_EXCHANGE)
			getReward(ActivitySkinExchangeCfg[slot2.activity_id].reward, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		else
			ShowTips(slot1.result)
		end
	end
}
