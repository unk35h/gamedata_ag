slot0 = class("ActivityNewbieRebateView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Activity/NewbieRechargeReturnUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.OnEnter(slot0)
	slot0:UpdateBar()
	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:RefreshUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.toRechargeBtn_, nil, function ()
		JumpTools.GoToSystem("/rechargeMain", {
			page = 5
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.totalRechargeNum_ = RechargeData:GetTotalRechargeNum()
	slot0.rebateAmount_ = slot0:calculate()

	if slot0.totalRechargeNumText_ ~= nil then
		slot0.totalRechargeNumText_.text = slot0.totalRechargeNum_
	end

	if slot0.rebateAmountText_ ~= nil then
		slot0.rebateAmountText_.text = slot0.rebateAmount_
	end
end

function slot0.calculate(slot0)
	slot2 = 0

	if slot0.totalRechargeNum_ > 3000 then
		slot2 = slot2 + (slot1 - 3000) * 1.25
		slot1 = 3000
	end

	if slot1 > 1000 then
		slot2 = slot2 + (slot1 - 1000) * 1.75
		slot1 = 1000
	end

	if slot1 > 100 then
		slot2 = slot2 + (slot1 - 100) * 3
		slot1 = 100
	end

	if slot1 > 6 then
		slot2 = slot2 + (slot1 - 6) * 5
		slot1 = 6
	end

	if slot1 > 0 then
		slot2 = slot2 + slot1 * 10
	end

	return slot2 * 10
end

function slot0.Show(slot0, slot1)
	if slot1 == false then
		slot0:OnExit()
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "activityNewbieRebateIllustrate",
		type = "jump",
		params = {}
	})
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
