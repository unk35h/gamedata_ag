slot0 = class("TeachStageView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/TeachinglevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.switchBtn_ = {}
	slot0.contentView_ = {}

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TEACH_STAGE_DESC")

	slot1 = slot0.params_.switchType or BattleTeachData:GetSwitchType()

	BattleTeachData:SetSwitchType(slot1)

	slot0.lastSwitchType_ = slot1

	slot0.switchBtn_[slot1]:IsOn()
	slot0:SwitchPage(slot1, slot0.params_.isBack)

	for slot5, slot6 in pairs(slot0.contentView_) do
		slot6:OnEnter()
	end

	for slot5, slot6 in pairs(slot0.switchBtn_) do
		slot6:OnEnter()
	end

	manager.redPoint:bindUIandKey(slot0.baseBtn_.transform, RedPointConst.TEACH_BASE)
	manager.redPoint:bindUIandKey(slot0.heroBtn_.transform, RedPointConst.TEACH_CHARACTER)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnUpdate(slot0)
	if slot0.lastSwitchType_ ~= BattleTeachData:GetSwitchType() then
		slot0.lastSwitchType_ = BattleTeachData:GetSwitchType()

		slot0:SwitchPage(slot0.lastSwitchType_, false)
	end

	slot0.contentView_[slot0.lastSwitchType_]:OnUpdate()
end

function slot0.OnClickTeachViewBtn(slot0)
	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnClickTeachViewBtn()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.switchBtn_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnExit()
	end

	manager.redPoint:unbindUIandKey(slot0.baseBtn_.transform)
	manager.redPoint:unbindUIandKey(slot0.heroBtn_.transform)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.switchBtn_) do
		slot5:Dispose()
	end

	slot0.switchBtn_ = nil

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:Dispose()
	end

	slot0.contentView_ = nil
	slot0.btn_ = nil
	slot0.basePanel_ = nil
	slot0.heroPanel_ = nil
	slot0.baseBtn_ = nil
	slot0.heroBtn_ = nil
	slot0.scrollView_ = nil
	slot0.scrollViewEvent_ = nil
	slot0.heroScrollView_ = nil
	slot0.heroScrollViewEvent_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.switchBtn_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING] = TeachStageSwitchBtn.New(slot0.baseBtn_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING)
	slot0.switchBtn_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING] = TeachStageSwitchBtn.New(slot0.heroBtn_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING)
	slot0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING] = TeachStageBaseView.New(slot0.basePanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING)
	slot0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING] = TeachStageHeroView.New(slot0.heroPanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING)
end

function slot0.RemoveListeners(slot0)
end

function slot0.SwitchPage(slot0, slot1, slot2)
	if slot1 == 12 then
		OperationRecorder.Record("teachStage", "base")
	elseif slot1 == 13 then
		OperationRecorder.Record("teachStage", "role")
	end

	for slot6, slot7 in pairs(slot0.contentView_) do
		slot7:SwitchPageUI(slot1, slot0.params_.heroID, slot2 ~= true)

		slot0.params_.heroID = nil
	end
end

return slot0
