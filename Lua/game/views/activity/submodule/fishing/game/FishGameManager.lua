slot0 = singletonClass("FishGameManager")
slot1 = {}
slot2, slot3 = nil
slot4 = 0
slot5 = 0
slot6 = 0
slot7 = 0
slot8 = 0
slot9 = 0
slot10 = 0
slot11 = false
slot12 = 0
slot13 = 0
slot14 = "idle"
slot15 = {}

function slot0.Init(slot0, slot1, slot2)
	slot0.gameView_ = slot1
	slot0.gameRootContainer_ = slot2

	if not uv0 then
		uv0 = FrameTimer.New(handler(slot0, slot0.Update), 1, -1)
	end

	uv0:Start()
end

function slot0.Start(slot0)
	slot0.pausing_ = false
	uv0 = false
	uv1 = 0
	uv2 = 0
	uv3 = 60
	uv4 = 0
	uv5 = 0
	uv6 = 0
	uv7 = "idle"
	uv8 = manager.time:GetServerTime()

	manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
end

function slot0.RegisterEvents(slot0)
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, handler(slot0, slot0.OnGameFocusChange))
end

function slot0.RemoveEvents(slot0)
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, handler(slot0, slot0.OnGameFocusChange))
end

function slot0.OnGameFocusChange(slot0, slot1, slot2)
	if slot2 then
		slot0:Pause()
	end
end

function slot0.GetFishes(slot0)
	return uv0
end

function slot0.AddFish(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.RemoveFish(slot0, slot1)
	if table.indexof(uv0, slot1) then
		table.remove(uv0, slot2)
	end
end

function slot0.CheckEnd(slot0)
	if #uv0 <= 0 then
		uv1 = true
	end

	slot1 = false

	for slot5, slot6 in ipairs(uv0) do
		if GameFishCfg[slot6:GetData().fishId].score > 0 then
			slot1 = true
		end
	end

	if not slot1 then
		uv1 = true
	end
end

function slot0.RemoveAllFishes(slot0)
	for slot4, slot5 in pairs(uv0) do
		slot5:Dispose()
	end

	uv0 = {}
end

function slot0.SetHook(slot0, slot1)
	uv0 = slot1
end

function slot0.SetScoreAddHandler(slot0, slot1)
	slot0.onScoreAddHandler = slot1
end

function slot0.SetPauseHandler(slot0, slot1)
	slot0.pauseHandler_ = slot1
end

function slot0.SetContinueHandler(slot0, slot1)
	slot0.continueHandler_ = slot1
end

function slot0.SetScoreChangeHandler(slot0, slot1)
	slot0.scoreChangeHandler_ = slot1
end

function slot0.AddBuffHandler(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.Pause(slot0)
	slot0.pausing_ = true

	if slot0.pauseHandler_ then
		slot0.pauseHandler_()
	end

	manager.audio:PlayEffect("minigame_fishing", "fishing_pauseall", "")
end

function slot0.Continue(slot0)
	slot0.pausing_ = false

	if slot0.continueHandler_ then
		slot0.continueHandler_()
	end

	manager.audio:PlayEffect("minigame_fishing", "fishing_resumeall", "")
end

function slot0.Update(slot0)
	if slot0.pausing_ then
		uv0 = uv0 + Time.deltaTime

		return
	end

	slot0.gameView_:Update(Time.deltaTime)

	if uv1 then
		return
	end

	slot5 = slot1

	slot0.gameView_:Update(slot5)

	for slot5, slot6 in ipairs(uv2) do
		slot6:Update(slot1)
	end

	if uv3 ~= nil then
		uv3:Update(slot1)
	end

	uv4 = uv4 - slot1

	if uv4 <= 0 then
		uv1 = true
	end

	if uv5 ~= 0 then
		slot2 = manager.time:GetServerTime() - uv0 - uv6

		if uv7 ~= nil and #uv7 > 0 then
			for slot6, slot7 in ipairs(uv7) do
				if uv8 - slot2 <= 0 then
					if uv5 == 1 then
						manager.audio:PlayEffect("minigame_fishing", "fishing_buff_double_stop", "")
					elseif uv5 == 2 then
						manager.audio:PlayEffect("minigame_fishing", "fishing_buff_electric_stop", "")
					end

					uv8 = 0
					uv5 = 0
					uv6 = 0

					slot7(0, 0, 0)
				else
					slot7(uv5, 2, slot8)
				end
			end
		end
	end

	if slot0.currentDisappearItem_ ~= nil then
		slot0.flySeconds_ = slot0.flySeconds_ + Time.deltaTime
		slot0.currentDisappearItem_.gameObject_.transform.localPosition = slot0.gameView_.gameObject_.transform:InverseTransformPoint({
			x = slot0.startPos_.x + slot0.flySeconds_ * (slot0.targetPos_.x - slot0.startPos_.x),
			y = slot0.startPos_.y + slot0.flySeconds_ * (slot0.targetPos_.y - slot0.startPos_.y),
			z = slot0.startPos_.z + slot0.flySeconds_ * (slot0.targetPos_.z - slot0.startPos_.z)
		})
		slot4 = 1 - 0.5 * slot0.flySeconds_
		slot0.currentDisappearItem_.gameObject_.transform.localScale = Vector3(slot4, slot4, slot4)

		if slot0.flySeconds_ > 1 then
			slot0.flySeconds_ = 1

			slot0.gameView_:AppearBubble(slot0:GetTreasureLimitNum())

			if slot0.fishDisappearCallback_ ~= nil then
				slot0.fishDisappearCallback_(slot0.currentDisappearItem_)

				slot0.fishDisappearCallback_ = nil
				slot0.currentDisappearItem_ = nil
			end
		end
	end
end

function slot0.GetGameRoot(slot0)
	return slot0.gameRootContainer_
end

function slot0.AddScore(slot0, slot1)
	if uv0 == 1 then
		slot1 = slot1 * 2
	end

	uv1 = uv1 + slot1

	if slot0.onScoreAddHandler then
		slot0.onScoreAddHandler(slot1)
	end

	if slot0.scoreChangeHandler_ ~= nil then
		slot0.scoreChangeHandler_()
	end
end

function slot0.PlayFishDisappear(slot0, slot1, slot2)
	if slot1:GetData().fishId ~= 5 then
		slot2(slot1)
	else
		slot0.currentDisappearItem_ = slot1
		slot3 = slot1.transform_.eulerAngles
		slot3.z = 0
		slot1.transform_.eulerAngles = slot3
		slot1.transform_.pivot = Vector2(0.5, 0.5)

		slot0.currentDisappearItem_.gameObject_.transform:SetParent(slot0.gameView_.gameObject_.transform)

		slot0.startPos_ = slot0.currentDisappearItem_.gameObject_.transform:TransformPoint(0, 0, 0)
		slot0.targetPos_ = slot0.gameView_:GetBubbleTarget():TransformPoint(0, 0, 0)
		slot0.flySeconds_ = 0
		slot0.fishDisappearCallback_ = slot2
	end
end

function slot0.ResetScore(slot0)
	uv0 = 0

	if slot0.scoreChangeHandler_ ~= nil then
		slot0.scoreChangeHandler_()
	end
end

function slot0.GetScore(slot0)
	return uv0
end

function slot0.GetBuff(slot0)
	return uv0
end

function slot0.GetSeconds(slot0)
	return uv0
end

function slot0.GetIsEnd(slot0)
	return uv0
end

function slot0.RandomBuff(slot0)
	uv0 = math.random(1, 3)

	if uv0 == 1 then
		uv1 = 20

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_double", "")
	elseif uv0 == 2 then
		uv1 = 10

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_electric", "")
	elseif uv0 == 3 then
		uv1 = 20

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_freeze", "")
	end

	uv2 = manager.time:GetServerTime()

	for slot4, slot5 in ipairs(uv3) do
		if slot5 ~= nil then
			slot5(uv0, 1, uv1)
		end
	end
end

function slot0.AddTreasure(slot0)
	uv0 = uv0 + 1
	uv1 = uv1 + 1
	uv1 = math.min(uv1, GameSetting.activity_fishing_fish_max.value[1])
end

function slot0.GetTreasureNum(slot0)
	return uv0
end

function slot0.GetTreasureLimitNum(slot0)
	return uv0
end

function slot0.SetStatus(slot0, slot1)
	uv0 = slot1
end

function slot0.GetStatus(slot0)
	return uv0
end

function slot0.Reset(slot0)
	if uv0 then
		uv0:Reset()

		uv0 = nil
	end

	uv1:Stop()

	uv2 = {}

	slot0:RemoveEvents()
	slot0:RemoveAllFishes()
end

function slot0.Dispose(slot0)
	if slot0.currentDisappearItem_ then
		slot0.currentDisappearItem_:Dispose()

		slot0.currentDisappearItem_ = nil
	end

	if uv0 then
		uv0:Dispose()

		uv0 = nil
	end

	uv1 = {}

	uv2:Stop()
	slot0:RemoveEvents()
	slot0:RemoveAllFishes()
end

return slot0
