slot0 = class("ActivityNoobFirstRechargeView_1", ReduxView)

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
		return "UI/Activity/NewbieRechargeUI_new"
	else
		return "UI/Activity/NewbieRechargeUI_old"
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
		JumpTools.JumpToPage2(GameSetting.newbie_first_charge_reward_6.value[2])
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityNewbieTools.ReceiveRechargeReward(1, 0, function ()
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
	slot0.rewardCfg_ = GameSetting.newbie_first_charge_reward_6.value[3]

	if not slot0.commonItem_ then
		slot0.commonItem_ = CommonItem.New(slot0.commonGo_)
		slot1 = slot0.commonItem_

		slot1:RefreshData(formatReward(slot0.rewardCfg_))

		slot1 = slot0.commonItem_

		slot1:RegistCallBack(function ()
			if uv0.status_ == 1 then
				ActivityNewbieTools.ReceiveRechargeReward(1, 0, function ()
					uv0:SetData()
				end)
			else
				ShowPopItem(POP_ITEM, uv0.rewardCfg_)
			end
		end)
	end

	slot1 = ActivityNewbieTools.GetFirstRechargeStatus()
	slot0.status_ = slot1.firstGearStatus

	slot0.statusController_:SetSelectedIndex(slot1.firstGearStatus)

	if slot0.typeController_ then
		slot0.typeController_:SetSelectedIndex(slot0.type_)
	end

	ActivityNewbieTools.SetSelectFirstRecharge(1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
