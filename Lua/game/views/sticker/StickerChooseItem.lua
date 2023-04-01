slot0 = class("StickerChooseItem", ReduxView)

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

	slot0.selectCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "select")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "lock")
	slot0.useCon_ = ControllerUtil.GetController(slot0.iconGo_.transform, "use")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.iconBtn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshItem(slot0, slot1)
	slot0.itemID_ = slot1
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.itemID_)

	slot0.lockCon_:SetSelectedState(PlayerData:GetSticker(slot0.itemID_).unlock == 0 and "lock" or "default")
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "select" or "default")
end

function slot0.SetUsed(slot0, slot1)
	slot0.useCon_:SetSelectedState(slot1 and "used" or "default")
end

function slot0.RegisterClickListener(slot0, slot1)
	if slot0.clickFunc_ == nil then
		slot0.clickFunc_ = slot1
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
