require("library/redux/lib/functional")

slot0 = require("library/redux/utils/compose")

return function (...)
	slot0 = {
		...
	}

	return function (slot0)
		return function (...)
			slot0 = uv0(unpack({
				...
			}))

			function slot1()
				error("                Dispatching while constructing your middleware is not allowed.\n                Other middleware would not be applied to this dispatch.")
			end

			slot2 = {
				getState = slot0.getState,
				dispatch = function (...)
					return uv0(unpack({
						...
					}))
				end
			}
			slot8 = map(function (slot0)
				return slot0(uv0)
			end, uv1)
			slot1 = uv2(unpack(slot8))(slot0.dispatch)
			slot4 = {}

			for slot8, slot9 in pairs(slot0) do
				slot4[slot8] = slot9
			end

			slot4.dispatch = slot1

			return slot4
		end
	end
end
