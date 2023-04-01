slot0 = class("EnternalMusicRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, VolumeMusicSongItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activity_id
	slot0.musics = {}

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityCfg[slot6] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(slot0.musics, slot6)
		end
	end

	table.sort(slot0.musics, function (slot0, slot1)
		if uv0:GetState(slot0) ~= uv0:GetState(slot1) then
			return slot3 < slot2
		else
			return slot0 < slot1
		end
	end)
	slot0.list_:StartScroll(#slot0.musics)
end

function slot0.GetState(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot1]) do
		if (ActivityMusicCfg[slot7].difficult == 1 or slot8.difficult == 2) and MusicData:GetRewardState(slot7) == 1 then
			return 1
		end
	end

	return 0
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.musics[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnMusicRewardUpdate(slot0)
	for slot5, slot6 in pairs(slot0.list_:GetItemList()) do
		slot6:Refresh()
	end
end

return slot0
