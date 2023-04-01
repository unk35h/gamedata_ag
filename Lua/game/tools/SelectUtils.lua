return {
	SingleSelect = function (slot0, slot1)
		slot2 = slot1

		return function (slot0)
			slot1 = nil

			if slot0 ~= uv0 then
				uv0 = slot0
				slot1 = uv0
			else
				uv0 = nil
				slot1 = uv0
			end

			if uv1 and uv1.afterValueChange then
				uv1.afterValueChange(slot1, uv0)
			end
		end, function ()
			return uv0
		end
	end,
	MultiSelect = function (slot0, slot1, slot2)
		slot3 = slot2 or {}

		return function (slot0)
			if table.indexof(uv0, slot0) then
				table.remove(uv0, slot1)

				if uv1 and uv1.afterRemove then
					uv1.afterRemove(slot0)
				end
			elseif #uv0 < uv2 then
				table.insert(uv0, slot0)

				if uv1 and uv1.afterInsert then
					uv1.afterInsert(slot0)
				end

				slot1 = #uv0 + 1
			end

			return slot1
		end, function ()
			return uv0
		end, function ()
			table.clean(uv0)

			if uv1 and uv1.afterClear then
				uv1.afterClear()
			end
		end
	end
}
