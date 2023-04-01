slot0 = class("RegressionSignItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.commonItem_ = CommonItem.New(slot0.m_item)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_button, nil, function ()
		if not RegressionData:IsRegressionOpen() then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.m_dayLab.text = slot1

	if SignCfg[slot2] then
		slot4 = slot0.commonItem_

		slot4:RefreshData(formatReward(slot3.reward))

		slot4 = slot0.commonItem_

		slot4:RegistCallBack(function ()
			ShowPopItem(POP_ITEM, uv0.reward)
		end)
	end

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot2 = RegressionData:GetSignIndex()

	if RegressionData:IsSignReward(slot0.index) then
		slot0.stateController:SetSelectedIndex(2)
	elseif slot0.index <= slot2 then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	slot0.item:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
