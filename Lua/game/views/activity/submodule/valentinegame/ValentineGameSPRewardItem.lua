slot0 = class("ValentineGameSPRewardItem", ReduxView)

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

	slot0.commonItem_ = CommonItem.New(slot0.commonGo_)
end

function slot0.AddUIListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0.commonItem_:RefreshData(formatReward(slot1))
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
	slot0:RefreshText()
	SetActive(slot0.gameObject_, true)
end

function slot0.RefreshText(slot0)
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.BLACK)
	slot0.commonItem_:HideNum()

	slot0.cntText_.text = slot0.data_[2]
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
	slot0.commonItem_:OnExit()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.commonItem_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
