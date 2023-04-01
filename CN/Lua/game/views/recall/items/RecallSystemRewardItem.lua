slot0 = class("RecallSystemRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem = CommonItem.New(slot0.itemGo_)
end

function slot0.SetData(slot0, slot1)
	slot0.data = slot1
	slot3 = slot0.commonItem

	slot3:RefreshData(formatReward(slot1))

	slot3 = slot0.commonItem

	slot3:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)

	slot0.nameTxt_.text = ItemCfg[slot1[1]].name
end

function slot0.UpdateView(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.commonItem:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
