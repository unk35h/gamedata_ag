slot1 = class("DoubleBuffer", import("..BehaviourBase"))
slot2 = 0

function slot1.Ctor(slot0)
end

function slot1.Next(slot0)
	return 1 - uv0
end

function slot1.Swap(slot0)
	uv0 = uv1.Next()
end

function slot1.OnBind_(slot0)
	slot0:ExportMethods_({
		"Next"
	})

	return slot0.target_
end

function slot1.OnUnbind_(slot0)
end

return slot1
