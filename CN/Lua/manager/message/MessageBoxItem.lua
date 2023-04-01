slot0 = class("MessageBoxItem")
slot1 = import("game.tools.ItemTools")
slot2 = import("game.tools.JumpTools")

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(slot1, manager.ui.uiMessage.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isFree_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.typeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.singleController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "single")
	slot0.tipTypeController_ = ControllerUtil.GetController(slot0.tipBoxGo_.transform, "tipType")
	slot0.controller_ = ControllerUtil.GetController(slot0.transformPanel_, "screenOrientation")
end

function slot0.AddListeners(slot0)
	slot1 = slot0.bgBtn_.onClick

	slot1:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "bgBtn")

		if uv0.info_.ButtonType == "SingleBtn" then
			if uv0.info_.CancelCallback then
				uv0.info_.CancelCallback()
			end

			if uv0.info_.MaskCallback then
				uv0.info_.MaskCallback()

				if uv0.gameObject_ then
					uv0:SetGameObjectInActive(false)
				end

				uv0.isFree_ = true
			end

			return
		end

		if uv0.info_.MaskCallback then
			uv0.info_.MaskCallback()
		end

		if uv0.gameObject_ then
			uv0:SetGameObjectInActive(false)
		end

		uv0.isFree_ = true
	end)

	slot1 = slot0.btnSure_.onClick

	slot1:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "sureBtn")

		if uv0.gameObject_ then
			uv0:SetGameObjectInActive(true)

			if uv0.info_.OkCallback then
				uv0.info_.OkCallback()
			end
		end

		uv0.isFree_ = true
	end)

	slot1 = slot0.btnOK_.onClick

	slot1:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "okBtn")

		if uv0.gameObject_ then
			if uv0.info_.OkCallback then
				uv0.info_.OkCallback()
			end

			uv0:SetGameObjectInActive(true)
		end

		uv0.isFree_ = true
	end)

	slot1 = slot0.btnCancel_.onClick

	slot1:AddListener(function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "cancelBtn")
		uv0:OnClickCancel()
	end)

	slot1 = slot0.promptToggle_.onValueChanged

	slot1:AddListener(function (slot0)
		if slot0 then
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "toggleOn")
		else
			OperationRecorder.Record(gameContext:GetLastOpenPage() .. "MessageBox", "toggleOff")
		end

		uv0.info_.ToggleCallback(slot0)
	end)
end

function slot0.OnClickCancel(slot0)
	if slot0.gameObject_ then
		if slot0.info_.ButtonType == "SingleBtn" then
			if slot0.info_.OkCallback then
				slot0.info_.OkCallback()
			end
		elseif slot0.info_.CancelCallback then
			slot0.info_.CancelCallback()
		end

		slot0:SetGameObjectInActive(false)
	end

	slot0.isFree_ = true
end

function slot0.RemoveListeners(slot0)
	slot0.bgBtn_.onClick:RemoveAllListeners()
	slot0.btnSure_.onClick:RemoveAllListeners()
	slot0.btnOK_.onClick:RemoveAllListeners()
	slot0.btnCancel_.onClick:RemoveAllListeners()
	slot0.promptToggle_.onValueChanged:RemoveAllListeners()
end

function slot0.IsFree(slot0)
	return slot0.isFree_
end

function slot0.SetData(slot0, slot1)
	if getScreenOrientation() then
		slot0.controller_:SetSelectedState("horizontal")
	else
		slot0.controller_:SetSelectedState("vertical")
	end

	slot0.info_ = slot1
	slot0.isFree_ = false

	SetActive(slot0.gameObject_, true)

	if slot1.isTop then
		slot0.transform_:SetParent(manager.ui.uiTips.transform, false)
		slot0.transform_:SetAsLastSibling()
	else
		slot0.transform_:SetParent(manager.ui.uiMessage.transform, false)
	end

	slot0.singleController_:SetSelectedState(slot1.ButtonType == "SingleBtn" and "true" or "false")

	if slot0.info_.BtnText then
		slot0.midBtnTxt_.text = slot0.info_.BtnText[1] and slot0.info_.BtnText[1] or GetTips("CONFIRM")
		slot0.leftBtnTxt_.text = slot0.info_.BtnText[2] and slot0.info_.BtnText[2] or GetTips("CANCEL")
		slot0.rightBtnTxt_.text = slot0.info_.BtnText[3] and slot0.info_.BtnText[3] or GetTips("CONFIRM")
	else
		slot0.midBtnTxt_.text = GetTips("CONFIRM")
		slot0.leftBtnTxt_.text = GetTips("CANCEL")
		slot0.rightBtnTxt_.text = GetTips("CONFIRM")
	end

	if type(slot1.content) == "table" then
		slot0.typeController_:SetSelectedState("consume")
		slot0:ShowItemBox()
	else
		slot0.typeController_:SetSelectedState("tip")
		slot0:ShowNormalBox()
	end

	if slot1.toggleText then
		slot0.toggleTxt_.text = slot1.toggleText
	end

	slot2 = slot0.info_.ToggleCallback ~= nil

	SetActive(slot0.promptToggleGo_, slot2)

	if slot2 then
		SetActive(slot0.secondTextGo_, false)
	elseif slot0.info_.SecondTip then
		SetActive(slot0.secondTextGo_, true)

		slot0.secondText_.text = slot0.info_.SecondTip

		if slot0.info_.SecondValue then
			SetActive(slot0.secondValueGo_, true)

			slot0.secondValueText_.text = slot0.info_.SecondValue
		else
			SetActive(slot0.secondValueGo_, true)
		end
	else
		SetActive(slot0.secondTextGo_, false)
	end
end

function slot0.SetGaussionBg(slot0)
	if uv0.JudgeIsHaveGaussian(gameContext:GetAllOpenRoute()) then
		SetActive(slot0.gaussianGo_, false)
	else
		SetActive(slot0.gaussianGo_, true)
	end
end

function slot0.ShowNormalBox(slot0)
	slot0:SetGaussionBg()

	if slot0.info_.TipType then
		slot0.tipTypeController_:SetSelectedState(slot0.info_.TipType)
	else
		slot0.tipTypeController_:SetSelectedState("none")
	end

	slot0.tipContent_.text = slot0.info_.content or ""
end

function slot0.ShowItemBox(slot0)
	for slot5 = 0, slot0.consumeBox_.transform.childCount - 1 do
		slot0.consumeBox_.transform:GetChild(slot5).gameObject:SetActive(false)
	end

	slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelMiddle")

	if slot0:GetIsFrontShow() then
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelFront")
	elseif slot0:GetIsMiddleShow() then
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelMiddle")
	else
		slot0.panelTrs_ = slot0.consumeBox_.transform:Find("typePanelBehind")
	end

	slot0.panelTrs_.gameObject:SetActive(true)

	slot0.frontTrs_ = slot0.panelTrs_:Find("frontText")
	slot0.cntTrs_ = slot0.panelTrs_:Find("cntText")
	slot0.behindTrs_ = slot0.panelTrs_:Find("behindText")
	slot0.frontText_ = slot0.frontTrs_:GetComponent("Text")
	slot0.sonsumeIcon_ = slot0.panelTrs_:Find("icon"):GetComponent("Image")
	slot0.cntText_ = slot0.cntTrs_:GetComponent("Text")
	slot0.behindText_ = slot0.behindTrs_:GetComponent("Text")

	slot0:SetGaussionBg()

	slot2 = slot0.info_.content
	slot0.frontText_.text = slot2[1]
	slot0.sonsumeIcon_.sprite = uv0.getItemSprite(slot2[2][1])
	slot0.cntText_.text = slot2[2][2]
	slot0.behindText_.text = slot2[3]

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.frontTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.cntTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.behindTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.panelTrs_)
end

function slot0.Hide(slot0)
	if slot0.gameObject_ then
		slot0:SetGameObjectInActive()
	end

	slot0.isFree_ = true
end

function slot0.SetGameObjectInActive(slot0, slot1)
	if slot0.promptToggle_ then
		if slot1 then
			function slot0.info_.ToggleCallback()
			end
		end

		slot0.promptToggle_.isOn = false

		SetActive(slot0.gameObject_, false)
	end
end

function slot0.GetIsFrontShow(slot0)
	return slot0:CheckLanguage({
		"kr",
		"jp"
	})
end

function slot0.GetIsMiddleShow(slot0)
	return slot0:CheckLanguage({
		"en",
		"zh_cn"
	})
end

function slot0.GetIsBehindShow(slot0)
	return false
end

function slot0.CheckLanguage(slot0, slot1)
	return table.indexof(slot1, SettingData:GetSettingData().sound.text_language)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.btnPanel_ = nil
	slot0.bgBtn_ = nil
	slot0.btnOK_ = nil
	slot0.promptToggleGo_ = nil
	slot0.behindTrs_ = nil
	slot0.tipContent_ = nil
	slot0.panelTrs_ = nil
	slot0.typePanel2_ = nil
	slot0.btnSinglePanel_ = nil
	slot0.behindText_ = nil
	slot0.title_ = nil
	slot0.promptToggle_ = nil
	slot0.cntTrs_ = nil
	slot0.textContextGo_ = nil
	slot0.btnCancel_ = nil
	slot0.frontText_ = nil
	slot0.frontTrs_ = nil
	slot0.sonsumeIcon_ = nil
	slot0.cntText_ = nil
	slot0.btnSure_ = nil
end

return slot0
