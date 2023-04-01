slot1 = import(".BehaviourFactory")

return {
	IsBehaviourAvailable = function (slot0, slot1)
		return uv0.IsBehaviourAvailable(slot1)
	end,
	HasBehaviour = function (slot0, slot1)
		return slot0.__behaviours[slot1] ~= nil
	end,
	AddBehaviour = function (slot0, slot1)
		slot2 = slot0.__behaviours[slot1] or uv0.CreateBehaviour(slot1)

		slot2:AddRef_(slot0)

		return slot2
	end,
	RemoveBehaviour = function (slot0, slot1)
		slot0.__behaviours[slot1]:SubRef_()
	end,
	GetBehaviour = function (slot0, slot1)
		return slot0.__behaviours[slot1]
	end,
	BroadcastMessage2Behaviours = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0.__behaviours) do
			slot6.HandleMessage_(slot6, slot1)
		end
	end,
	ResetAllBehaviours = function (slot0)
		if not slot0.__behaviours then
			return
		end

		slot1 = {}

		for slot5, slot6 in pairs(slot0.__behaviours) do
			slot1[#slot1 + 1] = slot6
		end

		function slot5(slot0, slot1)
			return slot1:GetPriority() < slot0:GetPriority()
		end

		table.sort(slot1, slot5)

		for slot5, slot6 in ipairs(slot1) do
			slot6.Reset(slot6, slot0)
		end
	end,
	BindMethod = function (slot0, slot1, slot2, slot3, slot4)
		if not slot0[slot2] then
			slot0[slot2] = function (slot0, ...)
				return uv0(uv1, ...)
			end

			return
		end

		if not slot0.bindingMethods_ then
			slot0.bindingMethods_ = {}
		end

		if not slot0.bindingMethods_[slot2] then
			slot0.bindingMethods_[slot2] = {}
		end

		slot7 = nil
		slot7 = (not slot4 or function (...)
			slot0 = {
				...
			}

			table.remove(slot0, 1)
			uv0(uv1, unpack(slot0))

			return uv2[2](...)
		end) and function (...)
			uv0[2](...)

			slot0 = {
				...
			}

			table.remove(slot0, 1)

			return uv1(uv2, unpack(slot0))
		end
		slot0[slot2] = slot7

		table.insert(slot0.bindingMethods_[slot2], {
			slot1,
			slot5,
			slot7
		})
	end,
	UnbindMethod = function (slot0, slot1, slot2)
		if not slot0.bindingMethods_ or not slot0.bindingMethods_[slot2] then
			slot0[slot2] = nil

			return
		end

		for slot8 = #slot0.bindingMethods_[slot2], 1, -1 do
			if slot3[slot8][1] == slot1 then
				if slot8 < slot4 then
					slot3[slot8 + 1][2] = slot9[2]
				elseif slot4 > 1 then
					slot0[slot2] = slot3[slot8 - 1][3]
				elseif slot4 == 1 then
					slot0[slot2] = slot9[2]
					slot0.bindingMethods_[slot2] = nil
				end

				table.remove(slot3, slot8)

				break
			end
		end
	end,
	RemoveBehaviour_ = function (slot0, slot1)
		slot0.__behaviours[slot1] = nil
	end,
	AddBehaviour_ = function (slot0, slot1, slot2)
		slot0.__behaviours[slot1] = slot2
	end,
	Extend = function (slot0)
		if slot0.__behaviours ~= nil then
			return slot0
		end

		slot0.__behaviours = {}
		slot0.HasBehaviour = uv0.HasBehaviour
		slot0.AddBehaviour = uv0.AddBehaviour
		slot0.AddBehaviour_ = uv0.AddBehaviour_
		slot0.RemoveBehaviour = uv0.RemoveBehaviour
		slot0.RemoveBehaviour_ = uv0.RemoveBehaviour_
		slot0.BindMethod = uv0.BindMethod
		slot0.UnbindMethod = uv0.UnbindMethod
		slot0.GetBehaviour = uv0.GetBehaviour
		slot0.BroadcastMessage2Behaviours = uv0.BroadcastMessage2Behaviours
		slot0.ResetAllBehaviours = uv0.ResetAllBehaviours
		slot0.IsBehaviourAvailable = uv0.IsBehaviourAvailable

		return slot0
	end
}
