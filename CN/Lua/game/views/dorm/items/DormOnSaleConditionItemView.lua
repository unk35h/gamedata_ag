slot0 = class("DormOnSaleConditionItemView", ReduxView)

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
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.cfg_ = ConditionCfg[slot1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.contentLabel_.text = slot0.cfg_.desc
	slot1, slot2 = ConditionTools.GetConditionProgress(slot0.cfg_.id)
	slot0.checkbox_.isOn = slot2 <= slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
