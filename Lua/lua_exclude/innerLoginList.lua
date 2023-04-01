slot0 = require("cjson")

return {
	GetLoginList = function (slot0)
		slot4 = {}

		for slot8, slot9 in pairs(uv0.decode(tostring(Resources.Load("innerLoginInfo")))) do
			slot4[tonumber(slot8)] = slot9
		end

		return slot4
	end
}
