slot0 = class("ChatReportView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/LineReportUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.optionDataList_ = {}

	for slot4, slot5 in ipairs(ChatConst.CHAT_REPORT_REASON) do
		slot0.optionDataList_[slot4] = OptionDataList.New()

		for slot9, slot10 in ipairs(slot5) do
			if slot10 == 0 then
				slot0.optionDataList_[slot4].options:Add(OptionData.New(""))
			else
				slot0.optionDataList_[slot4].options:Add(OptionData.New(GetTips(ChatConst.CHAT_REASON_INDEX[slot10])))
			end
		end
	end
end

function slot0.OnEnter(slot0)
	slot0.inputFieldNote_.text = ""
	slot0.textNick_.text = slot0.params_.reportData.nick
	slot0.dropDownReason_.options = slot0.optionDataList_[slot0.params_.reportType].options
	slot0.dropDownReason_.value = 0
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.optionDataList_) do
		slot5.options:Clear()
	end

	slot0.optionDataList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonSure_, nil, function ()
		if uv0.dropDownReason_.value == 0 then
			ShowTips("NEED_REPORT_REASON")

			return
		end

		if uv0.params_.reportType == ChatConst.CHAT_REPORT_TYPE.CONTENT then
			ChatAction.ChatReportMsg(uv0.params_.reportData.msgID, ChatConst.CHAT_REPORT_REASON[uv0.params_.reportType][uv0.dropDownReason_.value + 1], uv0.inputFieldNote_.text, function (slot0)
				if isSuccess(slot0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function ()
							uv0:Back()
						end
					})
				else
					ShowTips(slot0.result)
				end
			end)
		else
			ChatAction.ChatReportUser(uv0.params_.reportData.userID, ChatConst.CHAT_REPORT_REASON[uv0.params_.reportType][uv0.dropDownReason_.value + 1], uv0.inputFieldNote_.text, function (slot0)
				if isSuccess(slot0.result) then
					ShowMessageBox({
						ButtonType = "SingleBtn",
						isTop = true,
						content = GetTips("REPORT_SUCCESS"),
						OkCallback = function ()
							uv0:Back()
						end
					})
				else
					ShowTips(slot0.result)
				end
			end)
		end
	end)
end

return slot0
