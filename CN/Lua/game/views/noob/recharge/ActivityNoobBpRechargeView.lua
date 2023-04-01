slot0 = class("ActivityNoobBpRechargeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.type_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.GetUIName(slot0, slot1)
	if slot1 == 0 then
		return "UI/Activity/NewbieBpRechargeUI"
	else
		return "UI/Activity/NewbieBpRechargeUI_old"
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if PassportData:GetEndTimestamp() <= TimeMgr.GetInstance():GetServerTime() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		JumpTools.JumpToPage2(GameSetting.first_battle_pass_reward.value[2])
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function (slot0)
			uv0:RefreshStatus()
		end)
	end)
end

function slot0.SetData(slot0)
	slot0.rewardCfg_ = GameSetting.first_battle_pass_reward.value[1]

	if not slot0.commonItem_ then
		slot0.commonItem_ = CommonItem.New(slot0.commonGo_)

		slot0.commonItem_:RefreshData(formatReward(slot0.rewardCfg_))
		slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
		slot0.commonItem_:RegistCallBack(function ()
			ShowPopItem(POP_ITEM, uv0.rewardCfg_)
		end)
		slot0.commonItem_:HideNum()
	end

	slot0:RefreshStatus()

	if slot0.typeController_ then
		slot0.typeController_:SetSelectedIndex(slot0.type_)
	end

	ActivityNewbieTools.SetSelectBpRecharge()
end

function slot0.RefreshStatus(slot0)
	slot0.status_ = ActivityNewbieTools.GetBpRewardStatus()

	slot0.statusController_:SetSelectedIndex(slot0.status_)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
