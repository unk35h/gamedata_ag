slot1 = manager.net

slot1:Bind(11017, function (slot0)
	OsirisInfinityPoolData:InitData(slot0)
end)

return {
	OpenPoolBox = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(11024, {
			pool_id = slot0,
			index = slot1
		}, 11025, function (slot0)
			if isSuccess(slot0.result) then
				OsirisInfinityPoolData:OpenBox(uv0, uv1, {
					slot0.box.item.id,
					slot0.box.item.num
				})
			end

			uv2(slot0)
		end)
	end,
	ResetPool = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(11026, {
			pool_id = slot0
		}, 11027, function (slot0)
			if isSuccess(slot0.result) then
				OsirisInfinityPoolData:ResetPool(uv0, slot0.pool)
			end

			uv1(slot0)
		end)
	end
}
