slot0 = class("ChapterMapView", ReduxView)
slot1 = import("game.const.BattleConst")

function slot0.UIName(slot0)
	return "UI/Stage/ChapterMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.toggleView_ = {}
	slot0.contentView_ = {}

	slot0:InitUI()

	slot0.changeSelectChapterHandler_ = handler(slot0, slot0.ChangeSelectChapterID)
	slot0.changeSelectHardLevelHandler_ = handler(slot0, slot0.ChangeSelectHardLevel)

	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("cooperationApply")
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	slot0:CheckCooperationInviteEntry()
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("chapterSelect")
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)

	slot4 = CHANGE_PLOT_HARD_LEVEL
	slot5 = slot0.changeSelectHardLevelHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnEnter()
	end

	slot4 = slot0.params_.chapterToggle

	slot0:SwitchToggle(slot4)

	for slot4, slot5 in pairs(slot0.toggleView_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)

	slot4 = CHANGE_PLOT_HARD_LEVEL
	slot5 = slot0.changeSelectHardLevelHandler_

	manager.notify:RemoveListener(slot4, slot5)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnExit()
	end

	manager.ui:ResetMainCamera()

	for slot4, slot5 in pairs(slot0.toggleView_) do
		slot5:OnExit()
	end

	slot0:RecordStay(slot0.curToggle)
end

function slot0.Dispose(slot0)
	slot0.changeSelectChapterHandler_ = nil
	slot0.changeSelectHardLevelHandler_ = nil

	if slot0.clickListenerTimer_ then
		slot0.clickListenerTimer_:Stop()

		slot0.clickListenerTimer_ = nil
	end

	for slot4, slot5 in pairs(slot0.toggleView_) do
		slot5:Dispose()
	end

	slot0.toggleView_ = nil

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:Dispose()
	end

	slot0.contentView_ = nil

	uv0.super.Dispose(slot0)

	slot0.mainToggle_ = nil
	slot0.resourceToggle_ = nil
	slot0.equipToggle_ = nil
	slot0.challengeToggle_ = nil
	slot0.mapContent_ = nil
	slot0.resourceContent_ = nil
	slot0.challengeContent_ = nil
	slot0.equipContent_ = nil
end

function slot0.OnUpdate(slot0)
	slot0:SwitchToggle(slot0.params_.chapterToggle)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggleView_[uv0.TOGGLE.PLOT] = ChapterBtnView.New(slot0.mainToggle_, uv0.TOGGLE.PLOT)
	slot0.toggleView_[uv0.TOGGLE.RESOURCE] = ChapterBtnView.New(slot0.resourceToggle_, uv0.TOGGLE.RESOURCE)
	slot0.toggleView_[uv0.TOGGLE.CHALLENGE] = ChapterBtnView.New(slot0.challengeToggle_, uv0.TOGGLE.CHALLENGE)
	slot0.toggleView_[uv0.TOGGLE.EQUIP] = ChapterBtnView.New(slot0.equipToggle_, uv0.TOGGLE.EQUIP)
	slot0.toggleView_[uv0.TOGGLE.SUB_PLOT] = ChapterBtnView.New(slot0.subPlotToggle_, uv0.TOGGLE.SUB_PLOT)
end

function slot0.ChangeSelectChapterID(slot0, slot1)
	if slot0.contentView_[slot1] then
		slot0.contentView_[slot1]:ChangePlotSelectChapter()
	end
end

function slot0.ChangeSelectHardLevel(slot0)
	if slot0.contentView_[uv0.TOGGLE.PLOT] then
		slot0.contentView_[uv0.TOGGLE.PLOT]:ChangeHardLevel()
	end
end

function slot0.UnBindFun(slot0)
	slot0[CHANGE_PLOT_SELECT_CHAPTER] = nil
	slot0[CHANGE_PLOT_HARD_LEVEL] = nil
end

function slot0.SwitchToggle(slot0, slot1)
	for slot5, slot6 in pairs(slot0.toggleView_) do
		slot0.toggleView_[slot5]:SelectChapterToggle(slot5 == slot1)
	end

	if slot0.contentView_[slot1] == nil then
		slot0:CreateContentView(slot1)
	end

	for slot5, slot6 in pairs(slot0.contentView_) do
		slot0.contentView_[slot5]:SetActive(slot5 == slot1)
	end

	if slot0.curToggle and slot1 ~= slot0.curToggle then
		slot0:RecordStay(slot0.curToggle)
	end

	slot0.curToggle = slot1
end

function slot0.CreateContentView(slot0, slot1)
	if slot1 == uv0.TOGGLE.PLOT then
		slot0.contentView_[slot1] = ChapterMapContentView.New(slot0.mapContent_, slot1)
	elseif slot1 == uv0.TOGGLE.RESOURCE then
		slot0.contentView_[slot1] = ChapterDailyContentView.New(slot0.resourceContent_, slot1)
	elseif slot1 == uv0.TOGGLE.EQUIP then
		slot0.contentView_[slot1] = ChapterEquipContentView.New(slot0.equipContent_, slot1)
	elseif slot1 == uv0.TOGGLE.CHALLENGE then
		slot0.contentView_[slot1] = ChapterChallengeContentView.New(slot0.challengeContent_, slot1, slot0)
	elseif slot1 == uv0.TOGGLE.SUB_PLOT then
		slot0.contentView_[slot1] = SubPlotContentView.New(slot0.subPlotContent_, slot1)
	end

	slot0.contentView_[slot1]:OnEnter()
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == uv0.TOGGLE.PLOT then
		slot3 = 10
	elseif slot1 == uv0.TOGGLE.RESOURCE then
		slot3 = 20
	elseif slot1 == uv0.TOGGLE.EQUIP then
		slot3 = 30
	elseif slot1 == uv0.TOGGLE.CHALLENGE then
		slot3 = 40
	elseif slot1 == uv0.TOGGLE.SUB_PLOT then
		slot3 = 50
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHAPTER_MAP", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return slot0.m_inviteBtn.gameObject
end

return slot0
