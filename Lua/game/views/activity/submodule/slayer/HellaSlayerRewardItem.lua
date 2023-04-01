slot0 = class("HellaSlayerRewardItem", ReduxView)

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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HellaSlayerFoldItem)
end

function slot0.GetHeight(slot0)
	return slot0.hight or 0
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.slayer_activity_id = slot1
	slot0.region_activity_id = slot2
	slot0.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot2] or {}
	slot3 = #slot0.pointRewards

	slot0.list:StartScroll(slot3)

	slot0.hight = 100 + 190 * slot3
	slot0.transform_.sizeDelta = Vector2.New(slot0.transform_.rect.width, slot0.hight)
	slot0.m_title.text = ActivitySlayerCfg[slot2] and ActivitySlayerCfg[slot2].name or ""
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if not slot1 then
		slot0.hight = 0
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.slayer_activity_id, slot0.pointRewards[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
