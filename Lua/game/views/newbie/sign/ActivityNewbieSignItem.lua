slot0 = class("ActivityNewbieSignItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")

	slot0:AddListeners()

	slot0.refreshHandler_ = handler(slot0, slot0.ZeroTimeRefresh)

	manager.notify:RegistListener(ZERO_REFRESH, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:OnSign()
	end)
end

function slot0.OnSign(slot0)
	if ActivityNewbieData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNewbieData:GetSignDay() + 1 == table.keyof(GameSetting.newbie_sign.value, slot0.id_) then
		ActivityNewbieAction.NewbieSignIn(function (slot0)
			if isSuccess(slot0.result) then
				ActivityNewbieData:SignIn()
				getReward({
					SignCfg[GameSetting.newbie_sign.value[ActivityNewbieData:GetSignDay()]].reward
				})
				uv0.controller_:SetSelectedState("2")
			else
				ShowTips(slot0.result)
			end
		end)
	end
end

function slot0.ZeroTimeRefresh(slot0)
	slot0:RefreshUI(slot0.id_)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = SignCfg[slot1].reward

	if not slot0.rewardGo_ then
		slot0.rewardGo_ = RewardPoolItem.New(slot0.itemParent_, slot2, true, nil, function ()
			slot0 = table.keyof(GameSetting.newbie_sign.value, uv0)

			if ActivityNewbieData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNewbieData:GetSignDay() + 1 == slot0 then
				uv1:OnSign()

				return false
			end

			return true
		end)
	end

	if slot0.id_ ~= slot1 then
		slot0.rewardGo_:SetData(slot2)

		slot0.id_ = slot1
	end

	slot3 = table.keyof(GameSetting.newbie_sign.value, slot1)
	slot0.textDay_.text = slot3

	if slot3 <= ActivityNewbieData:GetSignDay() then
		slot0.controller_:SetSelectedState("2")
	else
		slot0.controller_:SetSelectedState("0")
	end

	if ActivityNewbieData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNewbieData:GetSignDay() + 1 == slot3 then
		slot0.controller_:SetSelectedState("1")
	end
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(ZERO_REFRESH, slot0.refreshHandler_)

	slot0.refreshHandler_ = nil

	if slot0.rewardGo_ then
		slot0.rewardGo_:Dispose()

		slot0.rewardGo_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
