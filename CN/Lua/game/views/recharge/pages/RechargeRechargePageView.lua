slot1 = class("RechargeRechargePageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitConfig()
	slot0:Init()
end

function slot1.InitConfig(slot0)
	slot0.rechargeDataList_ = {}

	for slot4, slot5 in ipairs(RechargeCfg.all) do
		table.insert(slot0.rechargeDataList_, RechargeCfg[slot5])
	end
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, RechargeRechargeItemView)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rechargeDataList_[slot1], {})
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.fundsettlementmethodBtn_, nil, function ()
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%d\"}", 0))
	end)
	slot0:AddBtnListener(slot0.commercialBtn_, nil, function ()
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%d\"}", 1))
	end)

	if SDKTools.GetIsInputServer("kr") then
		slot0:AddBtnListener(slot0.refundbtn_, nil, function ()
			JumpTools.OpenPageByJump("gameHelpPro", {
				pages = {
					"Textures/RechargeUI/Refund Policy@kr"
				}
			})
		end)
	end
end

function slot1.OnTop(slot0)
end

function slot1.OnEnter(slot0)
	slot0.list_:StartScroll(#slot0.rechargeDataList_)
	SetActive(slot0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
	SetActive(slot0.refundGo_, not SDKTools.GetIsInputServer("kr"))
	SetActive(slot0.refundbtn_.gameObject, false)

	if SDKTools.GetIsInputServer("kr") then
		SetActive(slot0.refundbtn_.gameObject, slot0.curPageIndex_ ~= 4 and slot0.curPageIndex_ ~= 6)
	end
end

function slot1.OnExit(slot0)
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
