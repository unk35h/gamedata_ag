slot0 = class("HeartLinkItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonitemsmallGo_)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.SetLike(slot0, slot1)
	slot0.controller_:SetSelectedState(slot1)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
