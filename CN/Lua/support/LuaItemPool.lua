slot0 = class("LuaItemPool")
slot1 = 30

function slot0.Ctor(slot0, slot1, slot2)
	slot0.uselessParent_ = GameObject.Find("/Pool").transform
	slot0._templatePath = slot2
	slot0._class = slot1
	slot0._pool = {}
end

function slot0.LoadItem(slot0, slot1)
	slot0._template = Asset.Load(slot0._templatePath)

	for slot5 = 1, slot1 do
		slot0:AddPool()
	end
end

function slot0.AddPool(slot0, slot1)
	if not slot0._template then
		slot0._template = Asset.Load(slot0._templatePath)
	end

	slot2 = nil
	slot0._pool[#slot0._pool + 1] = slot0._class.New((not slot1 or Object.Instantiate(slot0._template, slot1.transform)) and Object.Instantiate(slot0._template, slot0.uselessParent_.transform))
end

function slot0.Get(slot0, slot1)
	if #slot0._pool >= 1 then
		slot2 = slot0._pool[#slot0._pool]
		slot0._pool[#slot0._pool] = nil

		slot2.gameObject_.transform:SetParent(slot1.transform, false)

		return slot2
	end

	slot0:AddPool(slot1)

	slot0._pool[#slot0._pool] = nil

	return slot0._pool[#slot0._pool]
end

function slot0.Release(slot0, slot1)
	slot1.transform_:SetParent(slot0.uselessParent_, false)

	slot0._pool[#slot0._pool + 1] = slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0._pool) do
		Object.Destroy(slot5.gameObject_)
		slot5:Dispose()
	end

	slot0._pool = nil
	slot0._template = nil
end

return slot0
