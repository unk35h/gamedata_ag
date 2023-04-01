slot0 = class("RewardItem", ReduxView)
slot1 = import("game.tools.ItemTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0.commonItem_ = manager.commonItemPool:Get(slot2)
		slot0.gameObject_ = slot0.commonItem_.gameObject_
		slot0.transform_ = slot0.gameObject_.transform
	else
		slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
		slot0.transform_ = slot0.gameObject_.transform
		slot0.commonItem_ = CommonItem.New(slot0.gameObject_)
	end

	slot0.fromPool_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	if slot0.fromPool_ then
		slot0.commonItem_.mainAni_.speed = 1

		manager.commonItemPool:Release(slot0.commonItem_)
	else
		slot0.commonItem_:Dispose()
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
end

function slot0.AddListeners(slot0)
end

function slot0.RemoveListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.commonItem_:RefreshData(formatReward(slot1))
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
		OperationRecorder.Record(uv1.class.__cname, "open_pop_item")
	end)
	slot0.commonItem_:SetSelectType("equip")
	SetActive(slot0.gameObject_, true)
end

function slot0.UpdateCommonItemAni(slot0)
	slot0.commonItem_:UpdateAnimator()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.ShowSelect(slot0, slot1)
	slot0.commonItem_:ShowSelect(slot1 and 1 or 0)
end

return slot0
