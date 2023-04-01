import("bit")

slot0 = class("BinaryReader")

function slot0.Initialize(slot0, slot1)
	slot0.index_ = 1
	slot0.data_ = slot1
	slot0.binaryArray_ = {}

	slot0:ToBinaryArray()
end

function slot0.EOF(slot0)
	return string.byte(slot0.data_, slot0.index_) == nil
end

function slot0.ToBinaryArray(slot0)
	for slot5 = 1, #slot0.data_ do
		slot0.binaryArray_[slot5] = string.byte(slot0.data_, slot5)
	end
end

function slot0.Read(slot0, slot1)
	if string.byte(slot0.data_, slot0.index_) == nil then
		return 0
	end

	for slot6 = slot0.index_ + 1, slot0.index_ + slot1 - 1 do
		slot2 = bit.bor(bit.lshift(slot2, 8), string.byte(slot0.data_, slot6))
	end

	slot0.index_ = slot0.index_ + slot1

	return slot2
end

return slot0
