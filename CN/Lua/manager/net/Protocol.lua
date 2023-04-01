slot1 = class("Protocol")
slot1.protocols = {}
slot1.binaryReader = import("manager/net/BinaryReader").New()
slot1.ps = PackStream.New()

function slot1.Ctor(slot0, slot1, slot2, slot3)
	slot0._id = slot1
	slot0._name = slot2
	slot0._object = slot3
end

function slot1.GetMessage(slot0)
	return slot0._object[slot0._name]()
end

function slot1.GetId(slot0)
	return slot0._id
end

function slot1.GetName(slot0)
	return slot0._name
end

function slot1.Pack(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot3:SerializeToString()

	if uv0.ps.Length ~= 0 then
		print("##   # pack string error !!!!!!!!!!!")
	end

	if #slot5 == 0 then
		slot6:WriteUint32LittleEndian(9)
	else
		slot6:WriteUint32LittleEndian(9 + #slot5)
	end

	slot6:WriteUint8(slot4 and 7 or 8)
	slot6:WriteUint32LittleEndian(slot2)
	slot6:WriteUint16LittleEndian(slot0)
	slot6:WriteUint16LittleEndian(slot1)
	slot6:WriteBuffer(slot5)

	return slot6:ToArray()
end

slot1.gameFrameTimePart1Index_ = 3
slot1.gameFrameTimePart2Index_ = 4

function slot1.SetSyncPlayerCount(slot0)
	uv0.gameFrameTimePart1Index_ = slot0 + 2
	uv0.gameFrameTimePart2Index_ = slot0 + 3
end

function slot1.ToByte(slot0)
	slot2 = string.byte(slot0, 1)

	for slot6 = 2, #slot0 do
		slot2 = slot2 .. "-" .. string.byte(slot0, slot6)
	end
end

function slot1.Unpack(slot0, slot1)
	if slot0 ~= 65522 then
		if uv0.GetProtocolWithName("sc_" .. slot0) ~= nil then
			slot3 = slot2._object[slot2._name]()

			slot3:ParseFromString(slot1)

			return slot3
		end
	else
		uv0.binaryReader:Initialize(slot1)

		if ({
			frames = {},
			currentServerFrame = uv0.binaryReader:Read(4)
		}).currentServerFrame == 0 then
			slot2.isFirstKeyFrameUpdate = true
		end

		while not uv0.binaryReader:EOF() do
			slot2.frames[uv0.binaryReader:Read(4)] = {
				playerOps = {}
			}

			for slot9 = 1, uv0.binaryReader:Read(1) do
				slot5[uv0.binaryReader:Read(1)] = {}

				for slot16 = 1, uv0.binaryReader:Read(1) do
					slot17 = nil

					table.insert(slot12, {
						opCode = (uv0.binaryReader:Read(1) ~= 3 or uv0.binaryReader:Read(2)) and uv0.binaryReader:Read(1),
						opType = slot18
					})
				end
			end
		end

		return slot2
	end
end

function slot1.GetProtocolWithName(slot0)
	if not uv0.protocols[slot0] then
		slot2 = "protocol/"
		slot3 = "p" .. string.sub(string.sub(slot0, 4, #slot0), 1, 2) .. "_pb"

		pcall(function ()
			uv0 = require(uv1 .. uv2)
		end)

		if nil then
			uv0.protocols[slot0] = Protocol.New(slot1, slot0, package.loaded[slot3])
		end
	end

	return uv0.protocols[slot0]
end

function slot1.BuildProtocolMessage(slot0, slot1)
	if slot1 == nil then
		print("data is nil...")
	end

	for slot5, slot6 in pairs(slot1) do
		if type(slot6) == "table" then
			if #slot6 > 0 then
				uv0.BuildProtocolMessageRepeat(slot0[slot5], slot6)
			else
				uv0.BuildProtocolMessageNormalTable(slot0[slot5], slot6)
			end
		else
			slot0[slot5] = slot6
		end
	end
end

function slot1.BuildProtocolMessageRepeat(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.add then
			uv0.BuildProtocolMessage(slot0:add(), slot6)
		elseif type(slot6) == "table" then
			if #slot6 > 0 or table.nums(slot6) == 0 then
				uv0.BuildProtocolMessageRepeat(slot0[slot5], slot6)
			else
				uv0.BuildProtocolMessageNormalTable(slot0[slot5], slot6)
			end
		else
			slot0:append(slot6)
		end
	end
end

function slot1.BuildProtocolMessageNormalTable(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot0.add then
			uv0.BuildProtocolMessage(slot0:add(), slot6)
		elseif type(slot6) == "table" then
			if #slot6 > 0 or table.nums(slot6) == 0 then
				uv0.BuildProtocolMessageRepeat(slot0[slot5], slot6)
			else
				uv0.BuildProtocolMessageNormalTable(slot0[slot5], slot6)
			end
		else
			slot0[slot5] = slot6
		end
	end
end

return slot1
