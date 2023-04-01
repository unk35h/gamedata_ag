slot0 = class("CharacterBubbleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:RegisterEvent()

	slot0.bubbleController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.emotionController = ControllerUtil.GetController(slot0.emojiTrs_, "emotion")
	slot0.animator = slot0:FindCom(typeof(Animator), "", slot0.emojiTrs_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RegisterEvent(slot0)
	manager.notify:RegistListener(DORM_RESTAURANT_LOGIC_TICK, handler(slot0, slot0.Updata))
end

function slot0.RemoveEvent(slot0)
	manager.notify:RemoveListener(DORM_RESTAURANT_LOGIC_TICK, handler(slot0, slot0.Updata))
end

function slot0.RefreshUI(slot0, slot1)
	if slot1.type == DormEnum.BubbleType.WaitForFood then
		slot0:WaitFoodBubble(slot1)
	elseif slot1.type == DormEnum.BubbleType.Working then
		slot0:WorkingBubble(slot1)
	elseif slot1.type == DormEnum.BubbleType.CharacterEmotion then
		slot0:EmotionBubble(slot1)
	elseif slot1.type == DormEnum.BubbleType.Award then
		slot0:AwardBubble(slot1)
	end
end

function slot0.WaitFoodBubble(slot0, slot1)
	slot0.bubbleController:SetSelectedState("sendFood")

	slot2 = slot1.params
	slot0.foodID_ = slot2.cfgID
	slot0.foodnmaetextText_.text = BackHomeCanteenFoodCfg[slot0.foodID_].name
	slot0.entityID = slot1.entityID
	slot0.tastenameText_.text = string.format("<color=#%s>%s</color>", BackHomeCateenFlavor[slot2.taste].color, BackHomeCateenFlavor[slot2.taste].flavor)
	slot0.timer = CanteenAIFunction:GetEntityData(slot0.entityID).waitFoodTimer
	slot0.time = slot1.duration
end

function slot0.EmotionBubble(slot0, slot1)
	slot0.bubbleController:SetSelectedState("emotion")
	slot0.emotionController:SetSelectedIndex(GameDisplayCfg.canteen_customer_emote.value[slot1.params.quality][2])
end

function slot0.Updata(slot0)
	if slot0.timer then
		slot2 = slot0.timer:QueryTime() / slot0.time

		if slot0.timebarImg_ then
			slot0.timebarImg_.fillAmount = 1 - slot2
		end

		if slot0.worktimebarImg_ then
			slot0.worktimebarImg_.fillAmount = 1 - slot2
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:RemoveEvent()
	uv0.super.Dispose(slot0)
end

return slot0
