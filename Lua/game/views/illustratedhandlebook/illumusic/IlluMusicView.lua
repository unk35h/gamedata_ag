slot0 = class("IlluMusicView", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/Music/IlluMusicAlbumUI"
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

	slot0.common_list = LuaList.New(handler(slot0, slot0.IndexCommonItem), slot0.m_common_list, IlluMusicAlbumItem)
	slot0.detail_list = LuaList.New(handler(slot0, slot0.IndexDetailItem), slot0.m_detail_list, IlluMusicInfoItem)
	slot0.pauseController = ControllerUtil.GetController(slot0.transform_, "pause")
	slot0.bgmController = ControllerUtil.GetController(slot0.transform_, "bgm")
	slot0.statusController = ControllerUtil.GetController(slot0.transform_, "status")

	SetActive(slot0.m_musicName.gameObject, false)
	SetActive(slot0.m_author.gameObject, false)
	TimeTools.StartAfterSeconds(0.1, function ()
		uv0.m_musicName.alignment = UnityEngine.TextAnchor.MiddleLeft
		uv0.m_author.alignment = UnityEngine.TextAnchor.MiddleLeft

		SetActive(uv0.m_musicName.gameObject, true)
		SetActive(uv0.m_author.gameObject, true)
	end, {})
end

function slot0.AddUIListener(slot0)
	slot0.m_scroller.onValueChanged:AddListener(function ()
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		uv0:ChangeMusic(1)
	end)
	slot0:AddBtnListener(slot0.m_lastBtn, nil, function ()
		uv0:ChangeMusic(-1)
	end)
	slot0:AddBtnListener(slot0.m_playBtn, nil, function ()
		if uv0.player then
			uv0.player:Pause(false)
		end

		uv0:RefreshState()
	end)
	slot0:AddBtnListener(slot0.m_pauseBtn, nil, function ()
		if uv0.player then
			uv0.player:Pause(true)
		end

		uv0:RefreshState()
	end)
	slot0:AddBtnListener(slot0.m_setBgmBtn, nil, function ()
		IllustratedAction.QuerySetBgm(uv0.music_id)
	end)
	slot0:AddBtnListener(slot0.m_detailMask, nil, function ()
		uv0:SwitchToCommon()
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:SwitchToCommon()
	end)
	slot0.detail_list:SetPageChangeHandler(handler(slot0, slot0.OnDetailPageChange))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.SwitchToCommon(slot0)
	if slot0.statusController:GetSelectedState() == "detail" then
		slot0.statusController:SetSelectedState("common")

		for slot6, slot7 in pairs(slot0.common_list:GetItemList()) do
			slot7:UpdateAnima(slot0.pageIndex)
		end
	end
end

function slot0.OnDetailPageChange(slot0, slot1)
	if slot1 <= #slot0.albums then
		slot0.pageIndex = slot1

		if slot0.statusController:GetSelectedState() == "detail" then
			slot0.common_list:SwitchToPage(slot1)
		end

		for slot7, slot8 in pairs(slot0.detail_list:GetItemList()) do
			slot8:UpdateState(slot0.pageIndex)
		end
	end
end

function slot0.OnCommonPageChange(slot0, slot1)
	if slot1 <= #slot0.albums then
		slot0.pageIndex = slot1

		if slot0.statusController:GetSelectedState() == "common" then
			slot0.detail_list:SwitchToPage(slot1)
		end
	end
end

function slot0.OnEnter(slot0)
	slot0.player = manager.audio:GetBgmPlayer()
	slot0.music_id = slot0:GetMusicId()

	slot0:RefreshState()

	slot0.albums = MusicAlbumRecordCfg.all

	slot0.statusController:SetSelectedState("common")

	slot0.pageIndex = table.indexof(slot0.albums, MusicRecordCfg[slot0.music_id].album) or 1

	slot0.common_list:StartScroll(#slot0.albums, slot0.pageIndex, true, false)
	slot0.detail_list:StartScroll(#slot0.albums, slot0.pageIndex, true, false)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.player then
		slot0.player:Pause(false)
	end
end

function slot0.Dispose(slot0)
	slot0.common_list:Dispose()
	slot0.common_list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexCommonItem(slot0, slot1, slot2)
	slot2:SetData(slot0.albums[slot1], slot0.music_id, slot1)
	slot2:RegistCallBack(handler(slot0, slot0.OnAlbumClick))
end

function slot0.IndexDetailItem(slot0, slot1, slot2)
	slot2:SetData(slot0.albums[slot1], slot0.music_id, slot1)
	slot2:UpdateState(slot0.pageIndex)
	slot2:RegistCallBack(handler(slot0, slot0.PlayMusic))
	slot2:RegistMaskCallBack(handler(slot0, slot0.ChangePageIndex))
	slot2:RegistCdCallBack(handler(slot0, slot0.SwitchToCommon))
end

function slot0.ChangePageIndex(slot0, slot1)
	slot0.detail_list:SwitchToPage(slot1)
end

function slot0.OnAlbumClick(slot0, slot1)
	slot0.statusController:SetSelectedState("detail")

	slot0.pageIndex = slot1
	slot6 = true
	slot7 = false

	slot0.detail_list:ScrollToIndex(slot0.pageIndex, slot6, slot7)

	for slot6, slot7 in pairs(slot0.detail_list:GetItemList()) do
		slot7:UpdateAnima(slot0.pageIndex)
	end

	slot0:OnDetailPageChange(slot0.pageIndex)
end

function slot0.GetMusicId(slot0)
	if slot0.player then
		slot2 = slot0.player.cueSheet or ""

		if (slot0.player.cueName or "") ~= "" and slot2 ~= "" then
			for slot7, slot8 in ipairs(MusicRecordCfg.all) do
				if MusicRecordCfg[slot8].cueName == slot1 and slot9.cuesheet == slot2 then
					return slot8
				end
			end
		end
	end

	return MusicRecordCfg.all[1]
end

function slot0.ChangeMusic(slot0, slot1)
	slot3 = MusicRecordCfg.get_id_list_by_album[MusicRecordCfg[slot0.music_id].album]
	slot4 = #slot3

	if (table.indexof(slot3, slot0.music_id) + slot4 + slot1) % slot4 == 0 then
		slot6 = slot4
	end

	slot0:PlayMusic(slot3[slot6])
end

function slot0.PlayMusic(slot0, slot1)
	if slot1 ~= slot0.music_id and MusicRecordCfg[slot1].cuesheet == MusicRecordCfg[slot0.music_id].cuesheet and MusicRecordCfg[slot1].cueName == MusicRecordCfg[slot0.music_id].cueName then
		manager.audio:Stop("music")
	end

	slot0.music_id = slot1
	slot2 = MusicRecordCfg[slot0.music_id]

	if slot0.player then
		slot0.player:Pause(false)

		for slot7, slot8 in pairs(MusicData:GetAisacSet(slot0.music_id)) do
			slot0.player:SetAisacControl(slot7, slot8)
		end
	end

	manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	if slot0.player and not slot0.player:IsPaused() then
		slot0.pauseController:SetSelectedIndex(0)
	else
		slot0.pauseController:SetSelectedIndex(1)
	end

	slot1 = MusicRecordCfg[slot0.music_id]
	slot0.m_musicName.text = slot1.musicName
	slot0.m_author.text = slot1.authorName

	for slot6, slot7 in pairs(slot0.detail_list:GetItemList()) do
		slot7:RefreshSongsState(slot0.music_id)
	end

	if slot0.music_id == IllustratedData:GetBgm() then
		slot0.bgmController:SetSelectedIndex(0)
	elseif slot1.ableBGM == 1 then
		slot0.bgmController:SetSelectedIndex(1)
	else
		slot0.bgmController:SetSelectedIndex(2)
	end
end

function slot0.OnSetBgmSuccess(slot0)
	slot0:RefreshState()
end

return slot0
