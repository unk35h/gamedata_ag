slot0 = class("RouteRecord")

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.name_ = slot1
	slot0.path_ = slot2
	slot0.parent_ = slot3
	slot0.components_ = {}
	slot0.componentNames_ = slot4
	slot0.wraps_ = slot5 or {}
end

function slot0.NewComponents(slot0)
	if slot0.componentNames_.__cname then
		slot0.components_.default = slot1.New()
	else
		for slot5, slot6 in pairs(slot1) do
			slot0.components_[slot5] = slot6.New()
		end
	end
end

function slot0.GetName(slot0)
	return slot0.name_
end

function slot0.GetPath(slot0)
	return slot0.path_
end

function slot0.SetParent(slot0, slot1)
	slot0.parent_ = slot1
end

function slot0.GetParent(slot0)
	return slot0.parent_
end

function slot0.GetComponent(slot0)
	return slot0.components_
end

function slot0.SetParams(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.GetParams(slot0)
	return slot0.params_
end

function slot0.GetWraps(slot0)
	return slot0.wraps_
end

function slot0.Init(slot0, slot1)
	slot0:NewComponents()

	for slot5, slot6 in pairs(slot0.components_) do
		slot6:SyncInit(slot1)
	end
end

function slot0.OnTop(slot0)
	for slot4, slot5 in pairs(slot0.components_) do
		slot5:OnTop()
	end
end

function slot0.OnBehind(slot0)
	for slot4, slot5 in pairs(slot0.components_) do
		slot5:OnBehind()
	end
end

function slot0.OnUpdate(slot0, slot1)
	for slot5, slot6 in pairs(slot0.components_) do
		if slot1 then
			slot6:SetParams(slot1)
		end

		slot6:OnUpdate()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.components_) do
		slot5:OnUnload()
	end

	slot0:DestroyComponents()
end

function slot0.DestroyComponents(slot0)
	for slot4, slot5 in pairs(slot0.components_) do
		slot0.components_[slot4] = nil
	end
end

return slot0
