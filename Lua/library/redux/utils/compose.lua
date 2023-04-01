require("library/redux/lib/functional")

return function (...)
	if #{
		...
	} == 0 then
		return function (slot0)
			return slot0
		end
	end

	if #slot0 == 1 then
		return slot0[1]
	end

	return reduce(function (slot0, slot1)
		return function (...)
			return uv0(uv1(unpack({
				...
			})))
		end
	end, slot0)
end
