slot0 = class("CustomStickerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Friends/ChatCustomStickerUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stickerUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, CustomStickerItem)
	slot0.changedHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.OnEnter(slot0)
	slot0.stickerUIList_:StartScroll(#ChatStickerCfg.all - 1)
	manager.notify:RegistListener(CHAT_CUSTOM_STICKER_CHANGED, slot0.changedHandler_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAT_CUSTOM_STICKER_CHANGED, slot0.changedHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.changedHandler_ = nil

	slot0.stickerUIList_:Dispose()

	slot0.stickerUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:CloseFun()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:ExitAndSaveData()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:CloseFun()
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(ChatStickerCfg.all[slot1 + 1])
end

function slot0.RefreshUI(slot0)
	slot0.cntText_.text = string.format("%s/%s", #ChatStickerData:GetCustomStickerUIList(), GameSetting.chat_sticker_custom_max_cnt.value[1])
end

function slot0.CloseFun(slot0)
	if slot0:HasChanged() then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("CHAT_CUSTOM_STICKER_CHANGED"),
			OkCallback = function ()
				uv0:ExitAndSaveData()
				uv0:Back()
			end,
			CancelCallback = function ()
				uv0:Back()
			end
		})
	else
		slot0:Back()
	end
end

function slot0.HasChanged(slot0)
	if #ChatStickerData:GetCustomStickerList() == #ChatStickerData:GetCustomStickerUIList() then
		for slot6, slot7 in ipairs(slot1) do
			if table.keyof(slot2, slot7) == nil then
				return true
			end
		end

		return false
	end

	return true
end

function slot0.ExitAndSaveData(slot0)
	ChatAction.SaveCustomSticker(function (slot0)
		if isSuccess(slot0.result) then
			manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY)
		else
			ShowTips(slot0.result)
		end
	end)
end

return slot0
