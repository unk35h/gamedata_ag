slot0 = class("ActivityNoobFirstRechargeView_2", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.type_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.rechargeUpdateHandler_ = handler(slot0, slot0.SetData)

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, slot0.rechargeUpdateHandler_)

	slot0.signItemList_ = {}
end

function slot0.GetUIName(slot0, slot1)
	if slot1 == 0 then
		return "UI/Activity/NewbieRecharge2UI_new"
	else
		return "UI/Activity/NewbieRecharge2UI_old"
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot4 = NEWBIE_RECHARGE_UPDATE
	slot5 = slot0.rechargeUpdateHandler_

	manager.notify:RemoveListener(slot4, slot5)

	slot0.rechargeUpdateHandler_ = nil

	for slot4, slot5 in ipairs(slot0.signItemList_) do
		slot5:Dispose()
	end

	slot0.signItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		JumpTools.JumpToPage2(GameSetting.newbie_first_charge_reward_18.value[2])
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityNewbieTools.ReceiveRechargeReward(1, 1, function (slot0)
			uv0:SetData()
		end)
	end)

	if slot0.heroBtn_ then
		slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				hid = GameSetting.newbie_first_charge_reward_6.value[3][1]
			})
		end)
	end
end

function slot0.SetData(slot0)
	slot0.rewardCfg_ = GameSetting.newbie_first_charge_reward_18.value[3]

	for slot4, slot5 in ipairs(slot0.rewardCfg_) do
		if not slot0.signItemList_[slot4] then
			slot0.signItemList_[slot4] = NoobRechargeSignItem.New(slot0.signItemGo_, slot0.contentTrans_)
		end

		slot0.signItemList_[slot4]:SetData(slot4, slot5)
	end

	slot1 = #slot0.rewardCfg_
	slot2 = ActivityNewbieTools.GetFirstRechargeStatus()
	slot3 = slot2.signTimes
	slot4 = slot2.lastSignTimestamp

	if not slot2.secondGearStatus then
		slot0.statusController_:SetSelectedState("recharge")
	elseif slot3 < slot1 and slot4 < manager.time:GetTodayFreshTime() then
		slot0.statusController_:SetSelectedState("complete")
	else
		slot0.statusController_:SetSelectedState("received")
	end

	if slot0.typeController_ then
		slot0.typeController_:SetSelectedIndex(slot0.type_)
	end

	ActivityNewbieTools.SetSelectFirstRecharge(2)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
