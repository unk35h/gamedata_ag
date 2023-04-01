slot0 = class("HeroVoiceItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")

	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if uv0.func_ then
			uv0.func_(uv0.index, uv0.id_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.heroId_ = slot2
	slot0.id_ = slot3.id

	if slot3.isUnlock then
		slot0.controller_:SetSelectedState("unlock")

		slot0.unlocktextText_.text = HeroVoiceCfg[slot3.id].title
	else
		slot0.controller_:SetSelectedState("lock")

		slot0.locktexttitleText_.text = HeroVoiceCfg[slot3.id].title

		if DormTools:IsVoiceNeedUnlock(slot3.id) then
			slot0.textconditionText_.text = string.format(GetTips("DORM_VOICE_UNLOCK_TIP"), DormTools:GetVoiceUnlockLevel(slot0.heroId_, slot0.id_))
		else
			slot0.textconditionText_.text = ConditionCfg[HeroVoiceCfg[slot3.id].unlock_condition].desc
		end
	end
end

function slot0.StopPlay(slot0)
	slot0.controller_:SetSelectedState("unlock")
end

function slot0.StartPlay(slot0)
	slot0.controller_:SetSelectedState("playing")
end

function slot0.AddUIListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
