slot0 = {}
DormHeroAINode = class("DormHeroAINode")

function DormHeroAINode.Get(slot0, slot1, ...)
	slot3 = nil

	if uv0[slot0] and #slot2 > 0 then
		slot0.Ctor(table.remove(slot2), slot1, ...)
	else
		slot3 = slot0.New(slot1, ...)
	end

	return slot3
end

function DormHeroAINode.Recycle(slot0)
	slot0:Reset()

	slot1 = uv0[slot0.class] or {}

	table.insert(slot1, slot0)

	uv0[slot0.class] = slot1
end

function DormHeroAINode.Process(slot0, slot1, ...)
	if nullable(slot0.events, slot1) then
		slot2(slot0, ...)
	end
end

function DormHeroAINode.Finish(slot0)
	return function (slot0)
		DormHeroAI:MoveNext(slot0.entityID, uv0 or IdleNode)
	end
end

slot1 = DormHeroAINode.Finish()

function DormHeroAINode.Ctor(slot0, slot1, ...)
	slot0.entityID = slot1
end

function DormHeroAINode.Reset(slot0)
end

function DormHeroAINode.Start(slot0)
end

function DormHeroAINode.Exit(slot0)
end

MoveNode = class("MoveNode", DormHeroAINode)
MoveNode.state = DormEnum.CharacterAIState.Move

function MoveNode.Start(slot0)
	slot0.scanInteractMarker = math.random()

	if slot0.targetID then
		DormEventInvoke(DORM_CHARACTER_MOVE, slot0.state, slot0.entityID, Dorm.DormEntityManager.QueryPosition(slot0.targetID), true)
	elseif slot0.targetPos then
		DormEventInvoke(DORM_CHARACTER_MOVE, slot0.state, slot0.entityID, slot0.endPosition, true)
	else
		DormEventInvoke(DORM_CHARACTER_MOVE_WANDER, slot0.state, slot0.entityID, 1.5)
	end
end

function MoveNode.OnMoveInterrupt(slot0, slot1, ...)
	if Dorm.DormEntityManager.QueryProvideInteraction(slot1) then
		Dorm.DormEntityManager.StopAllCmd(slot0.entityID)
		DormHeroAI:MoveNext(slot0.entityID, InteractNode, slot1, ...)
	end
end

MoveNode.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = slot1,
	[ON_DORM_CHARACTER_MOVE_FINISH] = slot1,
	[ON_DORM_CHARACTER_MOVE_PICK_INTERACT_AREA] = MoveNode.OnMoveInterrupt
}
InteractNode = class("InteractNode", DormHeroAINode)
InteractNode.state = DormEnum.CharacterAIState.Interact

function InteractNode.SendInteract(slot0, slot1, slot2, slot3)
	if slot2 then
		Dorm.DormEntityManager.SendInteractToEntityCMD(slot0, slot1, slot2, slot3)
	else
		Dorm.DormEntityManager.SendInteractToEntityCMD(slot0, slot1, slot3)
	end
end

function InteractNode.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.class.super.Ctor(slot0, slot1)

	slot0.targetEID = slot2
	slot0.interactPos = slot3
	slot0.exitPos = slot4
	slot0.actionID = slot5
end

function InteractNode.Start(slot0)
	DormHeroAI.GetEntityData(slot0.entityID).interactCtx = {
		entityID = slot0.entityID,
		targetID = slot0.targetEID,
		nextAction = nullable(DormInteractSequence, slot0.actionID, "next_action", 1),
		nextActionWaitTime = nullable(DormInteractSequence, slot0.actionID, "next_action", 2),
		exitPos = slot0.exitPos
	}

	Dorm.DormEntityManager.StopAllCmd(slot0.entityID)

	if slot0.interactPos then
		Dorm.DormEntityManager.SendMoveLookToDirCMD(slot0.entityID, slot0.interactPos, true, false)
	end

	slot0.SendInteract(slot0.entityID, slot0.targetEID, slot0.actionID, true)

	if slot0.exitPos and slot2.nextAction == nil then
		Dorm.DormEntityManager.SendMoveLookToDirCMD(slot0.entityID, slot0.exitPos, true, true)
	end
end

InteractNode.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = slot1
}
IdleNode = class("IdleNode", DormHeroAINode)
IdleNode.state = DormEnum.CharacterAIState.None
IdleNode.idleTimeLimit = 15

function IdleNode.Ctor(slot0, ...)
	slot0.class.super.Ctor(slot0, ...)

	slot0.lastInteractCtx = DormHeroAI.ConsumeInteractCtx(slot0.entityID)
	slot0.idleStartTime = Time.time
	slot0.idleAnimePlay = 0
	slot2 = nullable(lastInteractCtx, "nextActionWaitTime")
	slot3 = nil

	if nullable(lastInteractCtx, "nextAction") then
		slot0.waitIdleAnimePlayTimes = 0
		slot0.duringIdleAnimePlaying = false
		slot3 = slot2 or math.random(IdleNode.idleTimeLimit)
	else
		slot0.waitIdleAnimePlayTimes = math.random() > 0.5 and 1 or 0
		slot0.duringIdleAnimePlaying = false
		slot3 = math.random(IdleNode.idleTimeLimit)
	end

	slot0.idleEndTime = slot0.idleStartTime + slot3
	slot0.nextActionCtx = lastInteractCtx
end

function IdleNode.Update(slot0)
	if DormHeroAI:HasControl(slot0.entityID) then
		slot1 = Time.time

		if not (nullable(slot0, "nextActionCtx", "nextAction") == nil and slot0.duringIdleAnimePlaying) and slot0.idleEndTime < slot1 and slot0.waitIdleAnimePlayTimes <= slot0.idleAnimePlay then
			if slot2 then
				DormHeroAI:MoveNext(slot0.entityID, InteractNode, slot0.nextActionCtx.targetID, nil, slot0.nextActionCtx.exitPos, slot0.nextActionCtx.nextAction)
			else
				DormHeroAI:MoveNext(slot0.entityID, MoveNode)
			end
		end
	end
end

function IdleNode.OnAnime(slot0, slot1, slot2)
	if Dorm.DormEntityManager.IsIdleAnime(slot0.entityID, slot2) then
		if slot1 == "start" then
			slot0.idleAnimePlay = slot0.idleAnimePlay + 1
			slot0.duringIdleAnimePlaying = true
		elseif slot1 == "end" or slot1 == "end_played_once" then
			slot0.duringIdleAnimePlaying = false
		end
	end
end

function IdleNode.ClaimControl(slot0)
	DormHeroAI:SwitchControl(slot0.entityID, DormEnum.ControlType.AI)
end

function IdleNode.ReleaseControl(slot0)
	DormHeroAI:SwitchControl(slot0.entityID, DormEnum.ControlType.Player)
	DormHeroAI.ConsumeInteractCtx(slot0.entityID)
	DormHeroAI:MoveNext(slot0.entityID, IdleNode)
end

function IdleNode.OnGrabStarted(slot0)
	slot1 = nullable(slot0.lastInteractCtx, "targetID")

	slot0:ReleaseControl()
end

function IdleNode.OnGrabRelease(slot0, slot1, slot2, slot3, slot4)
	slot0:ClaimControl()

	if slot1 then
		if slot2 then
			Dorm.DormEntityManager.PutEntityAt(slot0.entityID, slot2)
		end

		DormHeroAI:MoveNext(slot0.entityID, InteractNode, slot1, nil, slot3, slot4)
	end
end

IdleNode.events = {
	[DORM_RESTAURANT_LOGIC_TICK] = IdleNode.Update,
	[ON_DORM_ENTITY_ANIME_EVENT] = IdleNode.OnAnime,
	[ON_DORM_CHARACTER_GRAB_STARTED] = IdleNode.OnGrabStarted,
	[ON_DORM_CHARACTER_GRAB_RELEASED] = IdleNode.OnGrabRelease,
	[ON_PLAYER_CLICK_INTERACT] = IdleNode.ReleaseControl,
	[DORM_RESET_HERO_AI] = IdleNode.ClaimControl
}
