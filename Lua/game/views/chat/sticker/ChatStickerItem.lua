slot0 = class("ChatStickerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.RefreshData(slot0, slot1)
	slot0.id_ = slot1
	slot0.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCfg[slot1].icon .. SettingData:GetCurrentLanguageKey())
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonItem_, nil, function ()
		if uv0.id_ == 0 then
			ChatStickerData:InitStickerUIList()
			JumpTools.OpenPageByJump("chatCustomSticker")

			return
		end

		manager.notify:Invoke(CHAT_SEND_STICKER, uv0.id_)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
