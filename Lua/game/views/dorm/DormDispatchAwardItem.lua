slot0 = class("DormDispatchAwardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.item = CommonItem.New(slot0.commonitemGo_1)
	slot1 = slot0.item

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	if slot1.extraNum then
		slot0.extraText_.text = string.format("+%d", slot1.extraNum)
		slot1.num = slot1.num + slot1.extraNum
	else
		slot0.extraText_.text = ""
	end

	slot0.item:RefreshData({
		id = slot1.id,
		number = slot1.num
	})
end

function slot0.Dispose(slot0)
	slot0.item = nil

	uv0.super.Dispose(slot0)
end

return slot0
