slot0 = class("VolumeMusicSettlementView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicSettlementUI"
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

	slot0.difficultController_ = ControllerUtil.GetController(slot0.transform_, "difficult")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.fullComboController_ = ControllerUtil.GetController(slot0.transform_, "fullCombo")
	slot0.newController_ = ControllerUtil.GetController(slot0.transform_, "new")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_restartBtn, nil, function ()
		if ActivityMusicCfg[MusicData:GetGameId()] then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = slot1.activity_id,
				difficulty_id = slot1.difficult
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/volumeMusicMain", {
			activity_id = ActivityConst.VOLUME_MUSIC
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityMusicCfg[MusicData:GetGameId()]
	slot0.m_name.text = slot2.name
	slot0.m_bg.sprite = getSpriteWithoutAtlas("Textures/VolumeIIIDownUI/" .. slot2.icon)

	if slot2.difficult == 2 then
		slot0.difficultController_:SetSelectedIndex(1)
	elseif slot2.difficult == 9 then
		slot0.difficultController_:SetSelectedIndex(2)
	else
		slot0.difficultController_:SetSelectedIndex(0)
	end

	slot3 = slot0.params_.cur
	slot0.m_curScoreLab.text = slot3
	slot0.m_maxScoreLab.text = slot0.params_.max
	slot0.m_comboLab.text = MusicData:GetMaxComboHit()
	slot0.m_accuracyLab.text = string.format("%.2f%%", slot3 / slot2.total_score * 100)
	slot6 = MusicData:GetGameRecord(-1)
	slot0.m_perfectLab.text = MusicData:GetGameRecord(1)
	slot0.m_preciseLab.text = MusicData:GetGameRecord(0)
	slot0.m_mistakeLab.text = slot6

	if slot6 == 0 then
		slot0.fullComboController_:SetSelectedIndex(1)
	else
		slot0.fullComboController_:SetSelectedIndex(0)
	end

	slot0.newController_:SetSelectedIndex(slot0.params_.new and 1 or 0)

	for slot11, slot12 in ipairs(GameSetting.attach_music_grade.value) do
		if slot12 <= slot5 then
			slot0.gradeController_:SetSelectedIndex(slot11 - 1)

			break
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
