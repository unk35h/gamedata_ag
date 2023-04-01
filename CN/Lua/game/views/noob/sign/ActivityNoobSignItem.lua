slot0 = class("ActivityNoobSignItem", ReduxView)

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
	if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == table.keyof(GameSetting.newbie_sign_14.value, slot0.id_) then
		ActivityNoobAction.NoobSignIn(function (slot0)
			if isSuccess(slot0.result) then
				ActivityNoobData:SignIn()
				getReward({
					SignCfg[GameSetting.newbie_sign_14.value[ActivityNoobData:GetSignDay()]].reward
				})
				uv0.controller_:SetSelectedState("2")
				manager.notify:CallUpdateFunc("NOOB_SIGN")
			else
				ShowTips(slot0.result)
			end
		end)
	end
end

function slot0.ZeroTimeRefresh(slot0)
	slot0:RefreshUI(slot0.id_, slot0.pageIndex_, slot0.index_)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot4 = SignCfg[slot1].reward

	if not slot0.rewardGo_ then
		slot0.rewardGo_ = RewardPoolNoobItem.New(nil, slot0.itemParent_, slot4, true, nil, function ()
			slot0 = table.keyof(GameSetting.newbie_sign_14.value, uv0)

			if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == slot0 then
				uv1:OnSign()

				return false
			end

			return true
		end)

		slot0.rewardGo_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	end

	if slot0.id_ ~= slot1 then
		slot0.rewardGo_:SetData(slot4)

		slot0.id_ = slot1
	end

	slot5 = (slot2 - 1) * 7 + slot3
	slot0.index_ = slot3
	slot0.pageIndex_ = slot2
	slot0.textDay_.text = slot5

	if slot5 < 10 then
		slot0.textDat2_.text = "0" .. slot5
	else
		slot0.textDat2_.text = slot5
	end

	if slot5 <= ActivityNoobData:GetSignDay() then
		slot0.controller_:SetSelectedState("2")
	else
		slot0.controller_:SetSelectedState("0")
	end

	if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == slot5 then
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
