slot0 = class("GuildRenameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubCommunityname"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.textCost_.text = GameSetting.club_rename_cost.value[1]
	slot0.freeController_ = ControllerUtil.GetController(slot0.transform_, "free")
end

function slot0.OnEnter(slot0)
	if GuildData:GetRenameFreeCnt() > 0 then
		slot0.freeController_:SetSelectedState("true")
	else
		slot0.freeController_:SetSelectedState("false")
	end

	slot0.freeRenameCnt_ = slot1
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0.inputFieldNick_.text = ""

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0.inputFieldNick_.text = ""

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_NICK) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if uv0.inputFieldNick_.text == "" then
			ShowTips("CLUB_NEED_NAME")

			return
		end

		if IsAllSpace(slot0) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.inputFieldNick_.text = ""

			return
		end

		slot1, slot2 = textLimit(slot0, 16)
		uv0.inputFieldNick_.text = slot1

		if not nameRule(slot1) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		WordVerifyBySDK(slot0, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			if not uv0 then
				return
			end

			slot1 = 2

			if uv1.freeRenameCnt_ > 0 then
				slot1 = 1
			elseif CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameSetting.club_rename_cost.value[1] then
				slot3 = GameSetting.club_rename_cost.value[1] - slot2

				JumpTools.OpenPopUp("rechargeDiamondExchange", {
					defaultNum = 1,
					useBaseNum = slot3,
					getBaseNum = slot3,
					useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					getId = CurrencyConst.CURRENCY_TYPE_DIAMOND
				}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

				return
			end

			GuildAction.GuildRename(uv2, slot1, function (slot0)
				if isSuccess(slot0.result) then
					ShowTips("CLUB_RENANE_SUCCESS")

					if uv0.freeRenameCnt_ <= 0 then
						CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -1 * GameSetting.club_rename_cost.value[1])
					else
						GuildData:UseRenameFree()
					end

					uv0.inputFieldNick_.text = ""

					uv0:Back()
				else
					ShowTips(slot0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

return slot0
