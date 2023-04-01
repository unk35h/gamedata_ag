slot0 = class("BehaviourBase")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.name_ = slot1
	slot0.depends_ = slot2
	slot0.priority_ = slot3 or 0
	slot0.refCnt_ = 0
end

function slot0.GetName(slot0)
	return slot0.name_
end

function slot0.GetDepends(slot0)
	return slot0.depends_
end

function slot0.GetPriority(slot0)
	return slot0.priority_
end

function slot0.GetTarget(slot0)
	return slot0.target_
end

function slot0.Reset(slot0)
end

function slot0.ExportMethods_(slot0, slot1)
	slot0.exportedMethods_ = slot1
	slot2 = slot0.target_
	slot3 = slot0

	for slot7, slot8 in ipairs(slot1) do
		if not slot2[slot8] then
			slot9 = slot3[slot8]

			slot2[slot8] = function (slot0, ...)
				return uv0(uv1, ...)
			end
		end
	end

	return slot0
end

function slot0.Bind_(slot0, slot1)
	slot0.target_ = slot1

	if slot0.depends_ then
		for slot5, slot6 in ipairs(slot0.depends_) do
			slot1:AddBehaviour(slot6)
		end
	end

	slot0:OnBind_(slot1)
end

function slot0.AddRef_(slot0, slot1)
	slot0.refCnt_ = slot0.refCnt_ + 1

	if slot0.refCnt_ == 1 then
		slot0:Bind_(slot1)
		slot0.target_:AddBehaviour_(slot0.name_, slot0)
	end
end

function slot0.Unbind_(slot0)
	slot1 = slot0.target_

	if slot0.exportedMethods_ then
		for slot5, slot6 in ipairs(slot0.exportedMethods_) do
			slot1[slot6] = nil
		end
	end

	slot0:OnUnbind_()

	if slot0.depends_ then
		for slot5, slot6 in ipairs(slot0.depends_) do
			slot1:RemoveBehaviour(slot6)
		end
	end
end

function slot0.SubRef_(slot0)
	slot0.refCnt_ = slot0.refCnt_ - 1

	if slot0.refCnt_ <= 0 then
		slot0:Unbind_()
		slot0.target_:RemoveBehaviour_(slot0.name_)
	end
end

function slot0.OnBind_(slot0)
end

function slot0.OnUnbind_(slot0)
end

return slot0
