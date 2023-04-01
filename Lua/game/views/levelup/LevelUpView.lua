slot0 = class("LevelUpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/LevelUpUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
	slot0:CreateSelector()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()

	slot0.timer_ = FrameTimer.New(function ()
		uv0:Update()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.InitUI(slot0)
	slot0.fromLevelLabel_ = slot0:FindCom(typeof(Text), "Panel/lv1")
	slot0.toLevelLabel_ = slot0:FindCom(typeof(Text), "Panel/lv2")
	slot0.getDDLabel_ = slot0:FindCom(typeof(Text), "Panel/att1/num")
	slot0.ddUpLimitLabel_ = slot0:FindCom(typeof(Text), "Panel/att2/num")
	slot0.animator_ = slot0:FindCom(typeof(Animator), "Panel", slot0.transform_)
	slot0.bgBtn_ = slot0:FindCom(typeof(Button), "Panel/bg")
	slot0.mask_ = slot0:FindCom(typeof(CanvasGroup), "mask")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListenerScale("Panel/bg", nil, function ()
		uv0:Back()
	end)
end

function slot0.RemoveListeners(slot0)
end

function slot0.OnSubscribe(slot0)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = slot0.params_.levelUpInfoList[1].fromLevel
	slot2 = slot0.params_.levelUpInfoList[#slot0.params_.levelUpInfoList].toLevel
	slot3 = GameLevelSetting[slot1].fatigue_max
	slot4 = GameLevelSetting[slot2].fatigue_max
	slot5 = 0

	for slot9 = slot1 + 1, slot2 do
		slot5 = slot5 + GameLevelSetting[slot9].fatigue_upgrade_reward
	end

	slot0.fromLevelLabel_.text = tostring(slot1)
	slot0.toLevelLabel_.text = tostring(slot2)
	slot0.getDDLabel_.text = "+" .. slot5
	slot0.ddUpLimitLabel_.text = tostring(slot4) .. "[+" .. slot4 - slot3 .. "]"
end

function slot0.CreateSelector(slot0)
end

function slot0.Update(slot0)
	if slot0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1 and slot1:IsName("panel") then
		slot0.mask_.blocksRaycasts = false
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
