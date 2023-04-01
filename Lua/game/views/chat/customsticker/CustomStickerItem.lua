slot0 = class("CustomStickerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1
	slot0.icon_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCfg[slot1].icon .. SettingData:GetCurrentLanguageKey())

	slot0:RefreshSelectState()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot0 = GameSetting.chat_sticker_custom_max_cnt.value[1]

		if not table.keyof(ChatStickerData:GetCustomStickerUIList(), uv0.id_) and slot0 <= #slot1 then
			ShowTips("CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED")

			return
		end

		ChatStickerData:ChangeCustomStickerUIList(uv0.id_)
		uv0:RefreshSelectState()
		manager.notify:Invoke(CHAT_CUSTOM_STICKER_CHANGED)
	end)
end

function slot0.RefreshSelectState(slot0)
	if table.keyof(ChatStickerData:GetCustomStickerUIList(), slot0.id_) then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
