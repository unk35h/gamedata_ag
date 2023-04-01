slot0 = class("ClassesPool")

function slot0.Ctor(slot0)
	slot0.classPool_ = {}
	slot0.usingIndex_ = {}
end

function slot0.GetOrCreateClass(slot0, slot1, ...)
	if not slot0.classPool_[slot1.__cname] or not slot0.usingIndex_[slot2] then
		slot0.classPool_[slot2] = {}
		slot0.usingIndex_[slot2] = {}
	end

	for slot7 = 1, #slot0.classPool_[slot2] do
		if not slot0.usingIndex_[slot2][slot7] then
			slot0.usingIndex_[slot2][slot7] = true

			slot0.classPool_[slot2][slot7]:Ctor(...)

			return slot0.classPool_[slot2][slot7]
		end
	end

	slot4 = slot3 + 1
	slot0.classPool_[slot2][slot4] = slot1.New(...)
	slot0.classPool_[slot2][slot4].__recycle = slot4
	slot0.usingIndex_[slot2][slot4] = true

	return slot0.classPool_[slot2][slot4]
end

function slot0.ReturnClass(slot0, slot1)
	if not slot0.classPool_[slot1.class.__cname] or not slot0.usingIndex_[slot2] then
		return
	end

	if slot1.__recycle and slot2 then
		slot0.usingIndex_[slot2][slot3] = false
	end
end

function slot0.DisposeOnePool(slot0, slot1)
	if slot0.classPool_[slot1.__cname] then
		for slot7, slot8 in pairs(slot3) do
			slot8:Dispose()
		end

		slot0.classPool_[slot2] = {}
		slot0.usingIndex_[slot2] = {}
	end
end

function slot0.Dispose(slot0)
	if slot0.classPool_ then
		for slot4, slot5 in pairs(slot0.classPool_) do
			for slot9, slot10 in pairs(slot5) do
				slot10:Dispose()
			end
		end
	end

	slot0.classPool_ = {}
	slot0.usingIndex_ = {}
end

return slot0
