slot0 = singletonClass("DormFurnitureManager")
slot0.FurnitureState = {
	Placed = 1,
	Editing = 2,
	Hanging = 0
}
slot1 = 0

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot0.entityManager = EntityManager.New(EntityManager.CreateFurniture.New())
	slot0.nextIdx = uv0
end

function slot0.Init(slot0)
	slot0:RegisterEvent()
end

function slot0.Reset(slot0)
	slot0:RemoveEvent()
end

function slot0.RegisterEvent(slot0)
	slot0.listener:Register(ON_BEGIN_STORY, handler(slot0, slot0.OnBeginStory))
	slot0.listener:Register(ON_FINISH_STORY, handler(slot0, slot0.OnFinishStory))
end

function slot0.RemoveEvent(slot0)
	slot0.listener:RemoveAll()
end

function slot0.OnBeginStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideFurniture) then
		slot0:Clear()
	end
end

function slot0.OnFinishStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideFurniture) then
		DormTools:GenerateFurnitureWhenEnterScene()
	end
end

function slot0.Generate(slot0, slot1)
	slot0.nextIdx = slot0.nextIdx + 1

	return slot0.entityManager:Update(slot0.nextIdx, slot1, uv0.dataCtor(slot1))
end

function slot0.Remove(slot0, slot1)
	slot0.entityManager:Remove(slot1)
end

function slot0.Clear(slot0)
	slot0.entityManager:Clear()
	DormLuaBridge.ClearFurnitureOccupy()
	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()

	slot0.nextIdx = uv0
end

function slot0.dataCtor(slot0)
	return {
		cfgID = slot0
	}
end

function slot2(slot0, slot1)
	if slot1 + 1 < slot0.Length then
		return slot1, slot0[slot1]
	end
end

function slot0.ClearAndGenByFurList(slot0, slot1)
	slot0:Clear()

	if slot1 then
		DormLuaBridge.SyncRoomFurniture(slot1)

		for slot5, slot6 in uv0, slot1, -1 do
			slot7 = slot6.id
			slot8 = slot0.entityManager:Create(slot5, slot7, uv1.dataCtor(slot7))

			DormLuaBridge.RecoverRoomFurnitureOccupy(slot5, slot8)
			DormLuaBridge.ChangeFurnitureState(slot8, uv1.FurnitureState.Placed)
		end

		slot0.nextIdx = slot1.Length
	else
		slot0.nextIdx = 0
	end

	DormLuaBridge.UpdateAllWallMountDitherAlphaControl()
end

function slot0.FindAndRemove(slot0)
	EntityManager.FindAndRemoveEntity({
		uv0.GetInstance().entityManager
	}, slot0)
end

return slot0
