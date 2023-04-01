slot0 = class("HeroAvatarView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.isShowInteractive_ = false
	slot0.isEnterToThisView = true

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.playable_ = slot0:FindCom(typeof(PlayableDirector), "")
	slot0.backGo_ = slot0:FindGo("back")
	slot0.cameraPosOffSet_ = Vector3.zero
	slot0.cameraRotateOffSet_ = Vector3.zero
end

function slot0.SetShowInteractive(slot0, slot1)
	slot0.isShowInteractive_ = slot1

	if slot1 then
		if slot0.interactionTimer_ then
			slot0.interactionTimer_:Reset()
		end

		if slot0.timer_ then
			slot0.timer_:Reset()
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddDragListener(slot0.backGo_, function ()
		if uv0.heroModel_ then
			uv0.startRot_ = uv0.rotateNode_.localEulerAngles
		else
			uv0.startRot_ = Vector3.zero
		end

		uv0.lastRotateY_ = nil
		uv0.lastDeltaX_ = 0
	end, function (slot0, slot1)
		if uv0.heroModel_ then
			slot2 = uv0.lastRotateY_ or uv0.rotateNode_.localEulerAngles.y
			slot4 = slot2 + (slot0 - (uv0.lastDeltaX_ or 0)) * HeroConst.ROTATE_RATIO - slot2
			slot5 = slot4

			if slot4 < -HeroConst.MAX_RORATE_ANGLE then
				slot5 = -HeroConst.MAX_RORATE_ANGLE
			elseif HeroConst.MAX_RORATE_ANGLE < slot4 then
				slot5 = HeroConst.MAX_RORATE_ANGLE
			end

			uv0.lastRotateY_ = slot2 + slot5
			uv0.lastDeltaX_ = slot0
			uv0.rotateNode_.localRotation = Quaternion.RotateTowards(uv0.rotateNode_.localRotation, Quaternion.Euler(uv0.startRot_.x, slot2 + slot5, uv0.startRot_.z), HeroConst.MAX_RORATE_ANGLE)
		end
	end)
end

function slot0.SetSkinId(slot0, slot1)
	if slot0.skinId_ == slot1 then
		return
	end

	slot0:Finish()
	manager.audio:AddCue("voice", string.format("vo_sys_%d", SkinCfg[slot1].hero), true)
	slot0:LoadModel(slot1)

	slot0.isShow_ = true
	slot0.skinId_ = slot1
	slot3 = slot0.interactiveSkinId_ == nil
	slot0.interactiveSkinId_ = slot1

	if not slot0.isShowInteractive_ then
		return
	end

	HeroTools.StopTalk()

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end

	slot0.playingInteraction_ = false

	if slot3 then
		if slot0.isEnterToThisView then
			slot0.isEnterToThisView = false

			slot0:PlayInteractionAnimation("roleChange")
		end
	else
		if slot0.interactionTimer_ then
			slot0.interactionTimer_:Stop()

			slot0.interactionTimer_ = nil
		end

		slot0.interactionTimer_ = TimeTools.StartAfterSeconds(1, handler(slot0, slot0.PlayInteractionAnimation), {
			"roleChange"
		})
	end

	if slot0.timer_ then
		slot0.timer_:Reset()
	end
end

function slot0.PlayChangeRoleInteraction(slot0)
	slot0:PlayInteractionAnimation("roleChange")
end

function slot0.SetCameraToPage(slot0, slot1)
	slot2 = CameraCfg[slot1]
	manager.ui.mainCamera.transform.localPosition = Vector3(slot2.position[1], slot2.position[2], slot2.position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(slot2.rotate[1], slot2.rotate[2], slot2.rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = slot2.fieldOfView
end

function slot0.ShowHeroModel(slot0, slot1)
	slot0.isShow_ = slot1

	if slot0.heroModel_ then
		SetActive(slot0.heroModel_, slot1)
		manager.resourcePool:ResetBlendShapes(slot0.heroModel_)
	end

	SetActive(slot0.backGo_, slot1)
end

function slot0.GetHeroModelIsShow(slot0)
	return slot0.isShow_
end

function slot0.SwitchCameraToWeapon(slot0)
	slot1 = CameraCfg.hero2
	manager.ui.mainCamera.transform.localPosition = Vector3(slot1.position[1], slot1.position[2], slot1.position[3])
	manager.ui.mainCamera.transform.localEulerAngles = Vector3(slot1.rotate[1], slot1.rotate[2], slot1.rotate[3])
	manager.ui.mainCameraCom_.fieldOfView = slot1.fieldOfView
end

function slot0.SwitchCameraToCurrentHero(slot0, slot1)
	if slot0.go_ == nil then
		return
	end

	slot3 = slot2:GetComponent("UIPoseMoveController")
	slot2.transform.localPosition = slot3:GetInitPosition()
	slot2.transform.localEulerAngles = slot3:GetInitRotation()
	slot2.transform.localScale = Vector3(1, 1, 1)

	if slot1 then
		slot5 = manager.ui.mainCamera
		slot6 = slot5.transform.localPosition.x
		slot7 = slot5.transform.localPosition.y
		slot8 = slot5.transform.localPosition.z
		slot9 = slot5.transform.localEulerAngles.x
		slot10 = slot5.transform.localEulerAngles.y
		slot11 = slot5.transform.localEulerAngles.z
		slot12 = manager.ui.mainCameraCom_.fieldOfView
		slot13 = slot3:GetCameraPosition() + slot0.cameraPosOffSet_
		slot14 = slot3:GetCameraRotation() + slot0.cameraRotateOffSet_
		slot15 = slot13.x
		slot16 = slot13.y
		slot17 = slot13.z
		slot18 = slot14.x
		slot19 = slot14.y
		slot20 = slot14.z
		slot21 = slot3:GetCameraFOV()

		slot0:RemoveTween()

		slot0.tweenValue_ = LeanTween.value(0, 1, slot3:GetTweenTime()):setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv14.transform.localPosition = Vector3(Mathf.Lerp(uv0, uv1, slot0), Mathf.Lerp(uv2, uv3, slot0), Mathf.Lerp(uv4, uv5, slot0))
			uv14.transform.localEulerAngles = Vector3(Mathf.Lerp(uv6, uv7, slot0), Mathf.Lerp(uv8, uv9, slot0), Mathf.Lerp(uv10, uv11, slot0))
			manager.ui.mainCameraCom_.fieldOfView = Mathf.Lerp(uv12, uv13, slot0)
		end)):setOnComplete(LuaHelper.VoidAction(function ()
			uv0:RemoveTween()
		end)):setEase(LeanTweenType.easeOutQuad)

		return
	end

	manager.ui.mainCamera.transform.localPosition = slot3:GetCameraPosition() + slot0.cameraPosOffSet_
	manager.ui.mainCamera.transform.localEulerAngles = slot3:GetCameraRotation() + slot0.cameraRotateOffSet_
	manager.ui.mainCameraCom_.fieldOfView = slot3:GetCameraFOV()
end

function slot0.SetCameraOffset(slot0, slot1, slot2)
	slot0.cameraPosOffSet_ = slot1
	slot0.cameraRotateOffSet_ = slot2
end

function slot0.ClearOffset(slot0)
	slot0.cameraPosOffSet_ = Vector3.zero
	slot0.cameraRotateOffSet_ = Vector3.zero
end

function slot0.RemoveTween(slot0)
	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end
end

function slot0.Finish(slot0)
	if slot0.animator_ then
		if slot0.playable_ then
			slot0.playable_:Stop()
		end

		if slot0.animator_.gameObject:GetComponent("LipSync") then
			slot1:ResetEmotion(0)
		end
	end

	slot0.skinId_ = nil

	if slot0.heroModel_ then
		slot0:RefreshActive()
		manager.resourcePool:DestroyOrReturn(slot0.heroModel_, ASSET_TYPE.TPOSE)

		slot0.heroModel_ = nil
		slot0.animator_ = nil
		slot0.weapomNode_ = nil
		slot0.weapomNode2_ = nil
		slot0.weapomNode3_ = nil
	end
end

function slot0.RefreshActive(slot0)
	if slot0.weapomNode_ then
		SetActive(slot0.weapomNode_, true)
	end

	if slot0.weapomNode2_ then
		SetActive(slot0.weapomNode2_, true)
	end

	if slot0.weapomNode3_ then
		SetActive(slot0.weapomNode3_, true)
	end
end

function slot0.LoadModel(slot0, slot1)
	slot2 = SkinCfg[slot1]
	slot3 = manager.resourcePool:Get("Char/" .. slot2.modelId, ASSET_TYPE.TPOSE)
	slot0.go_ = slot3
	slot4 = slot3:GetComponent("UIPoseMoveController")
	slot3.transform.localPosition = slot4:GetInitPosition()
	slot3.transform.localEulerAngles = slot4:GetInitRotation()
	slot3.transform.localScale = Vector3(1, 1, 1)

	slot0:SwitchCameraToCurrentHero(slot0.isShow_)
	slot0:InitModel(slot3, slot2.id)
end

function slot0.InitModel(slot0, slot1, slot2)
	slot0.heroModel_ = slot1
	slot3 = SkinCfg[slot2]
	slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot0.heroModel_.transform)

	if slot0:FindTrs(string.format("%dui/%dui_tpose", slot2, slot2), slot0.heroModel_.transform) then
		if slot0.animator_ == nil then
			slot0.animator_ = slot0:FindCom(typeof(Animator), "", slot4)
		end

		HeroTools.SetHeroModelWeaponActivity(slot4, true)
	end

	slot0.rotateNode_ = slot0:FindTrs(string.format("%dui", slot2), slot0.heroModel_.transform)
	slot0.rotateNode_.localEulerAngles = Vector3.zero

	if slot0.animator_ then
		slot0:PlayAction("ui_stand")
	end

	if not slot0.firstAppeared_ then
		slot0.firstAppeared_ = true

		slot0:PlayEffect()
	else
		slot0:PlayEffect()
	end
end

function slot0.PlayEffect(slot0)
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(slot0.heroModel_.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function slot0.TimerToPlayMainAnimation(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:PlayInteractionAnimation("roleIdle")
		end, 30, -1)
	end

	slot0.timer_:Start()
end

function slot0.ResetTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Reset()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnPlayHeroSound(slot0, slot1, slot2, slot3)
	if slot0.curTalkHeroId_ == slot1 and slot0.curTalkType_ == slot2 and slot0.systemType_ == slot3 then
		return
	end

	slot0:PlayAction("ui_stand")
end

function slot0.OnEnter(slot0)
	slot0.pause_ = false

	slot0:TimerToPlayMainAnimation()

	slot0.handler_ = handler(slot0, slot0.OnPlayHeroSound)

	manager.notify:RegistListener(HERO_SOUND_PLAY, slot0.handler_)
end

function slot0.OnExit(slot0)
	slot0:RemoveTween()
	manager.notify:RemoveListener(HERO_SOUND_PLAY, slot0.handler_)

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	slot0.handler_ = nil
	slot0.isShow_ = false
	slot0.firstAppeared_ = false
	slot0.playingInteraction_ = false
	slot0.interactiveSkinId_ = nil
	slot0.pause_ = true

	AnimatorTools.Stop()
	slot0:Finish()
	slot0:StopTimer()

	if slot0.isShowInteractive_ then
		HeroTools.StopTalk()
	end

	slot0:ClearOffset()
end

function slot0.OnTop(slot0)
	print("OnTop")

	slot0.pause_ = false
end

function slot0.OnBehind(slot0)
	print("OnBehind")

	slot0.pause_ = true
end

function slot0.PlayAction(slot0, slot1)
	if slot0.animator_ == nil then
		return
	end

	AnimatorTools.CrossFade(slot0.animator_, slot1)
end

function slot0.PlayInteractionAnimation(slot0, slot1)
	if not slot0.isShowInteractive_ then
		return
	end

	if slot0.pause_ then
		return
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Stop()

		slot0.interactionTimer_ = nil
	end

	if HeroInteractionCfg[SkinCfg[slot0.interactiveSkinId_].hero] and slot3[slot1 .. "_talk"] ~= nil and #slot3[slot1 .. "_talk"] > 0 then
		slot5 = #slot3[slot1] > 0

		if #slot3[slot1 .. "_talk"] == 1 then
			slot0:PlaySpecialAnimation(slot5 and slot3[slot1][1] or nil, slot3[slot1 .. "_talk"][1], slot3[slot1 .. "_delay"][1])
		else
			slot7 = slot0:RandomIndexOfInteractionType(slot1 .. "_talk")

			slot0:PlaySpecialAnimation(slot5 and slot3[slot1][slot7] or nil, slot3[slot1 .. "_talk"][slot7], slot3[slot1 .. "_delay"][slot7])
		end
	else
		print(string.format("%d这个皮肤没有配置%s的声音，请检查hero_interaction表", slot0.interactiveSkinId_, slot1))
	end
end

function slot0.RandomIndexOfInteractionType(slot0, slot1)
	slot2 = tostring(slot0.interactiveSkinId_) .. "_" .. slot1

	if not slot0.lastRandom_ then
		slot0.lastRandom_ = {}
	end

	slot4 = HeroInteractionCfg[SkinCfg[slot0.interactiveSkinId_].hero]
	slot5 = slot0.lastRandom_[slot2] or 0
	slot6 = {}
	slot7 = {}

	for slot11, slot12 in ipairs(slot4[slot1]) do
		if slot11 ~= slot5 then
			table.insert(slot6, slot12)
			table.insert(slot7, slot11)
		end
	end

	slot10 = math.round(math.random(#slot7))
	slot0.lastRandom_[slot2] = slot10

	return slot10
end

function slot0.PlaySpecialAnimation(slot0, slot1, slot2, slot3)
	if slot0.playingInteraction_ then
		return
	end

	if slot0.interactionTimer_ then
		slot0.interactionTimer_:Reset()
	end

	if slot0.timer_ then
		slot0.timer_:Reset()
	end

	if slot0.animator_ ~= nil and slot1 ~= nil then
		AnimatorTools.PlayAnimationWithCallback(slot0.animator_, slot1, handler(slot0, slot0.OnPlaySpecialCallback))

		slot0.playingInteraction_ = true
	else
		slot0.playingInteraction_ = false
	end

	slot0.curTalkHeroId_ = SkinCfg[slot0.interactiveSkinId_].hero
	slot0.curTalkType_ = slot2
	slot0.systemType_ = 1
	slot5 = string.split(slot0.curTalkType_, "_")

	print(string.format("播放%d的%s动作，声音为%s， 延迟为 %d 毫秒", slot0.skinId_, tostring(slot1), tostring(slot2), slot3))

	slot6 = nil

	if slot0.animator_ then
		slot6 = slot0.animator_.transform
	end

	if slot3 > 0 then
		if slot0.talkDelayTimer_ then
			slot0.talkDelayTimer_:Stop()

			slot0.talkDelayTimer_ = nil
		end

		slot0.talkDelayTimer_ = Timer.New(function ()
			HeroTools.PlayTalk(uv0[1], uv0[2], nil, uv1)
		end, slot3 / 1000)

		slot0.talkDelayTimer_:Start()
	else
		HeroTools.PlayTalk(slot5[1], slot5[2], nil, slot6)
	end
end

function slot0.OnPlaySpecialCallback(slot0)
	slot0.playingInteraction_ = false

	slot0:PlayAction("ui_stand")
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.isEnterToThisView = true
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:Finish()
	uv0.super.Dispose(slot0)
end

return slot0
