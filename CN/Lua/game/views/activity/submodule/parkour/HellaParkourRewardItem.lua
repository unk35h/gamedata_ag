slot0 = class("HellaParkourRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HellaParkourRewardInfoItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.entrust_activity_id = slot1
	slot0.infos = ActivityParkourCfg[slot1] and slot2.star_reward or {}

	slot0.list:StartScroll(#slot0.infos)

	slot0.m_title.text = slot2.name
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.entrust_activity_id, slot0.infos[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
