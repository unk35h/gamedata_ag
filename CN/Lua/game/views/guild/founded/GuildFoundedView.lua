slot0 = class("GuildFoundView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.switchHeadIconHandler_ = handler(slot0, slot0.SwitchHeadIcon)
	slot0.textCost_.text = GameSetting.club_founded_cost.value[1]

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.headIconID_ = math.random(1, #ClubHeadIconCfg.all)

	slot0:RefreshHeadIcon()
	manager.notify:RegistListener(GUILD_SWITCH_HEAD_ICON, slot0.switchHeadIconHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_SWITCH_HEAD_ICON, slot0.switchHeadIconHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.switchHeadIconHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonIcon_, nil, function ()
		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = uv0.headIconID_
		})
	end)
	slot0:AddBtnListener(slot0.buttonFounded_, nil, function ()
		if uv0.inputFieldName_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(uv0.inputFieldName_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			uv0.inputFieldName_.text = ""

			return
		end

		uv0.inputFieldName_.text, slot1 = textLimit(uv0.inputFieldName_.text, GameSetting.club_name_max.value[1])

		if not nameRule(uv0.inputFieldName_.text) then
			ShowTips("ERROR_USER_NAME_VER_WORD")

			return
		end

		if not slot1 then
			return
		end

		uv0.inputFieldNotice_.text, slot4 = textLimit(uv0.inputFieldNotice_.text, GameSetting.club_announcement_max.value[1])

		if not slot4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), slot2))

			return
		end

		WordVerifyBySDK(uv0.inputFieldName_.text .. "" .. uv0.inputFieldNotice_.text, function (slot0)
			if not slot0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < GameSetting.club_founded_cost.value[1] then
				JumpTools.OpenPopUp("rechargeDiamondExchange", {
					getBaseNum = 1,
					useBaseNum = 1,
					useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
					defaultNum = GameSetting.club_founded_cost.value[1] - slot1
				}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)

				return
			end

			GuildAction.FoundedGuild(uv0.inputFieldName_.text, uv0.inputFieldNotice_.text, uv0.headIconID_, function (slot0)
				if isSuccess(slot0.result) then
					ShowTips("CLUB_FOUNDED_SUCCESS")
					CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -1 * GameSetting.club_founded_cost.value[1])

					uv0.inputFieldName_.text = ""
					uv0.inputFieldNotice_.text = ""
				else
					ShowTips(slot0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SwitchHeadIcon(slot0, slot1)
	slot0.headIconID_ = slot1

	slot0:RefreshHeadIcon()
end

function slot0.RefreshHeadIcon(slot0)
	slot1 = ClubHeadIconCfg[slot0.headIconID_]
	slot0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", slot1.iconName)
	slot0.imageBg_.sprite = getSpriteViaConfig("ClubHeadIcon", slot1.bg)
end

return slot0
