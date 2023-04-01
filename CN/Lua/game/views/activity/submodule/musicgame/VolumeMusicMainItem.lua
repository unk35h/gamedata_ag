slot0 = class("VolumeMusicMainItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.difficultController_ = ControllerUtil.GetController(slot0.transform_, "difficult")
	slot0.selectDifficult = 0
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_easyBtn, nil, function ()
		uv0.selectDifficult = 0

		uv0.difficultController_:SetSelectedIndex(uv0.selectDifficult)
		MusicData:SetDifficultIndex(uv0.music_id, uv0.selectDifficult)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_difficult, nil, function ()
		if uv0.surpriseId ~= 0 then
			if uv0.surpriseTime < Time.realtimeSinceStartup - 5 then
				uv0.surpriseTime = slot0
				uv0.surpriseCount = 1
			else
				uv0.surpriseCount = uv0.surpriseCount + 1

				if uv0.surpriseCount >= 5 then
					MusicAction.Play(uv0.surpriseId)
				end
			end
		end

		uv0.selectDifficult = 1

		uv0.difficultController_:SetSelectedIndex(uv0.selectDifficult)
		MusicData:SetDifficultIndex(uv0.music_id, uv0.selectDifficult)
		uv0:RefreshUI()
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.music_id = slot1
	slot0.surpriseTime = 0
	slot0.surpriseCount = 0
	slot0.surpriseId = 0

	for slot6, slot7 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id]) do
		if ActivityMusicCfg[slot7].difficult > 2 then
			slot0.surpriseId = slot7

			break
		end
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.selectDifficult = MusicData:GetDifficultyIndex(slot0.music_id)

	slot0.difficultController_:SetSelectedIndex(slot0.selectDifficult)

	slot4 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id][slot0.selectDifficult + 1]]

	slot0:RefrenTime()

	slot0.m_title.text = slot4.name
	slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/VolumeIIIDownUI/" .. slot4.icon)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.RefrenTime(slot0)
	slot4 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id][slot0.selectDifficult + 1]]

	if ActivityData:GetActivityData(slot0.music_id) then
		if slot5:IsActivitying() then
			if MusicData:GetScore(slot0.music_id, slot1) == 0 then
				slot0.stateController_:SetSelectedIndex(1)
				slot0.gradeController_:SetSelectedIndex(5)
			else
				slot0.stateController_:SetSelectedIndex(0)

				slot0.m_scoreLab.text = slot6
				slot12 = slot6 / slot4.total_score * 100
				slot0.m_accuracyLab.text = string.format("%.2f%%", slot12)

				for slot12, slot13 in ipairs(GameSetting.attach_music_grade.value) do
					if slot13 <= slot7 then
						slot0.gradeController_:SetSelectedIndex(slot12 - 1)

						break
					end
				end
			end
		else
			slot6 = manager.time:GetServerTime()

			if slot5 and slot6 < slot5.startTime then
				slot0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot5.startTime))
			else
				slot0.m_lockLab.text = GetTips("TIME_OVER")
			end

			slot0.stateController_:SetSelectedIndex(2)
			slot0.gradeController_:SetSelectedIndex(5)
		end
	else
		slot0.m_lockLab.text = GetTips("TIME_OVER")

		slot0.stateController_:SetSelectedIndex(2)
	end
end

function slot0.UpdateScale(slot0, slot1)
	slot5 = 1 - math.abs(slot1:InverseTransformPoint(slot0.transform_:TransformPoint(Vector3(0, 0, 0))).x + slot0.transform_.rect.width / 2) / 8000
	slot0.m_content.localScale = Vector2.New(slot5, slot5)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
