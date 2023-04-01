slot0 = class("SoloChallengeAffixView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerSoloChallengeAffixViewnewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectHandler_ = handler(slot0, slot0.OnSelectAffix)

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.buttonController_ = ControllerUtil.GetController(slot0.transform_, "buttonState")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, SoloChallengeAffixItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.activityID_ = slot0.params_.activityID
	slot0.affixList_ = ActivitySoloChallengeCfg[slot0.activityID_].affix_pool
	slot0.ownAffixID_ = slot0.params_.affixID
	slot0.ownPos_ = slot0.params_.pos
	slot0.stageID_ = slot0.params_.stageID
	slot0.maxAffixCount_ = SoloChallengeData:GetMaxAffixCount(slot0.activityID_)
	slot0.selectedAffixID_ = -1
	slot0.selected_ = false

	slot0.list_:StartScroll(#slot0.affixList_)
	slot0:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.affixList_[slot1]

	slot2:SetData(slot0.activityID_, slot3, slot0.toggleGroup_)
	slot2:SetState(SoloChallengeData:GetAffixState(slot0.activityID_, slot3))
	slot2:RegistSelectCallBack(slot0.selectHandler_)

	slot4 = false

	if (slot0.ownAffixID_ == slot3 or slot0.ownAffixID_ == -1 and slot2.stageID_ == -1) and not slot0.selected_ then
		slot4 = true
		slot0.selected_ = true
		slot0.selectedAffixID_ = slot3

		slot0:RefreshAffixDesc()
	end

	slot2:SetSelect(slot4)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.ownAffixID_ == -1 then
			uv0:EquipAffix(uv0.activityID_, uv0.stageID_, uv0.ownPos_, uv0.selectedAffixID_, uv0.newPos_)

			uv0.ownAffixID_ = uv0.selectedAffixID_
		elseif SoloChallengeData:GetNextEquipPos(uv0.activityID_, uv0.stageID_) ~= -1 then
			uv0:EquipAffix(uv0.activityID_, uv0.stageID_, slot0, uv0.selectedAffixID_, uv0.newPos_)
		end

		uv0:SelectAffix(uv0.selectedAffixID_)
	end)
	slot0:AddBtnListener(slot0.dischargeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SoloChallengeData:SetLastTeamData(uv0.activityID_, false)
		SoloChallengeData:DischargeAffix(uv0.activityID_, uv0.selectedAffixID_)
		uv0:RefreshAffixState(uv0.selectedAffixID_)

		if uv0.ownAffixID_ == uv0.selectedAffixID_ then
			uv0.ownAffixID_ = -1
		end

		uv0:SelectAffix(uv0.selectedAffixID_)
		SoloChallengeAction.SaveCustomList(uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshAffixCountText()
	slot0:RefreshIcon()
	slot0:RefreshAffixDesc()
	slot0:RefreshBtnState()
end

function slot0.RefreshIcon(slot0)
	if slot0.selectedAffixID_ ~= -1 then
		slot0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[slot0.selectedAffixID_].affix)
	end
end

function slot0.EquipAffix(slot0, slot1, slot2, slot3, slot4, slot5)
	SoloChallengeData:SetLastTeamData(slot0.activityID_, false)

	if slot5 ~= -1 then
		SoloChallengeData:DischargeAffix(slot1, slot4)
		SoloChallengeData:EquipAffix(slot1, slot2, slot3, slot4)
	else
		SoloChallengeData:EquipAffix(slot1, slot2, slot3, slot4)
	end

	slot0:RefreshAffixState(slot4)
	SoloChallengeAction.SaveCustomList(slot0.activityID_)
end

function slot0.SelectAffix(slot0, slot1)
	slot0.list_:GetItemByIndex(table.keyof(slot0.affixList_, slot1)):SetSelect(true)
end

function slot0.OnSelectAffix(slot0, slot1, slot2)
	slot0.selectedAffixID_ = slot1
	slot0.newPos_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshBtnState(slot0)
	slot1 = SoloChallengeData:CanEquipAffix(slot0.activityID_, slot0.stageID_)
	slot3 = SoloChallengeData:GetAffixState(slot0.activityID_, slot0.selectedAffixID_).stageID

	if slot0.selectedAffixID_ ~= -1 and (slot0.ownAffixID_ == slot0.selectedAffixID_ or slot3 == slot0.stageID_) then
		slot0.buttonController_:SetSelectedState("discharge")
	elseif slot0.ownAffixID_ == -1 or slot1 then
		slot0.buttonController_:SetSelectedState("equip")

		slot0.equipBtn_.interactable = true
	elseif not slot1 then
		slot0.buttonController_:SetSelectedState("equip")

		slot0.equipBtn_.interactable = false
	end
end

function slot0.RefreshAffixCountText(slot0)
	slot0.affixCountText_.text = string.format("%d/%d", SoloChallengeData:GetAffixCount(slot0.activityID_, slot0.stageID_), slot0.maxAffixCount_)
end

function slot0.RefreshAffixDesc(slot0)
	if slot0.selectedAffixID_ ~= -1 then
		slot0.affixDescText_.text = getAffixDesc(ActivityAffixPoolCfg[slot0.selectedAffixID_].affix)
		slot0.affixNameText_.text = getAffixName(ActivityAffixPoolCfg[slot0.selectedAffixID_].affix)
	end
end

function slot0.RefreshAffixState(slot0, slot1)
	if table.keyof(slot0.affixList_, slot1) then
		slot0.list_:GetItemByIndex(slot2):SetState(SoloChallengeData:GetAffixState(slot0.activityID_, slot1))
	end
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.selectHandler_ = nil
	slot0.buttonController_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnReverTeamData(slot0)
	slot0.list_:StartScroll(#slot0.affixList_)
	slot0:RefreshUI()
end

return slot0
