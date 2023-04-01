slot0 = class("RouteComponent")

function slot0.Ctor(slot0, slot1)
	slot0.vueRoute_ = slot1
end

function slot0.AsyncInit(slot0)
end

function slot0.Init(slot0)
end

function slot0.Dispose(slot0)
end

function slot0.OnUpdate(slot0)
end

function slot0.Go(slot0, slot1)
	slot0.vueRoute_:Go(slot1)
end

function slot0.Back(slot0)
	slot0.vueRoute_:Back()
end

return slot0
