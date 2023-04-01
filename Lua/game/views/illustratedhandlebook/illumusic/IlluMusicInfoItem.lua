slot0 = class("IlluMusicInfoItem", ReduxView)

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

	slot0.songItems = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		if uv0.maskClickFunc then
			uv0.maskClickFunc(uv0.index)
		end
	end)
	slot0:AddBtnListener(slot0.m_cdBtn, nil, function ()
		if uv0.cdClickFunc then
			uv0.cdClickFunc()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.album = slot1
	slot0.index = slot3
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/Illustrate/musicCD/" .. MusicAlbumRecordCfg[slot1].cover)
	slot0.songs = MusicRecordCfg.get_id_list_by_album[slot0.album] or {}

	slot0:RefreshSongs()
	slot0:RefreshSongsState(slot2)

	slot0.m_verName.text = slot4.verName
	slot0.m_albumName.text = slot4.albumName
end

function slot0.UpdateAnima(slot0, slot1)
	if slot1 == slot0.index then
		slot0.m_animator:Play("detail_item_on", -1, 0)
	else
		slot0.m_animator:Play("detail_item_on", -1, 1)
	end
end

function slot0.UpdateState(slot0, slot1)
	if slot0.index == slot1 then
		SetActive(slot0.m_mask.gameObject, false)
	else
		SetActive(slot0.m_mask.gameObject, true)
	end
end

function slot0.RefreshSongs(slot0)
	for slot4, slot5 in ipairs(slot0.songs) do
		if not slot0.songItems[slot4] then
			slot0.songItems[slot4] = IlluMusicSongItem.New(Object.Instantiate(slot0.m_songItem, slot0.m_songContent), slot0)
		end

		slot0.songItems[slot4]:SetActive(true)
		slot0.songItems[slot4]:RefreshUI(slot5)
	end

	for slot5 = #slot0.songs + 1, #slot0.songItems do
		slot0.songItems[slot5]:SetActive(false)
	end
end

function slot0.RefreshSongsState(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.songItems) do
		slot6:RefreshSongsState(slot1)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.PlayMusic(slot0, slot1)
	if slot0.clickFunc then
		slot0.clickFunc(slot1)
	end
end

function slot0.RegistMaskCallBack(slot0, slot1)
	slot0.maskClickFunc = slot1
end

function slot0.RegistCdCallBack(slot0, slot1)
	slot0.cdClickFunc = slot1
end

function slot0.ForceRebuild(slot0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_songContent)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
