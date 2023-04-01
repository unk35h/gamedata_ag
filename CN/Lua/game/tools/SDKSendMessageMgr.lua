slot0 = require("cjson")
slot2 = {
	kr = "SendMessageKR",
	zh_cn = "SendMessageCN",
	jp = "SendMessageJPUS",
	tw = "SendMessageTC",
	en = "SendMessageJPUS"
}

function SendMessageManagerToSDK(slot0, slot1)
	if require("game/tools/SendMessage/" .. uv0[GameToSDK.CURRENT_SERVER]) == nil then
		slot2 = uv1
	end

	if uv1.typeToFunction[slot0] then
		uv1.typeToFunction[slot0](slot1)
	elseif slot2.typeToFunction[slot0] then
		slot2.typeToFunction[slot0](slot1)
	end
end

return {
	typeToFunction = {},
	SendMessageToSDK = function (slot0, slot1)
		SDKAction.SendMessageToSDK(slot0, slot1)
	end
}
