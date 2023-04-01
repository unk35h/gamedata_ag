slot0 = class("DrawUpPool", DrawBasePool)

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)

	if slot0.m_changeBtn then
		slot0:AddBtnListener(slot0.m_changeBtn, nil, function ()
			slot1 = DrawData:GetPoolUpTimes(uv0.poolId)

			if DrawPoolCfg[uv0.poolId].pool_change == 0 or slot1 < slot0 then
				uv0:Go("/drawHeroSelect", {
					poolId = uv0.poolId
				})
			else
				ShowTips("DRAW_LACK_UP_TIMES")
			end
		end)
	end
end

function slot0.Refresh(slot0)
	uv0.super.Refresh(slot0)

	if slot0.m_changeCount then
		if DrawPoolCfg[slot0.poolId].pool_change == 0 then
			slot0.m_changeCount.text = ""
		else
			slot0.m_changeCount.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(slot1 - DrawData:GetPoolUpTimes(slot0.poolId)))
		end
	end
end

return slot0
