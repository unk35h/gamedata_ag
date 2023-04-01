slot0 = class("ChatStickerCategoryItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.id_ = slot3

	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.icon_.sprite = getSpriteViaConfig("ChatSticker", ChatStickerCategoryCfg[slot3].icon .. SettingData:GetCurrentLanguageKey())
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY, uv0.id_)
	end)
end

function slot0.RefreshSelectID(slot0, slot1)
	if slot0.id_ == slot1 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
