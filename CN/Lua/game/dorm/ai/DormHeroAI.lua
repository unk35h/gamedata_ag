import(".DormHeroAINode")

slot0 = singletonClass("DormHeroAI")
slot1 = {
	interactState = "interactState",
	moveState = "moveState",
	StartState = "StartState"
}

function slot0.Ctor(slot0)
	slot0.characterList = {}
	slot0.listener = EventListener.New()
end

function slot0.Init(slot0)
	slot0:RegisterEvent()
end

function slot0.AddCharacterAI(slot0, slot1)
	if slot0.characterList[slot1] then
		print(slot1 .. "对象已激活ai")

		return
	end

	slot2 = {
		controlType = DormEnum.ControlType.AI,
		curNode = DormHeroAINode.Get(IdleNode, slot1)
	}

	slot2.curNode:Start()

	slot0.characterList[slot1] = slot2
end

function slot0.RemoveCharacterAI(slot0, slot1)
	slot2 = slot0.characterList[slot1].curNode

	slot2:Exit()
	DormHeroAINode.Recycle(slot2)

	slot0.characterList[slot1] = nil
end

function slot0.Clear(slot0)
	for slot4, slot5 in pairs(slot0.characterList) do
		slot6 = slot5.curNode

		slot6:Exit()
		DormHeroAINode.Recycle(slot6)
	end

	slot0.characterList = {}
end

function slot0.RegisterEvent(slot0)
	slot5 = slot0
	slot6 = slot0.OnCmdAbort

	for slot5, slot6 in pairs({
		[DORM_DORMITORY_NEW_HERO] = handler(slot0, slot0.AddCharacterAI),
		[DORM_RESTAURANT_LOGIC_TICK] = handlerArg1(slot0, slot0.ProcessUpdate),
		[ON_DORM_CHARACTER_CMD_ABORTED] = handler(slot5, slot6)
	}) do
		slot0.listener:Register(slot5, slot6)
	end

	for slot6, slot7 in ipairs({
		ON_DORM_CHARACTER_MOVE_FINISH,
		ON_DORM_CHARACTER_INTERACT_FINISH,
		ON_DORM_CHARACTER_WAIT_CMD,
		ON_DORM_ENTITY_ANIME_EVENT,
		ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA,
		ON_DORM_CHARACTER_GRAB_STARTED,
		ON_DORM_CHARACTER_GRAB_RELEASED,
		ON_PLAYER_CLICK_INTERACT,
		DORM_RESET_HERO_AI
	}) do
		slot0.listener:Register(slot7, handlerArg1(slot0, slot0.ProcessEvent, slot7))
	end
end

function slot0.ProcessUpdate(slot0)
	for slot4, slot5 in pairs(slot0.characterList) do
		slot0:ProcessEvent(DORM_RESTAURANT_LOGIC_TICK, slot4)
	end
end

function slot0.ProcessEvent(slot0, slot1, slot2, ...)
	if slot0.characterList[slot2] then
		DormHeroAINode.Process(slot3.curNode, slot1, ...)
	end
end

function slot0.OnCmdAbort(slot0, slot1)
	if slot0.characterList[slot1] then
		slot0:MoveNext(slot1, IdleNode)
	end
end

function slot0.MoveNext(slot0, slot1, slot2, ...)
	slot3 = slot0.characterList[slot1]

	slot3.curNode:Exit()
	DormHeroAINode.Recycle(slot3.curNode)

	slot3.curNode = DormHeroAINode.Get(slot2 or IdleNode, slot1, ...)

	slot3.curNode:Start()
end

function slot0.HasControl(slot0, slot1)
	return slot0.characterList[slot1].controlType == DormEnum.ControlType.AI
end

function slot0.SwitchControl(slot0, slot1, slot2)
	slot0.characterList[slot1].controlType = slot2

	if slot2 == DormEnum.ControlType.Player then
		-- Nothing
	elseif slot2 == DormEnum.ControlType.AI then
		-- Nothing
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.characterList) do
		DormHeroAINode.Recycle(slot5.curNode)
	end

	slot0.characterList = {}

	slot0.listener:RemoveAll()
end

function slot0.GetEntityData(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
end

function slot0.ConsumeInteractCtx(slot0)
	slot1 = Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
	slot1.interactCtx = nil

	return slot1.interactCtx
end

return slot0.GetInstance()
