slot0 = class("EnternalMusicMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng1stUI/Music/XH1stMusicMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.pageIndex = 1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, EnternalMusicMainItem)
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("enternalMusicReward")
	end)
	slot0:AddBtnListener(slot0.m_settingBtn, nil, function ()
		JumpTools.OpenPageByJump("/enternalMusicSetting")
	end)
	slot0:AddBtnListener(slot0.m_palyBtn, nil, function ()
		slot0 = uv0.musics[uv0.pageIndex]

		MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[slot0][MusicData:GetDifficultyIndex(slot0) + 1])
	end)
	slot0.list_:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = GameSetting.enternal_music_describe and GameSetting.enternal_music_describe.value or {}
		}
	})
end

function slot0.OnEnter(slot0)
	if SettingData:GetSoundSettingData() and slot1.music then
		manager.audio:SetVolume("music", slot1.music / 100)
	end

	slot0.activity_id = slot0.params_.activity_id
	slot0.musics = {}

	for slot6, slot7 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityCfg[slot7] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(slot0.musics, slot7)
		end
	end

	slot0.pageIndex = MusicData:GetSelectIndex(slot0.activity_id)

	slot0.list_:StartScroll(#slot0.musics, slot0.pageIndex, true, false)
	slot0.list_:SwitchToPage(slot0.pageIndex)

	slot0.BGMID = 0
	slot3 = slot0.musics[slot0.pageIndex]

	MusicData:SetDifficultIndex(slot3, math.min(MusicData:GetDifficultyIndex(slot3), 1))
	slot0:OnPageChange(slot0.pageIndex)
	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
		uv0:RefrenBGM()
	end, 1, -1)

	slot0.timer:Start()
	MusicAction.SetMusicRead(slot0.activity_id)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activity_id))

	if not getData("EnternalMusic", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = GameSetting.enternal_music_describe and GameSetting.enternal_music_describe.value or {}
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activity_id))
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_timeLab.transform)

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:RefrenTime()
	end

	if ActivityData:GetActivityIsOpen(slot0.musics[slot0.pageIndex]) then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.musics[slot1])
end

function slot0.OnPageChange(slot0, slot1)
	if slot1 > #slot0.musics then
		slot1 = #slot0.musics
	end

	slot0.pageIndex = slot1

	MusicData:SetSelectIndex(slot0.pageIndex)

	if ActivityData:GetActivityIsOpen(slot0.musics[slot1]) then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end

	slot0:PlayBg()
end

function slot0.PlayBg(slot0)
	manager.audio:ClearBGMFlag()

	if not slot0.musics[slot0.pageIndex] then
		return
	end

	if ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot1][MusicData:GetDifficultyIndex(slot1) + 1] or slot2[1]].aisacKey ~= "" then
		manager.audio:SetBgmAisacControl(slot5.aisacKey, slot5.aisacValue)
	end

	slot0.BGMID = slot4

	manager.audio:PlayBGM(slot5.cueSheetName, slot5.cueName, slot5.awbFile)
end

function slot0.RefrenBGM(slot0)
	if not slot0.musics[slot0.pageIndex] then
		return
	end

	if slot0.BGMID == (ActivityMusicCfg.get_id_list_by_activity_id[slot1][MusicData:GetDifficultyIndex(slot1) + 1] or slot2[1]) then
		return
	end

	slot0:PlayBg()
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
