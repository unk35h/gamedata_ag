slot1 = {
	AnyPeer = 2,
	Source = 0,
	Target = 1
}

function slot2(slot0, slot1)
	if slot0 == uv0.Source then
		return slot1.entityID
	elseif slot0 == uv0.Target then
		return slot1.targetID
	elseif slot1.peerIDs and #slot1.peerIDs > 0 then
		return slot1.peerIDs[math.random(#slot1.peerIDs)]
	end

	return nil
end

slot3 = {
	play = function (slot0, slot1)
		Dorm.DormEntityManager.PlayAnimeDuringInteract(uv0(slot0.entity, slot1), slot0.animeActionName, slot0.animeActionSubName, slot0.crossFade)
	end,
	putAt = function (slot0, slot1)
		Dorm.DormEntityManager.PutEntityAt(uv0(slot0.entity, slot1), uv0(slot0.referenceTarget, slot1), slot0.referencePointName)
	end,
	grabPart = function (slot0, slot1)
		Dorm.DormEntityManager.GrabItemPartCMD(uv0(slot0.grabBy, slot1), uv0(slot0.grabFrom, slot1), slot0.itemPartName, slot0.attachPoint)
	end,
	restorePart = function (slot0, slot1)
		Dorm.DormEntityManager.RestoreItemPartCMD(uv0(slot0.itemPartHost, slot1), slot0.itemPartName)
	end,
	changeScheme = function (slot0, slot1)
		Dorm.DormEntityManager.ChangeEntityAnimeScheme(uv0(slot0.entity, slot1), slot0.scheme)
	end,
	setValue = function (slot0, slot1)
		Dorm.storage:GetData(DormEnum.Namespace.EntityData, uv0(slot0.entity, slot1))[slot0.field] = slot0.value
	end,
	setMobility = function (slot0, slot1)
		Dorm.DormEntityManager.SetEntityMobility(uv0(slot0.entity, slot1), slot0.value)
	end,
	setMouth = function (slot0, slot1)
		Dorm.DormEntityManager.SetFacialExpression(uv0(slot0.entity, slot1), slot0.value)
	end,
	setFace = function (slot0, slot1)
		Dorm.DormEntityManager.PlayNormalFacileExpression(uv0(slot0.entity, slot1), slot0.faceEmoteState, slot0.faceEmoteSubState, slot0.crossFade)
	end,
	keepAsInteract = function (slot0, slot1)
		Dorm.DormEntityManager.KeepAsInteractNotEnd(uv0(slot0.entity, slot1), uv0(slot0.target, slot1), slot0.value)
	end,
	setSpFace = function (slot0, slot1)
		Dorm.DormEntityManager.PlaySpacialFacileExpression(uv0(slot0.entity, slot1), slot0.faceEfxPath, slot0.duration)
	end,
	playEfx = function (slot0, slot1)
		Dorm.DormEntityManager.PlayEffect(uv0(slot0.entity, slot1), slot0.attachPoint, slot0.efxPath, slot0.duration)
	end,
	clearEfx = function (slot0, slot1)
		Dorm.DormEntityManager.ClearAllEffectOnAttachPoint(uv0(slot0.entity, slot1), slot0.attachPoint)
	end,
	playVoice = function (slot0, slot1)
		manager.audio:Play(slot0.playerType, slot0.sheet, slot0.cue, slot0.awb)
	end,
	stopVoice = function (slot0, slot1)
		manager.audio:Stop(slot0.playerType)
	end,
	playSubtitle = function (slot0, slot1)
		manager.notify:Invoke(DORM_CHARACTER_PLAY_SUBTITLE, uv0(slot0.entity, slot1), slot0.subtitleID)
	end
}

function slot4(...)
	return DormCharacterActionManager.frameTaskRunner:NewTask(...)
end

function slot5(slot0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, slot0)
end

function slot6(slot0, slot1, slot2)
	return {
		entityID = slot0,
		targetID = slot1,
		nextAction = nullable(DormInteractSequence, slot2, "next_action", 1),
		nextActionWaitTime = nullable(DormInteractSequence, slot2, "next_action", 2)
	}
end

return {
	DriveInteractSequenceNode = function (slot0, slot1)
		if uv0[slot0.action] then
			slot3(slot0, slot1)
		end
	end,
	StartInteractTask = function (slot0, slot1, slot2, slot3)
		slot3 = slot3 or false
		slot4 = slot0.sequence
		slot5 = slot0.keys

		Dorm.DormEntityManager.KeepAsInteractNotEnd(slot1.entityID, slot1.targetID, false)

		slot6 = uv0({
			start = Time.time
		})

		slot6:SetCancellationSrc(function ()
			return uv0.canceled
		end)
		slot6:WaitUntil(function (slot0)
			slot2 = slot0.k
			slot3 = Time.time - slot0.taskDataCtx.start

			while slot2 <= #uv0 and uv0[slot2] <= slot3 do
				slot7 = uv0[slot2]

				for slot7, slot8 in ipairs(uv1[slot7]) do
					uv2.DriveInteractSequenceNode(slot8, uv3)
				end

				slot2 = slot2 + 1
			end

			slot0.k = slot2

			return slot2 > #uv0 or uv4.duration <= slot3
		end, false, {
			k = 1
		})
		slot6:WaitUntil(function (slot0)
			return uv0.duration <= Time.time - slot0.taskDataCtx.start
		end)
		slot6:Then(function ()
			if uv0 then
				Dorm.DormEntityManager.KeepAsInteractNotEnd(uv1.entityID, uv1.targetID, true)
			end

			uv2:Notify()
		end)
		slot6:Start()
	end,
	Interact = function (slot0, slot1, slot2, slot3)
		slot4 = uv0(slot0)
		slot6 = slot4.interactCtx or uv1(slot0, slot1, slot3)

		if uv2.GetSequence(slot4.cfgID, uv0(slot1).cfgID, slot3) then
			uv2.StartInteractTask(slot8, slot6, slot2, nullable(DormInteractSequence, slot3, "continuous"))
		else
			if slot6.exitPos then
				Dorm.DormEntityManager.PutEntityAt(slot0, slot6.exitPos)
			end

			slot2.Notify(slot2, false)
		end
	end,
	GetSequence = function (slot0, slot1, slot2)
		slot3 = nullable(DormInteractSequence, slot2, "name")
		slot9 = slot3
		slot8 = slot3

		for slot8, slot9 in ipairs({
			string.format("game.dorm.interacts.%d.%d_%s", slot0, slot1, slot3),
			string.format("game.dorm.interacts.%d.%s", slot0, slot9),
			string.format("game.dorm.interacts.%s", slot8)
		}) do
			if package.loaded[slot9] and type(slot10) == "table" then
				return slot10
			end
		end
	end,
	Init = function (slot0)
		manager.notify:RegistListener(ON_DORM_CHARACTER_INTERACT, slot0.Interact)
	end,
	Reset = function (slot0)
		manager.notify:RemoveListener(ON_DORM_CHARACTER_INTERACT, slot0.Interact)
	end
}
