slot0 = class("AudioMgr")
slot1 = {
	"music",
	"effect",
	"voice"
}

function slot0.Ctor(slot0)
	slot0:OnCtor()
end

function slot0.OnCtor(slot0)
end

function slot0.InitListener(slot0)
	print("Initialize Audio Mgr")
	AudioManager.Instance:SetListener(manager.ui.mainCamera)
	AudioManager.Instance:CreateCriAtom()
end

function slot0.SetLocalizationFlag(slot0, slot1)
	AudioManager.Instance:SetLocalizationFlag(slot1)
end

function slot0.GetLocalizationFlag(slot0)
	return AudioManager.Instance:GetLocalizationFlag()
end

function slot0.SetAudioMasterMute(slot0, slot1)
	AudioManager.Instance:SetAudioMasterMute(slot1)
end

function slot0.ClearBGMFlag(slot0)
	if AudioManager.Instance:GetPlayer(uv0[1]) ~= nil then
		slot1.cueName = ""
	end
end

function slot0.PlayBGM(slot0, slot1, slot2, slot3)
	return AudioManager.Instance:Play(uv0[1], slot1, slot2, slot3)
end

function slot0.AddCue(slot0, slot1, slot2, slot3)
	AudioManager.Instance:AddCue(slot1, slot2, slot3)
end

function slot0.PlayEffect(slot0, slot1, slot2, slot3)
	return AudioManager.Instance:Play(uv0[2], slot1, slot2, slot3)
end

function slot0.StopEffect(slot0)
	AudioManager.Instance:Stop(uv0[2])
end

function slot0.PlayVoice(slot0, slot1, slot2, slot3)
	return AudioManager.Instance:Play(uv0[3], slot1, slot2, slot3)
end

function slot0.StopVoice(slot0)
	AudioManager.Instance:Stop(uv0[3])
end

function slot0.StopVoiceImmediate(slot0)
	AudioManager.Instance:StopImmediate(uv0[3])
end

function slot0.PauseVoice(slot0, slot1)
	AudioManager.Instance:Pause(uv0[3], slot1)
end

function slot0.IsStoppedOfVoice(slot0)
	return AudioManager.Instance:IsStopped(uv0[3])
end

function slot0.GetVoiceLength(slot0, slot1, slot2, slot3)
	return AudioManager.Instance:GetCueInfoLength(uv0[3], slot1, slot2, slot3 ~= "")
end

function slot0.Play(slot0, slot1, slot2, slot3, slot4)
	return AudioManager.Instance:Play(slot1, slot2, slot3, slot4)
end

function slot0.Pause(slot0, slot1, slot2)
	AudioManager.Instance:Pause(slot1, slot2)
end

function slot0.PauseAll(slot0, slot1)
	AudioManager.Instance:PauseAll(slot1)
end

function slot0.Stop(slot0, slot1)
	AudioManager.Instance:Stop(slot1)
end

function slot0.StopAll(slot0)
	AudioManager.Instance:StopAll()
end

function slot0.RemoveCue(slot0, slot1)
	AudioManager.Instance:RemoveCue(slot1)
end

function slot0.SetVolume(slot0, slot1, slot2)
	AudioManager.Instance:SetVolume(slot1, slot2)
end

function slot0.GetVolume(slot0, slot1)
	return AudioManager.Instance:GetVolume(slot1)
end

function slot0.GetMusicVolume(slot0)
	return AudioManager.Instance:GetVolume(uv0[1])
end

function slot0.GetEffectVolume(slot0)
	return AudioManager.Instance:GetVolume(uv0[2])
end

function slot0.GetVoiceVolume(slot0)
	return AudioManager.Instance:GetVolume(uv0[3])
end

function slot0.PlayUIAudio(slot0, slot1)
	AudioManager.Instance:PlayUIAudio(slot1)
end

function slot0.PlayUIAudioByVoice(slot0, slot1)
	slot2 = -1

	if slot1 == "open_battel" then
		slot2 = 14
	elseif slot1 == "expup" then
		slot2 = 17
	elseif slot1 == "pro1" then
		slot2 = 18
	elseif slot1 == "pro2" then
		slot2 = 18
	elseif slot1 == "pro3" then
		slot2 = 19
	elseif slot1 == "sign_in" then
		slot2 = 20
	elseif slot1 == "stage_slide" then
		slot2 = 21
	elseif slot1 == "equip" then
		slot2 = 22
	elseif slot1 == "hero_change" then
		slot2 = 25
	end

	if slot2 ~= -1 then
		manager.audio:PlayUIAudio(slot2)
	end
end

function slot0.SetEffectSelectorLabel(slot0, slot1, slot2)
	AudioManager.Instance:SetSelectorLabel(uv0[2], slot1, slot2)
end

function slot0.SetObtainGoldSelectorLabel(slot0)
	AudioManager.Instance:SetSelectorLabel(uv0[2], "search", "gold")
end

function slot0.SetObtainPurpleSelectorLabel(slot0)
	AudioManager.Instance:SetSelectorLabel(uv0[2], "search", "purple")
end

function slot0.SetObtainBlueSelectorLabel(slot0)
	AudioManager.Instance:SetSelectorLabel(uv0[2], "search", "blue")
end

function slot0.Dispose(slot0)
end

function slot0.DestoryCriAtom(slot0)
	AudioManager.Instance:DestoryCriAtom()
end

function slot0.GetBgmPlayer(slot0)
	return AudioManager.Instance:GetPlayer(uv0[1])
end

function slot0.SetBgmAisacControl(slot0, slot1, slot2)
	return AudioManager.Instance:SetAisacControl(uv0[1], slot1, slot2)
end

function slot0.ResetParametersBgm(slot0)
	AudioManager.Instance:ResetParameters(uv0[1])
end

function slot0.SetEffectAisacControl(slot0, slot1, slot2)
	return AudioManager.Instance:SetAisacControl(uv0[2], slot1, slot2)
end

return slot0
