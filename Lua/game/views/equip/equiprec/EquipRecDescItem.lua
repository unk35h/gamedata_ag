slot0 = class("EquipRecDescItem", ReduxView)

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

function slot0.SetData(slot0, slot1, slot2)
	slot0.nameText_.text = GetI18NText(slot1) .. "："
	slot0.descText_.text = slot2

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
