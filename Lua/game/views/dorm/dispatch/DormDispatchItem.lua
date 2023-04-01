slot0 = class("TowerStageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddClickListen()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillDisplay = DormSkillDisplay.New(slot0.m_skillDisplay)
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.qualityController_ = ControllerUtil.GetController(slot0.transform_, "quality")
	slot0.viewModeController_ = ControllerUtil.GetController(slot0.transform_, "viewmode")
	slot0.moodController_ = ControllerUtil.GetController(slot0.m_moodController, "expression")
end

function slot0.AddClickListen(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.SetHeroIcon(slot0, slot1)
	slot0.m_heroIcon.sprite = slot1
end

function slot0.GetHeroCfg(slot0)
	return HeroCfg[slot0.id]
end

function slot1(slot0)
	return HeroTools.GetHeadSprite(HeroTools.HeroUsingSkinInfo(slot0).id)
end

function slot0.SetData(slot0, slot1)
	if slot0.id ~= slot1 then
		slot0.id = slot1
		slot2 = slot0:GetHeroCfg()
		slot0.m_heroIcon.sprite = uv0(slot1)
		slot0.m_name.text = slot2.name

		slot0.qualityController_:SetSelectedIndex(slot2.rare)
		slot0.skillDisplay:SetData(slot1)
	end

	slot0:UpdateMood()
end

function slot0.SetViewMode(slot0, slot1)
	slot0.viewModeController_:SetSelectedState(slot1)
end

function slot0.UpdateMood(slot0)
	slot2 = DormConst.DORM_HERO_MAX_MOOD
	slot3 = DormData:GetDormHero(slot0.id) and slot1:GetMood() or slot2
	slot0.m_moodLab.text = slot3 .. "/" .. slot2
	slot0.m_moodProcess.fillAmount = slot3 / slot2

	if slot3 == 0 then
		slot0.moodController_:SetSelectedIndex(2)
	elseif slot3 >= 12 then
		slot0.moodController_:SetSelectedIndex(0)
	else
		slot0.moodController_:SetSelectedIndex(1)
	end

	if slot1 == nil or not slot1:GetIsInJobDuty() then
		slot0.stateController_:SetSelectedIndex(0)
	else
		slot0.m_workLab.text = slot0:GetJobName(slot1:GetCurJob())

		if slot3 == 0 then
			slot0.stateController_:SetSelectedIndex(2)
		else
			slot0.stateController_:SetSelectedIndex(1)
		end
	end
end

function slot0.GetJobName(slot0, slot1)
	return "[JOB][" .. slot1 .. "]"
end

function slot0.UpdateSelect(slot0, slot1)
	slot0.selectController_:SetSelectedIndex(slot1)
end

return slot0
