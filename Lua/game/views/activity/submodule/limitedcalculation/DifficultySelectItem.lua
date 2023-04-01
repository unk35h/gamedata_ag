slot0 = class("DifficultSelectItem", ReduxView)
slot1 = {
	[ActivityConst.SUMMER_LIMITED_CALCULATION] = 4,
	[ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION] = 4
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.difficultyCon_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if uv0.clickFun_ then
			uv0.clickFun_(uv0.id_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = ActivityLimitCalculationCfg[slot0.id_]
	slot0.difficulty_ = slot0.cfg_.difficulty

	slot0.difficultyCon_:SetSelectedState(slot0.difficulty_)

	slot0.odds_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_POINT_RANK"), slot0.cfg_.reward_point / 100)
	slot0.enemyBuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_ENEMY_LEVEL"), slot0.cfg_.enemy_level)
	slot0.debuff_.text = string.format(GetTips("ACTIVITY_LIMIT_CALCULATION_PLAYER_LEVEL"), slot0.cfg_.player_level)
	slot3 = false

	if uv0[slot1] then
		slot3 = uv0[slot1] < slot0.difficulty_ and not LimitedCalculationData:IsClearActivity(slot0.activityID_, LimitedCalculationData:GetDifficultyList(slot1)[uv0[slot1]])
	end

	if slot3 then
		slot0.lockController_:SetSelectedState("off")
	else
		slot0.lockController_:SetSelectedState("on")
	end
end

function slot0.SetSelected(slot0, slot1)
	if slot0.id_ == slot1 then
		slot0.selectCon_:SetSelectedState("selected")
	else
		slot0.selectCon_:SetSelectedState("unselect")
	end
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFun_ = slot1
end

function slot0.OnExit(slot0)
	slot0.clickFun_ = nil
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
