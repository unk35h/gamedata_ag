slot0 = class("ActivityMatrixClueItem", ReduxView)

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
	slot2 = ActivityMatrixClueCfg[slot1]
	slot0.m_name.text = slot2.name
	slot0.m_node.text = slot2.note
	slot0.m_des.text = slot2.desc
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/VolumeIIIUI/icon/" .. slot2.icon)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
