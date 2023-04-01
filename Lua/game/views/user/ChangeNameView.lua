slot0 = class("ChangeNameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/PopupChangeNameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:GetOrAddComponent(slot0.nameinput_.gameObject, typeof(InputFieldHelper))
	dealEnter(slot0.nameinput_.gameObject)

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0._onValidateInput(slot0, slot1, slot2)
	if #slot0 >= 24 then
		return 0
	end

	return slot2
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.iconBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD
		})
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		if uv0.costType_ == 1 and uv0.cardHave <= 0 then
			ShowTips("NAME_CHANGE_CARD_INSUFFICIENT_TIPS")

			return
		end

		slot0 = PlayerData:GetPlayerInfo().nick

		if uv0.nameinput_.text == "" then
			ShowTips("ERROR_USER_NAME_TOO_SHORT")

			return
		end

		if slot0 == slot1 then
			ShowTips("NAME_CANNOT_SAME_CURRENT")

			return
		end

		slot2, slot3 = textLimit(slot1, 16)
		uv0.nameinput_.text = slot2
		slot1 = slot2

		if not OperationData:IsOperationOpen(OperationConst.CHANGE_NICK) then
			ShowTips("OPERATION_DISABLED")

			return
		end

		if not nameRule(slot1) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(slot1, function (slot0)
			if not slot0 then
				ShowTips("ERROR_USER_NAME_VER_WORD")
			else
				if not uv0 then
					return
				end

				if uv1.costType_ == 1 then
					ShowMessageBox({
						content = string.format(GetTips("NAME_CHANGE_CARD_WHETHER_TIPS"), uv2),
						OkCallback = function ()
							PlayerAction.ChangeNickname(uv0, uv1.costType_)
						end,
						CancelCallback = function ()
						end
					})
				else
					PlayerAction.ChangeNickname(uv2, uv1.costType_)
				end
			end
		end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
	end)
end

function slot0.OnChangeNickname(slot0, slot1)
	ShowTips("SUCCESS_CHANGE_NAME")
	JumpTools.Back()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.nameinput_.text = ""
	slot0.costType_ = 1

	if PlayerData:GetExtraChangeNickTime() <= 0 then
		slot0.tip_.text = GetTips("TIPS_REVISENAME_ONE")
	else
		slot0.tip_.text = GetTips("TIPS_REVISENAME_FREE")
	end

	if PlayerData:GetPlayerInfo().is_changed_nick == 2 and PlayerData:GetExtraChangeNickTime() <= 0 then
		slot0.costType_ = 1

		slot0.typeCon_:SetSelectedState("card")

		slot0.cardHave = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_CHANGE_NAME_CARD)

		if slot0.cardHave > 0 then
			slot0.num_.text = slot0.cardHave .. "/" .. 1
		else
			slot0.num_.text = "<color=#FF0000>" .. slot0.cardHave .. "</color>" .. "/" .. 1
		end
	else
		slot0.costType_ = 2

		slot0.typeCon_:SetSelectedState("free")

		slot0.tip_.text = GetTips("TIPS_REVISENAME_FREE")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.nameinput_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
