slot0 = class("RechargeVoucherItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.commonItem1_ = CommonItem.New(slot0.itemGo1_)
	slot0.commonItem2_ = CommonItem.New(slot0.itemGo2_)
	slot0.commonItem3_ = CommonItem.New(slot0.itemGo3_)
	slot0.commonItems_ = {
		slot0.commonItem1_,
		slot0.commonItem2_,
		slot0.commonItem3_
	}
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.getBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		PayAction.GetTotalRechargeBonus(uv0.cfg_.id)
	end)

	for slot4, slot5 in ipairs(slot0.commonItems_) do
		slot5:RegistCallBack(function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = TotalRechargeCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("%02d", slot0.index_)
	slot4 = GetTips("PAYMENT_TOTAL_POINT")
	slot0.descLabel_.text = string.format(slot4, slot0.cfg_.num)

	for slot4 = 1, 3 do
		if slot0.cfg_.reward[slot4] then
			SetActive(slot0.commonItems_[slot4].gameObject_, true)
			slot0.commonItems_[slot4]:RefreshData({
				id = slot0.cfg_.reward[slot4][1],
				number = slot0.cfg_.reward[slot4][2]
			})
		else
			SetActive(slot0.commonItems_[slot4].gameObject_, false)
		end
	end

	if RechargeData:HaveGetTotalRechargeBonus(slot0.cfg_.id) then
		slot0.statusController_:SetSelectedState("already_received")
	elseif slot0.cfg_.num <= RechargeData:GetTotalRechargeNum() then
		slot0.statusController_:SetSelectedState("receive")
	else
		slot0.statusController_:SetSelectedState("not_reach")
	end
end

function slot0.Dispose(slot0)
	if slot0.commonItem1_ then
		slot0.commonItem1_:Dispose()

		slot0.commonItem1_ = nil
	end

	if slot0.commonItem2_ then
		slot0.commonItem2_:Dispose()

		slot0.commonItem2_ = nil
	end

	if slot0.commonItem3_ then
		slot0.commonItem3_:Dispose()

		slot0.commonItem3_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
