slot0 = class("QuarryItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.ani_ = slot0.transform_:GetComponent("Animator")
	slot0.smokeAni_ = slot0.smokeGo_.transform:GetComponent("Animator")
	slot0.texture_ = slot0.transform_:GetComponent("SpriteRenderer").sprite.texture
	slot0.script_ = slot0.transform_:GetComponent(typeof(CowRun))
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.Pause(slot0)
	slot0.ani_.enabled = false
	slot0.smokeAni_.enabled = false

	slot0:SetPause(true)
end

function slot0.Continue(slot0)
	slot0.ani_.enabled = true
	slot0.smokeAni_.enabled = true

	slot0:SetPause(false)
end

function slot0.SetState(slot0, slot1)
	slot0.ani_:Play(slot1)

	if slot1 == "fall" then
		slot0:SetSpeed(slot0.fallSpeed_)
		SetActive(slot0.scoreGo_, true)

		slot2 = 0
		slot0.timer_ = FrameTimer.New(function ()
			if uv0 > 0 then
				slot0 = uv1.ani_:GetCurrentAnimatorStateInfo(0).speed

				TimeTools.StartAfterSeconds(uv1.fallTime_ / (slot0 * slot0) * 0.714, function ()
					SetActive(uv0.smokeGo_, true)
					uv0.smokeAni_:Play("smoke")
					manager.audio:PlayEffect("minigame_activity_1_3", "minigame_fall", "")
				end, {})
			end

			uv0 = uv0 + 1
		end, 1, 2)

		slot0.timer_:Start()
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.speed_ = slot2 or 100
	slot0.fallSpeed_ = slot3 or 100

	slot0:SetSpeed(slot0.speed_)

	slot4 = slot0.gameObject_:GetComponent("SpriteRenderer").sprite.texture
	slot5 = slot0.gameObject_:GetComponent("SpriteRenderer").size
	slot6 = slot5.x / slot4.width
	slot7 = slot5.y / slot4.height
	slot0.hitTrans_ = {}
	slot0.hitTrans_ = {
		hitLeft = slot5.x / 2 - slot1.hitLeft * slot6,
		hitRight = slot5.x / 2 - slot1.hitRight * slot6
	}
	slot0.width_ = slot5.x

	for slot11 = 1, slot0.ani_.runtimeAnimatorController.animationClips.Length do
		if slot0.ani_.runtimeAnimatorController.animationClips[slot11].name == "fall" then
			slot0.fallTime_ = slot12.length

			break
		end
	end

	slot0.isHitOrTaunt_ = false
	slot0.isPass_ = false

	SetActive(slot0.scoreGo_, false)
	SetActive(slot0.smokeGo_, false)
end

function slot0.SetIsHitOrTaunt(slot0)
	slot0.isHitOrTaunt_ = true
end

function slot0.GetIsHitOrTaunt(slot0)
	return slot0.isHitOrTaunt_
end

function slot0.SetIsPass(slot0)
	slot0.isPass_ = true
end

function slot0.GetIsPass(slot0)
	return slot0.isPass_
end

function slot0.GetData(slot0)
	return slot0.data_
end

function slot0.GetWidth(slot0)
	return slot0.width_
end

function slot0.GetHitRect(slot0)
	return slot0.hitTrans_
end

function slot0.SetSpeed(slot0, slot1)
	if slot0.script_ then
		slot0.script_:SetSpeed(slot1)
	end
end

function slot0.SetPause(slot0, slot1)
	if slot0.script_ then
		slot0.script_:SetPause(slot1)
	end
end

function slot0.SetStop(slot0, slot1)
	if slot0.script_ then
		slot0.script_:SetStop(slot1)
	end
end

function slot0.OnExit(slot0)
	Object.Destroy(slot0.gameObject_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
