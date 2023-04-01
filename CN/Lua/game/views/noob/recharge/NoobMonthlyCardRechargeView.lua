slot0 = class("NoobMonthlyCardRechargeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.type_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.statusController_ = ControllerUtil.GetController(slot0.btnPanelTrans_, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.GetUIName(slot0, slot1)
	if slot1 == 0 then
		return "UI/Activity/NewbieMonthlyCardUI"
	else
		return "UI/Activity/NewbieMonthlyCardUI_old"
	end
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		JumpTools.JumpToPage2(GameSetting.newbie_first_monthly_card_reward.value[2])
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityNewbieTools.ReceiveRechargeReward(2, 0, function (slot0)
			uv0:RefreshStatus()
		end)
	end)
	slot0:AddBtnListener(slot0.signRewardBtn_, nil, function ()
		ShowPopItem(POP_ITEM, GameSetting.newbie_first_monthly_card_cumulative.value[2])
	end)
end

function slot0.SetData(slot0)
	slot0.rewardCfg_ = GameSetting.newbie_first_monthly_card_reward.value[1]

	if not slot0.commonItem_ then
		slot0.commonItem_ = CommonItem.New(slot0.commonGo_)
		slot1 = slot0.commonItem_

		slot1:RefreshData(formatReward(slot0.rewardCfg_))

		slot1 = slot0.commonItem_

		slot1:RegistCallBack(function ()
			if uv0.status_ == 1 then
				uv0:ReceiveReward()
			else
				ShowPopItem(POP_ITEM, uv0.rewardCfg_)
			end
		end)
	end

	slot0:RefreshStatus()

	if slot0.typeController_ then
		slot0.typeController_:SetSelectedIndex(slot0.type_)
	end

	ActivityNewbieTools.SetSelectMonthlyRecharge()
end

function slot0.RefreshStatus(slot0)
	slot1 = ActivityNewbieTools.GetFirstMonthlyCardStatus()
	slot3 = slot1.heroRewardFlag

	if slot1.isRecharged == false then
		slot0.status_ = 0
	elseif slot3 == false then
		slot0.status_ = 1
	else
		slot0.status_ = 2
	end

	slot0.statusController_:SetSelectedIndex(slot0.status_)
end

function slot0.ReceiveReward(slot0)
	ActivityNewbieTools.ReceiveRechargeReward(2, 0, function (slot0)
		uv0:RefreshStatus()
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
