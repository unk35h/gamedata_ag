slot0 = singletonClass("RestaurantCharacterAction")

function slot0.Ctor(slot0)
	slot0.listener = EventListener.New()
	slot0.taskRunner = DormTaskRunner.New()
	slot0.frameTaskRunner = DormTaskRunner.New()
end

function slot0.Init(slot0)
	slot0.animationEventHandlers = {}

	slot0.taskRunner:Init()
	slot0.frameTaskRunner:Init()

	slot0.tickCount = 0
	slot0.tick = Timer.New(function ()
		uv0.tickCount = uv0.tickCount + 1

		if uv0.tickCount % 2 == 0 then
			manager.notify:Invoke(DORM_LOGIC_TICK)
		end

		if uv0.tickCount % 15 == 7 then
			manager.notify:Invoke(DORM_RESTAURANT_LOGIC_TICK)
		end
	end, 0.016666666666666666, -1)

	slot0.tick:Start()
	slot0.listener:Register(DORM_LOGIC_TICK, handler(slot0.frameTaskRunner, slot0.frameTaskRunner.TickUpdate))
	slot0.listener:Register(DORM_RESTAURANT_LOGIC_TICK, handler(slot0.taskRunner, slot0.taskRunner.TickUpdate))
	slot0.listener:Register(ON_DORM_ENTITY_ANIME_EVENT, handler(slot0, slot0.HandleAnimationLoop))
end

function slot0.Reset(slot0)
	slot0.listener:RemoveAll()

	if slot0.tick then
		slot0.tick:Stop()
	end

	slot0.taskRunner:Reset()
	slot0.frameTaskRunner:Reset()
end

function slot0.HandleAnimationLoop(slot0, slot1, slot2, slot3)
	if slot0.animationEventHandlers then
		slot0.inAnimationHandleLoop = true
		slot4 = {}

		for slot8, slot9 in ipairs(slot0.animationEventHandlers) do
			if not slot9(slot1, slot2, slot3) then
				table.insert(slot4, slot9)
			end
		end

		slot0.animationEventHandlers = slot4
		slot0.inAnimationHandleLoop = false
	end
end

function slot0.RegisterAnimeEvent(slot0, slot1)
	table.insert(slot0.animationEventHandlers, slot1)
end

return slot0.GetInstance()
