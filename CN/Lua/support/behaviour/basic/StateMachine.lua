slot1 = class("StateMachine", import("..BehaviourBase"))
slot1.VERSION = "2.2.0"
slot1.SUCCEEDED = 1
slot1.NOTRANSITION = 2
slot1.CANCELLED = 3
slot1.PENDING = 4
slot1.FAILURE = 5
slot1.INVALID_TRANSITION_ERROR = "INVALID_TRANSITION_ERROR"
slot1.PENDING_TRANSITION_ERROR = "PENDING_TRANSITION_ERROR"
slot1.INVALID_CALLBACK_ERROR = "INVALID_CALLBACK_ERROR"
slot1.WILDCARD = "*"
slot1.ASYNC = "ASYNC"

function slot1.Ctor(slot0)
	uv0.super.Ctor(slot0, "StateMachine")
end

function slot1.SetupState(slot0, slot1, slot2)
	if type(slot1.initial) == "string" then
		slot0.initial_ = {
			state = slot1.initial
		}
	else
		slot0.initial_ = clone(slot1.initial)
	end

	slot0.terminal_ = slot1.terminal or slot1.final
	slot0.events_ = slot1.events or {}
	slot0.callbacks_ = slot1.callbacks
	slot0.map_ = {}
	slot0.exceptMap_ = {}
	slot0.current_ = "none"
	slot0.inTransition_ = false

	if slot0.initial_ then
		slot0.initial_.event = slot0.initial_.event or "startup"

		slot0:AddEvent_({
			from = "none",
			name = slot0.initial_.event,
			to = slot0.initial_.state
		})
	end

	for slot6, slot7 in ipairs(slot0.events_) do
		slot0:AddEvent_(slot7)
	end

	if slot0.callbacks_ == nil and slot2 then
		slot0:AutoDetectCallbacks_()
	end

	slot0.callbacks_ = slot0.callbacks_ or {}

	if slot0.initial_ and not slot0.initial_.defer then
		slot0:DoEvent(slot0.initial_.event)
	end

	return slot0.target_
end

function slot1.AutoDetectCallbacks_(slot0)
	slot0.callbacks_ = {}
	slot1 = {}
	slot2 = {}
	slot3 = false
	slot4 = false
	slot5 = slot0.target_
	slot6, slot7 = nil

	for slot11, slot12 in pairs(slot0.map_) do
		if slot5["onbefore" .. slot11] then
			slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
		end

		if slot5["onafter" .. slot11] then
			slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
		end

		for slot16, slot17 in pairs(slot12) do
			if slot16 == uv0.WILDCARD then
				slot3 = true
			else
				if slot5["onleave" .. slot16] and slot0.callbacks_[slot6] == nil then
					slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
				end

				if slot5[slot16 .. "event"] and slot0.callbacks_[slot6] == nil then
					slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
				end

				table.insert(slot1, slot16)
			end

			if slot17 == uv0.WILDCARD then
				slot4 = true
			else
				if slot5["onenter" .. slot17] and slot0.callbacks_[slot6] == nil then
					slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
				end

				table.insert(slot2, slot17)
			end
		end
	end

	if slot3 then
		for slot12 = 1, #slot2 do
			if slot5["onleave" .. slot2[slot12]] and slot0.callbacks_[slot6] == nil then
				slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
			end

			if slot5[slot2[slot12] .. "event"] and slot0.callbacks_[slot6] == nil then
				slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
			end
		end
	end

	if slot4 then
		for slot12 = 1, #slot1 do
			if slot5["onenter" .. slot1[slot12]] and slot0.callbacks_[slot6] == nil then
				slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
			end
		end
	end

	if slot5.allstateevent then
		slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
	end

	if slot5.onleavestate then
		slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
	end

	if slot5.onenterstate then
		slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
	end

	if slot5.onchangestate then
		slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
	end

	if slot5.onafterevent then
		slot0.callbacks_[slot6] = handler(slot5, slot5[slot7])
	end
end

function slot1.IsReady(slot0)
	return slot0.current_ ~= "none"
end

function slot1.GetState(slot0)
	return slot0.current_
end

function slot1.IsState(slot0, slot1)
	if type(slot1) == "table" then
		for slot5, slot6 in ipairs(slot1) do
			if slot6 == slot0.current_ then
				return true
			end
		end

		return false
	else
		return slot0.current_ == slot1
	end
end

function slot1.CanDoEvent(slot0, slot1)
	return not slot0.inTransition_ and (slot0.map_[slot1][slot0.current_] ~= nil or slot0.map_[slot1][uv0.WILDCARD] ~= nil) and not slot0.exceptMap_[slot1][slot0.current_]
end

function slot1.IsFinishedState(slot0)
	return slot0:IsState(slot0.terminal_)
end

function slot1.DoEvent(slot0, slot1, slot2)
	slot6 = {
		name = slot1,
		from = slot3,
		to = slot0.map_[slot1][slot0.current_] or slot4[uv0.WILDCARD] or slot3,
		args = slot2
	}

	if slot0.inTransition_ then
		slot0:OnError_(slot6, uv0.PENDING_TRANSITION_ERROR, "event " .. slot1 .. " inappropriate because previous transition did not complete")

		return uv0.FAILURE
	end

	if not slot0:CanDoEvent(slot1) then
		return uv0.FAILURE
	end

	if not slot0:OnEvent_(slot6) then
		return uv0.CANCELLED
	end

	if slot6.to == uv0.WILDCARD then
		slot5 = slot3
		slot6.to = slot3
	else
		slot5 = slot6.to
	end

	if slot3 == slot5 then
		slot0:AfterEvent_(slot6)

		return uv0.NOTRANSITION
	end

	function slot6.transition()
		uv0.inTransition_ = false
		uv0.current_ = uv1

		uv0:EnterState_(uv2)
		uv0:ChangeState_(uv2)
		uv0:AfterEvent_(uv2)

		return uv3.SUCCEEDED
	end

	slot0.inTransition_ = true

	if slot0:LeaveState_(slot6) == false then
		slot6.transition = nil
		slot0.inTransition_ = false

		return uv0.CANCELLED
	elseif string.upper(tostring(slot7)) == uv0.ASYNC then
		return uv0.PENDING
	elseif slot6.transition then
		return slot6.transition()
	else
		slot0.inTransition_ = false
	end
end

function slot1.OnBind_(slot0)
	slot0:ExportMethods_({
		"SetupState",
		"IsReady",
		"GetState",
		"IsState",
		"CanDoEvent",
		"IsFinishedState",
		"DoEvent"
	})

	return slot0.target_
end

function slot1.OnUnbind_(slot0)
end

function slot1.AddEvent_(slot0, slot1)
	slot2 = {}

	if type(slot1.from) == "table" then
		for slot6, slot7 in ipairs(slot1.from) do
			slot2[slot7] = true
		end
	elseif slot1.from then
		slot2[slot1.from] = true
	else
		slot2[uv0.WILDCARD] = true
	end

	slot0.map_[slot1.name] = slot0.map_[slot1.name] or {}
	slot3 = slot0.map_[slot1.name]

	for slot7, slot8 in pairs(slot2) do
		slot3[slot7] = slot1.to or uv0.WILDCARD
	end

	slot0.exceptMap_[slot1.name] = slot0.exceptMap_[slot1.name] or {}

	if type(slot1.except) == "table" then
		for slot7, slot8 in ipairs(slot1.except) do
			slot0.exceptMap_[slot1.name][slot8] = true
		end
	elseif slot1.except then
		slot0.exceptMap_[slot1.name][slot1.except] = true
	end
end

function slot2(slot0, slot1)
	if slot0 then
		return slot0(slot1)
	end
end

function slot1.OnAllEvent_(slot0, slot1)
	return uv0(slot0.callbacks_.allstateevent, slot1)
end

function slot1.AfterAnyEvent_(slot0, slot1)
	return uv0(slot0.callbacks_.onafterevent, slot1)
end

function slot1.LeaveAnyState_(slot0, slot1)
	return uv0(slot0.callbacks_.onleavestate, slot1)
end

function slot1.EnterAnyState_(slot0, slot1)
	return uv0(slot0.callbacks_.onenterstate, slot1)
end

function slot1.ChangeState_(slot0, slot1)
	return uv0(slot0.callbacks_.onchangestate, slot1)
end

function slot1.AfterThisEvent_(slot0, slot1)
	return uv0(slot0.callbacks_["onafter" .. slot1.name], slot1)
end

function slot1.OnThisEvent_(slot0, slot1)
	return uv0(slot0.callbacks_[slot1.from .. "event"], slot1)
end

function slot1.LeaveThisState_(slot0, slot1)
	return uv0(slot0.callbacks_["onleave" .. slot1.from], slot1)
end

function slot1.EnterThisState_(slot0, slot1)
	return uv0(slot0.callbacks_["onenter" .. slot1.to], slot1)
end

function slot1.OnEvent_(slot0, slot1)
	slot3 = slot0:OnAllEvent_(slot1)

	if slot0:OnThisEvent_(slot1) == nil then
		if slot3 == nil then
			return true
		else
			return slot3
		end
	elseif slot3 == nil then
		return slot2
	else
		return slot2 or slot3
	end
end

function slot1.AfterEvent_(slot0, slot1)
	slot0:AfterThisEvent_(slot1)
	slot0:AfterAnyEvent_(slot1)
end

function slot1.LeaveState_(slot0, slot1, slot2)
	slot4 = slot0:LeaveAnyState_(slot1, slot2)

	if slot0:LeaveThisState_(slot1, slot2) == false or slot4 == false then
		return false
	elseif string.upper(tostring(slot3)) == uv0.ASYNC or string.upper(tostring(slot4)) == uv0.ASYNC then
		return uv0.ASYNC
	end
end

function slot1.EnterState_(slot0, slot1)
	slot0:EnterThisState_(slot1)
	slot0:EnterAnyState_(slot1)
end

function slot1.Reset(slot0)
end

function slot1.OnError_(slot0, slot1, slot2, slot3)
	printError("%s [StateMachine] ERROR: error %s, event %s, from %s to %s", tostring(slot0.target_), tostring(slot2), slot1.name, slot1.from, slot1.to)
end

return slot1
