slot0 = class("ActivityNewbieRechargeItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.button_.transform, "stage")
	slot0.rechargeUpdateHandler_ = handler(slot0, slot0.RefreshUI)

	manager.notify:RegistListener(NEWBIE_RECHARGE_UPDATE, slot0.rechargeUpdateHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(NEWBIE_RECHARGE_UPDATE, slot0.rechargeUpdateHandler_)

	slot0.rechargeUpdateHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_first_recharge = uv0.index_
		})

		slot1 = ActivityNewbieData:GetRechargeTemplate()[uv0.index_]

		if (ActivityNewbieData:GetRechargeStatus()[uv0.index_] or 0) == 0 then
			if slot1.source[1] == ViewConst.SYSTEM_ID.PASSPORT_BUY then
				if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
					ShowTips("SYSTEM_LOCK")

					return
				end

				if PassportData:GetEndTimestamp() <= TimeMgr.GetInstance():GetServerTime() then
					ShowTips("NO_ACTIVE_BATTLEPASS")

					return
				end
			end

			JumpTools.JumpToPage2(slot1.source)
		else
			ActivityNewbieAction.ReceiveRechargeReward(uv0.index_, function (slot0)
				if isSuccess(slot0.result) then
					getReward(uv0.reward, {
						ItemConst.ITEM_TYPE.HERO,
						ItemConst.ITEM_TYPE.HERO_SKIN
					})
					ActivityNewbieData:SetRechargeStatus(uv1.index_)

					uv1.button_.interactable = false

					uv1.controller_:SetSelectedState(2)
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)

	if slot0.infoBtn_ then
		slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
			ShowPopItem(POP_ITEM, ActivityNewbieData:GetRechargeTemplate()[uv0.index_].reward[1])
		end)
	end
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityNewbieData:GetRechargeStatus()[slot0.index_] or 0
	slot0.button_.interactable = slot1 ~= 2

	slot0.controller_:SetSelectedState(tostring(slot1))
end

return slot0
