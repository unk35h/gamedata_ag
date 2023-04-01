slot0 = class("MoonBoResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeBocakeResultUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.longController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "IsShowLong")
	slot0.shortController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "IsShowShort")
	slot0.discControllers_ = {
		ControllerUtil.GetController(slot0.diceTrans1_, "num"),
		ControllerUtil.GetController(slot0.diceTrans2_, "num"),
		ControllerUtil.GetController(slot0.diceTrans3_, "num"),
		ControllerUtil.GetController(slot0.diceTrans4_, "num"),
		ControllerUtil.GetController(slot0.diceTrans5_, "num"),
		ControllerUtil.GetController(slot0.diceTrans6_, "num")
	}
	slot0.isPlaying = false
	slot0.curFrame_ = 0
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()

	slot0.settingData_ = SettingData:GetPicSettingData()
	slot2 = 0
	slot0.timer_ = FrameTimer.New(function ()
		uv0.curFrame_ = uv0.curFrame_ + 1

		if uv0.curFrame_ > uv1 * 2 then
			uv0.isPlaying = false
		end
	end, 1, (slot0.settingData_.frame + 1 == 1 and 30 or 60) * 2 + 10)

	slot0.timer_:Start()
end

function slot0.RefreshUI(slot0)
	SetActive(slot0.liziGo1_, false)
	SetActive(slot0.liziGo2_, false)
	SetActive(slot0.liziGo3_, false)
	SetActive(slot0.liziGo4_, false)
	SetActive(slot0.liziGo5_, false)
	SetActive(slot0.liziGo6_, false)

	slot1 = MoonBoData:GetCurDices()

	for slot5 = 1, 6 do
		slot0.discControllers_[slot5]:SetSelectedState(string.format("%s", slot1[slot5]))
		SetActive(slot0.discControllers_[slot5].gameObject, false)
	end

	if MoonBoData:GetCurLevel() == 0 then
		slot0.shortController_:SetSelectedState("false")
		slot0.longController_:SetSelectedState("false")
		slot0.noflashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		slot0.curDir_ = slot0.noflashDir_
		slot0.isPlaying = true
		slot0.curFrame_ = 0
	else
		slot0.shortController_:SetSelectedState("true")

		slot0.levelText_.color = Color.New(slot0.levelText_.color.r, slot0.levelText_.color.g, slot0.levelText_.color.b, 0)
		slot0.levelText_.text = MoonBoData:LevelNumToLanguage(MoonBoData:GetCurLevel())

		if MoonBoData:GetIsShowText() then
			slot0.longController_:SetSelectedState("true")

			slot0.resultText_.color = Color.New(slot0.resultText_.color.r, slot0.resultText_.color.g, slot0.resultText_.color.b, 0)
			slot0.resultText_.text = string.format(GetTips("ACTIVITY_MOONCAKE_GAMBLING_REWARD_NONE"), slot3, slot3)
		else
			slot0.longController_:SetSelectedState("false")
		end

		slot0.flashDir_:Play()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_diceresult", "")

		slot0.curDir_ = slot0.flashDir_
		slot0.isPlaying = true
		slot0.curFrame_ = 0
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.isPlaying then
			uv0.isPlaying = false
			uv0.curDir_.time = 2

			manager.audio:StopEffect()
		else
			MoonBoData:SetIsShowReward(true)
			uv0:Back()
		end
	end)
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
