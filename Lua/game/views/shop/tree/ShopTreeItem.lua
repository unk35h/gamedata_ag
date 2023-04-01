slot0 = class("ShopTreeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetShopId(slot0, slot1)
	slot0.shopId_ = slot1
	slot0.shopListCfg_ = ShopListCfg[slot1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.shopListCfg_.remark
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.GetToggle(slot0)
	return slot0.toggle_
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
