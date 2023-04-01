slot0 = class("PopCostItemView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupCostConfirmationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btnController_ = ControllerUtil.GetController(slot0.m_okBtn.transform, "enabled")

	slot0.btnController_:SetSelectedState("true")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		uv0:Back()

		if uv0.params_.popCostCallBack then
			uv0.params_.popCostCallBack()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.m_costCountText.text = "x" .. (slot0.params_.costCount or 0)
	slot0.m_costIcon.sprite = ItemTools.getItemSprite(slot0.params_.costId or 0)

	if slot0.params_.itemId then
		SetActive(slot0.m_currency, true)

		slot0.m_numText.text = ItemTools.getItemNum(slot3)
		slot0.m_itemIcon.sprite = ItemTools.getItemSprite(slot3)
	else
		SetActive(slot0.m_currency, false)
	end
end

function slot0.SetBtnStatus(slot0, slot1)
	if slot1 then
		slot0.btnController_:SetSelectedState("true")
	else
		slot0.btnController_:SetSelectedState("false")
	end
end

return slot0
