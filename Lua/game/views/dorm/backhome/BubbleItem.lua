slot0 = class("BubbleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.duration = 4
end

function slot1(slot0)
	slot1 = slot0.taskDataCtx.bubbleObj

	return slot1.duration <= Time.time - slot1.startTime
end

function slot2(slot0)
	slot0.taskDataCtx.bubbleObj:Hide()
end

function slot0.ShowSubtitle(slot0, slot1, slot2)
	slot0.startTime = Time.time

	if slot0.task == nil then
		slot3 = DormCharacterActionManager.frameTaskRunner:NewTask({
			bubbleObj = slot0
		})

		slot3:WaitUntil(uv0):Then(uv1)

		slot0.task = slot3

		slot0.task:Start()
	end

	slot0:SetData(slot1, slot2)
end

function slot0.SetData(slot0, slot1, slot2)
	slot5 = nullable(DormHeroVoiceDescCfg, Dorm.storage:GetData(DormCharacterManager.IdxNamespace(DormEnum.CharacterType.DormNormalHero), slot1), slot2)
	slot0.text.text = slot5

	if slot5 ~= nil and not IsAllSpace(slot5) then
		slot0.content:SetActive(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content.transform)
	end
end

function slot0.Hide(slot0)
	slot0.text.text = ""

	slot0.content:SetActive(false)

	if slot0.task then
		slot0.task:Abort()

		slot0.task = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.task then
		slot0.task:Abort()

		slot0.task = nil
	end

	slot0.gameObject_:Destroy()
end

return slot0
