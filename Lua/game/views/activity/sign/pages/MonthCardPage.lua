slot0 = class("MonthCardPage", BaseSignPage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Sign/MonthCardUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveGetController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveGet")
	slot0.bonusIcon_.sprite = ItemTools.getItemSprite(GameSetting.monthly_card_reward_daily.value[1])
	slot0.bonusLabel_.text = GameSetting.monthly_card_reward_daily.value[2]
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
	end)
end

function slot0.OnShow(slot0)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	print(debug.traceback("MonthCardView::UpdateView, sign = " .. tostring(RechargeData:IsSignToday())))

	if RechargeData:IsSignToday() then
		slot0.haveGetController_:SetSelectedState("true")
	else
		slot0.haveGetController_:SetSelectedState("false")
	end

	slot0.surplusDay_.text = RechargeData:GetMonthCardLastDay() .. GetTips("DAY")
end

function slot0.OnMonthCardDailyReward(slot0)
	slot0:UpdateView()
end

function slot0.AutoGetReward(slot0)
	PayAction.GetMonthCardBonus()
end

return slot0
