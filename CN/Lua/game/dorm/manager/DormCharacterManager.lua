slot0 = singletonClass("DormCharacterManager")
slot2 = (function (slot0)
	return function (slot0)
		return "CharDorm/" .. nullable(uv0, nullable(slot0, "heroID"), "model")
	end
end)(BackHomeHeroCfg)
slot3 = 1.25
slot4 = DormEnum.CharacterType.DormNormalHero

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot2 = EntityManager.New(EntityManager.CreatePlayer.New(uv0))

	function slot2.OnCreate(slot0, slot1, slot2)
		Dorm.DormEntityManager.StartFadeInCMD(slot1, uv0)
		uv1:RecordEntityInfo(slot1, slot2)
	end

	function slot2.OnRemove(slot0, slot1)
		uv0:RemoveEntityInfo(slot1)
		manager.notify:Invoke(DORM_CHARACTER_DISPOSE, slot1, uv1)
	end

	slot0.entityManager = slot2
	slot0.listener = EventListener.New()
end

function slot0.RecordEntityInfo(slot0, slot1, slot2)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, uv0)
end

function slot0.EIdNamespace(slot0)
	return "entity." .. slot0 .. ".eid"
end

function slot0.IdxNamespace(slot0)
	return "entity." .. slot0 .. ".idx"
end

function slot0.RemoveEntityInfo(slot0, slot1)
	Dorm.storage:RecordData(DormEnum.Namespace.EntityType, slot1, nil)
end

function slot0.Init(slot0)
	slot0:RegisterEvent()

	slot0.dormHeroAI = DormHeroAI.GetInstance()

	slot0.dormHeroAI:Init()
	slot0.entityManager:Clear()
	Dorm.storage:MapToData(uv0.EIdNamespace(uv1), slot0.entityManager.managed)
	Dorm.storage:MapToData(uv0.IdxNamespace(uv1), slot0.entityManager.reverseQuery)
end

function slot0.Reset(slot0)
	slot0:RemoveEvent()
	slot0.dormHeroAI:Dispose()
	slot0:Clear()
end

function slot0.RegisterEvent(slot0)
	slot0.listener:Register(ON_BEGIN_STORY, handler(slot0, slot0.OnBeginStory))
	slot0.listener:Register(ON_FINISH_STORY, handler(slot0, slot0.OnFinishStory))
end

function slot0.RemoveEvent(slot0)
	slot0.listener:RemoveAll()
end

function slot0.OnBeginStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		slot0:Clear()
	end
end

function slot0.OnFinishStory(slot0, slot1)
	if DormEnum.HasFlag(slot1, DormEnum.BeginStoryFlag.HideCharacter) then
		DormTools:GenerateHeroWhenEnterScene()
	end
end

function slot0.Generate(slot0, slot1)
	slot2 = slot0.entityManager:Update(slot1, {
		heroID = slot1
	}, {
		cfgID = slot1
	})

	slot0.dormHeroAI:AddCharacterAI(slot2)
	Dorm.DormEntityManager.SetEntitySpeedCMD(slot2, 0.5)

	return slot2
end

function slot0.Remove(slot0, slot1)
	slot0.dormHeroAI:RemoveCharacterAI(slot0.entityManager:Remove(slot1))
end

function slot0.Clear(slot0)
	slot0.entityManager:Clear()
	slot0.dormHeroAI:Clear()
end

function slot0.FindAndRemove(slot0)
	slot1 = uv0.GetInstance()

	EntityManager.FindAndRemoveEntity({
		slot1.entityManager
	}, slot0)
	slot1.dormHeroAI:RemoveCharacterAI(slot0)
end

return slot0
