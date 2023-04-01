slot0 = class("EntityManager")
slot1 = class("EntityManager.SpawnImpl")

function slot1.OnSpawn(slot0, slot1)
end

function slot1.OnRemove(slot0, slot1)
	slot0.DestroyEntity(slot1)
end

function slot1.DestroyEntity(slot0)
	Dorm.DormEntityManager.Instance:RemoveEntity(slot0)
end

function slot2()
	return nil
end

slot3 = class("EntityManager.CreateModel", slot1)

function slot3.Ctor(slot0, slot1, slot2, slot3)
	slot0.modelPathGetter = slot1
	slot0.spawnPosGetter = slot2 or uv0
	slot0.complex = slot3
end

function slot3.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:SpawnEntity(slot0.modelPathGetter(slot1), slot0.spawnPosGetter(slot1), slot0.complex or slot1.complex)
end

slot0.CreateModel = slot3
slot4 = class("EntityManager.CreatePlayer", slot1)

function slot4.Ctor(slot0, slot1, slot2)
	slot0.modelPathGetter = slot1
	slot0.spawnPosGetter = slot2 or uv0
end

function slot4.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:SpawnPlayerEntity(slot0.modelPathGetter(slot1), slot0.spawnPosGetter(slot1))
end

slot0.CreatePlayer = slot4
slot5 = class("EntityManager.CreateFurniture", slot1)

function slot5.OnSpawn(slot0, slot1)
	return DormLuaBridge.GenerateFurniture(slot1)
end

function slot5.OnRemove(slot0, slot1)
	DormLuaBridge.RemoveFurniture(slot1, true)
end

slot0.CreateFurniture = slot5
slot6 = class("EntityManager.CreateModel", slot3)

function slot6.Ctor(slot0, slot1, slot2, slot3, slot4)
	uv0.Ctor(slot0, slot1, slot2, slot4)

	slot0.pool = slot3
end

function slot6.OnSpawn(slot0, slot1)
	if slot0.pool:Allocate(slot1) == nil then
		slot3 = uv0.OnSpawn(slot0, slot1)
	end

	return slot3
end

function slot6.OnRemove(slot0, slot1)
	if not slot0.pool:Recycle(slot1) then
		uv0.OnRemove(slot0, slot1)
	end
end

slot0.PooledCreateModel = slot6
slot7 = class("EntityManager.AttachToModel", slot1)

function slot7.Ctor(slot0, slot1)
	slot0.attachRootGetter = slot1
end

function slot7.OnSpawn(slot0, slot1)
	return Dorm.DormEntityManager.Instance:MakeModelEntity(slot0.attachRootGetter(slot1))
end

slot0.AttachToModel = slot7
slot0.all = {}

setmetatable(slot0.all, {
	__mode = "v"
})

function slot0.Ctor(slot0, slot1, slot2)
	slot0.managedEntityNum = 0
	slot0.managed = {}
	slot0.reverseQuery = {}
	slot0.spawnImpl = slot1
	slot0.dataCtor = slot2

	table.insert(uv0.all, slot0)
end

function slot0.Create(slot0, slot1, slot2, slot3)
	slot4 = slot0.spawnImpl:OnSpawn(slot2)
	slot0.managed[slot1] = slot4
	slot0.reverseQuery[slot4] = slot1
	slot0.managedEntityNum = slot0.managedEntityNum + 1

	slot0:RecordNewEntityData(slot1, slot4, slot3)

	if slot0.OnCreate then
		slot0.OnCreate(slot1, slot4, slot2)
	end

	return slot4
end

function slot0.Remove(slot0, slot1)
	if slot0.managed[slot1] then
		slot0.spawnImpl:OnRemove(slot2)

		slot0.managed[slot1] = nil
		slot0.reverseQuery[slot2] = nil
		slot0.managedEntityNum = slot0.managedEntityNum - 1

		slot0:RemoveEntityData(slot2)

		if slot0.OnRemove then
			slot0.OnRemove(slot1, slot2)
		end
	end

	return slot2
end

function slot0.Update(slot0, slot1, slot2, slot3)
	slot5 = nil

	if slot0.managed[slot1] then
		slot0:Remove(slot1)
	end

	if slot2 then
		slot5 = slot0:Create(slot1, slot2, slot3)
	end

	return slot5, slot4
end

function slot0.GetEntityID(slot0, slot1)
	return slot0.managed[slot1]
end

function slot0.Find(slot0, slot1)
	return slot0.reverseQuery[slot1]
end

function slot0.Clear(slot0)
	for slot4, slot5 in pairs(slot0.managed) do
		slot0:Remove(slot4)
	end
end

function slot0.EntityNum(slot0)
	return slot0.managedEntityNum
end

function slot0.RecordNewEntityData(slot0, slot1, slot2, slot3)
	slot4 = DormEnum.Namespace.EntityData

	if slot0.dataCtor then
		Dorm.storage:RecordData(slot4, slot2, slot0.dataCtor(slot1, slot2, slot3))
	else
		Dorm.storage:RecordData(slot4, slot2, slot3 or {})
	end
end

function slot0.ResetAllEntityData(slot0)
	for slot4, slot5 in pairs(slot0.managed) do
		slot0:RecordNewEntityData(slot4, slot5)
	end
end

function slot0.RemoveEntityData(slot0, slot1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, slot1, nil)
end

function slot0.FindAndRemoveEntity(slot0, slot1)
	for slot5, slot6 in pairs(slot0) do
		if slot6:Find(slot1) then
			return slot6:Remove(slot7)
		end
	end
end

function slot0.ValidateEntity(slot0, slot1)
	for slot5, slot6 in pairs(slot0) do
		if slot6:Find(slot1) then
			return slot7, slot6
		end
	end
end

return slot0
