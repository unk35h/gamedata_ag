slot0 = class("DiamondExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/DiamondExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
	slot0.selector_ = createStructuredSelector({
		rmb = function (slot0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_RMB)
		end,
		diamond = function (slot0)
			return CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
		end
	})
end

function slot0.InitUI(slot0)
	slot0.showText_ = slot0:FindCom("Text", "textbg/text")
	slot0.icon1_ = slot0:FindCom("Image", "panel/message/icon1")
	slot0.icon2_ = slot0:FindCom("Image", "panel/message/icon2")
	slot0.use_ = slot0:FindCom("Text", "panel/message/use")
	slot0.get_ = slot0:FindCom("Text", "panel/message/get")
	slot0.select_ = slot0:FindCom("Text", "panel/message/numbg/select")
	slot0.selectGo_ = slot0:FindGo("panel/message/numbg/select")
	slot0.selectInputGo_ = slot0:FindGo("panel/message/numbg/select_input")
	slot0.selectInput_ = slot0:FindCom("InputField", "panel/message/numbg/select_input")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("bgmask", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListenerScale("btn_ok", nil, function ()
		if uv0.model_.rmb == 0 then
			ShowMessageBox({
				content = "秘钻不足，是否前往秘钻投资商店购买？",
				title = GetTips("PROMPT"),
				OkCallback = function ()
				end,
				CancelCallback = function ()
				end
			})
		end

		if uv0.selectNum_ == 0 then
			return
		end

		CurrencyAction.BuyDiamond(uv0.selectNum_)
	end)
	slot0:AddBtnListenerScale("btn_cancel", nil, function ()
		uv0:Back()
	end)
	slot0:AddPressingByTimeListener(slot0:FindGo("panel/message/numbg/add"), 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.model_.rmb then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:RefreshTexts()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0:FindGo("panel/message/numbg/cut"), 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:RefreshTexts()

			return true
		end

		return false
	end)
	slot0:AddBtnListenerScale("panel/message/numbg/max", nil, function ()
		uv0.selectNum_ = uv0.model_.rmb

		if uv0.selectNum_ <= 0 then
			uv0.selectNum_ = 1
		end

		uv0:RefreshTexts()
	end)
	slot0:AddBtnListener("panel/message/numbg/select", nil, function ()
		uv0.selectInput_.text = uv0.selectNum_

		SetActive(uv0.selectInputGo_, true)
		SetActive(uv0.selectGo_, false)
		uv0.selectInput_:ActivateInputField()
	end)

	slot3 = slot0.selectInput_.onEndEdit

	slot3:AddListener(function ()
		if uv0.model_.rmb < (tonumber(uv0.selectInput_.text) or 0) then
			slot0 = uv0.model_.rmb
		end

		if slot0 <= 0 then
			slot0 = 1
		end

		uv0.selectNum_ = slot0

		SetActive(uv0.selectInputGo_, false)
		SetActive(uv0.selectGo_, true)
		uv0:RefreshTexts()
	end)
end

function slot0.Render(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.model_ = slot0.selector_.compute(gameStore.getState())
	slot0.selectNum_ = 1

	slot0:RefreshTexts()
end

function slot0.RefreshTexts(slot0)
	slot0.use_.text = slot0.selectNum_
	slot0.get_.text = slot0.selectNum_
	slot0.select_.text = slot0.selectNum_
	slot0.showText_.text = string.format("是否消耗%d个秘钻兑换%d个虹晶?", slot0.selectNum_, slot0.selectNum_)
end

function slot0.OnBuyDiamond(slot0, slot1, slot2)
	if slot1.result == 0 then
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_RMB, -slot0.selectNum_)
		CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, slot0.selectNum_)
		slot0:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
