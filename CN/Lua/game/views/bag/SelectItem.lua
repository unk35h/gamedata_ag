slot0 = class("SelectItem", ReduxView)
slot1 = import("game.const.ItemConst")
slot2 = import("game.tools.MailTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.itemGo_ = Object.Instantiate(Asset.Load("UI/Common/CommonItem"), slot0:FindTrs("item"))
	slot0.item_ = CommonItem.New(slot0.itemGo_)

	slot0.item_:RefreshData(slot0.info_)

	slot0.name_ = slot0:FindCom(typeof(Text), "name/name")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.name_.text = ItemCfg[slot0.info_.id].name
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.item_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.item_:RegistCallBack(slot1)
end

function slot0.ShowSelect(slot0, slot1)
	slot0.item_:ShowSelect(slot1)
end

return slot0
