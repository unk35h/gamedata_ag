slot0 = class("RechargeGiftPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.iconGo_)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.number_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.id_,
		number = slot0.number_
	})
	slot0.commonItem_:HideNum()

	slot0.limitLabel_.text = "X" .. slot0.number_
	slot0.nameLabel_.text = ItemCfg[slot0.id_].name
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	Object.DestroyImmediate(slot0.gameObject_)

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
