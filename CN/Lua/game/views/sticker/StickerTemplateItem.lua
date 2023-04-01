slot0 = class("StickerTemplateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.bgID_ = slot2
	slot0.bg_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_bg_" .. slot0.bgID_)
	slot0.template_.sprite = getSpriteWithoutAtlas("Textures/Sticker/stickerBtn/Sticker_button_" .. slot0.id_)
end

function slot0.SetState(slot0, slot1)
	slot0.stateCon_:SetSelectedState(slot1)
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
