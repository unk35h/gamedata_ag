slot1 = class("Chain", import("..BehaviourBase"))

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, "ChainBehaviour")

	slot0.father_ = slot1
	slot0.children_ = {}
	slot0.active_ = true
	slot0.handleChainEventCallbackName_ = slot2 or "HandleChainEvent"
end

function slot1.AddChainChild(slot0, slot1)
	table.insert(slot0.children_, slot1)
end

function slot1.RemoveChainChild(slot0, slot1)
	slot2 = table.removebyvalue(slot0.children_, slot1)
end

function slot1.SetChainFather(slot0, slot1)
	slot0.father_ = slot1
end

function slot1.DispatchEventInChain(slot0, slot1)
	slot1.stop_ = false

	function slot1.stop(slot0)
		slot0.stop_ = true
	end

	slot0:DoDispatchEventInChain(slot1, {})
end

function slot1.DoDispatchEventInChain(slot0, slot1, slot2)
	if table.indexof(slot2, slot0.target_) ~= false then
		return
	end

	table.insert(slot2, slot0.target_)

	if slot0.active_ then
		slot0.target_[slot0.handleChainEventCallbackName_](slot0.target_, slot1)

		if slot1.stop_ then
			return
		end
	end

	for slot6, slot7 in pairs(slot0.children_) do
		if table.indexof(slot2, slot7) == false then
			slot7:DoDispatchEventInChain(slot1, slot2)

			if slot1.stop_ then
				return
			end
		end
	end

	if slot0.father_ and table.indexof(slot2, slot0.father_) == false then
		slot0.father_:DoDispatchEventInChain(slot1, slot2)

		if slot1.stop_ then
			return
		end
	end
end

function slot1.SetHandleChainActive(slot0, slot1)
	slot0.active_ = slot1
end

function slot1.OnBind_(slot0)
	slot0:ExportMethods_({
		"SetHandleChainActive",
		"AddChainChild",
		"RemoveChainChild",
		"SetChainFather",
		"DispatchEventInChain",
		"DoDispatchEventInChain"
	})

	if slot0.father_ then
		slot0.father_:AddChainChild(slot0.target_)
	end

	slot0.target_:BindMethod(slot0, "Dispose", slot0.Dispose)

	return slot0.target_
end

function slot1.OnUnbind_(slot0)
	slot0:Dispose()
	slot0.target_:UnbindMethod(slot0, "Dispose")
end

function slot1.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.children_) do
		slot5:SetChainFather(slot0.father_)
		slot0.father_:AddChainChild(slot5)
	end

	slot0.father_:RemoveChainChild(slot0.target_)

	slot0.father_ = nil
	slot0.children_ = nil
end

return slot1
