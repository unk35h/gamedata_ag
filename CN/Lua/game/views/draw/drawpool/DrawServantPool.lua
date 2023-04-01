slot0 = class("DrawServantPool", DrawBasePool)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.replacebtnBtn_, nil, function ()
		uv0:Go("/drawSelect")
	end)
	slot0:AddBtnListener(slot0.btnlook1Btn_, nil, function ()
		if table.indexof(DrawPoolCfg[uv0.poolId].optional_lists, uv0.showId) and slot0.optional_detail[slot1] then
			uv0:Go("/showServantView", {
				state = "onlydetail",
				id = slot0.optional_detail[slot1]
			})
		end
	end)
	slot0:AddBtnListener(slot0.btnshow_, nil, function ()
		DrawData:SetServantRedPoint(uv0.poolId, 0)
		uv0:Go("/weaponServantShowView", {
			race = uv0.showId - 200000
		})
	end)
end

function slot0.SetActive(slot0, slot1)
	uv0.super.SetActive(slot0, slot1)
	manager.redPoint:unbindUIandKey(slot0.btnshow_.transform)

	slot2 = string.format("%s_%d_%d", RedPointConst.WEAPON_SERVANT_POOL, slot0.poolId, DrawData:GetPollUpID(slot0.poolId))

	if slot1 == true then
		manager.redPoint:bindUIandKey(slot0.btnshow_.transform, slot2)
	end
end

return slot0
