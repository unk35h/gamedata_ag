return {
	func = {},
	register = function (slot0, slot1)
		uv0.func[slot0] = slot1
	end,
	call = function (slot0)
		if not uv0.func[slot0] then
			return
		else
			uv0.func[slot0]()

			uv0.func[slot0] = nil

			return
		end
	end,
	printNames = function ()
		for slot3, slot4 in pairs(uv0.func) do
			print(slot3)
		end
	end
}
