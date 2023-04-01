slot0 = class("VolumeMusicSongItem", ReduxView)

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

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, VolumeMusicRewardItem)
end

function slot0.SetData(slot0, slot1)
	slot0.music_id = slot1

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0.rewards = ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id] or {}
	slot0.m_name.text = ActivityMusicCfg[slot0.rewards[1]] and ActivityMusicCfg[slot1].name or ""

	slot0.list_:StartScroll(math.min(#slot0.rewards, 2))
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rewards[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
