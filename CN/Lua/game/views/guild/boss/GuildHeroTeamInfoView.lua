slot0 = class("GuildHeroTeamInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubHeroTeamInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.upgradeBtnController_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.infoEnabledBtnController_ = ControllerUtil.GetController(slot0.infoBtn_.transform, "enabled")
	slot0.toggleController1_ = ControllerUtil.GetController(slot0.myHeroToggleBtn_.transform, "select")
	slot0.toggleController2_ = ControllerUtil.GetController(slot0.helpHeroToggleBtn_.transform, "select")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.selfHeroList_ = LuaList.New(handler(slot0, slot0.indexSelfHeroItem), slot0.uiListGo_, GuildBossTeamHeadItemView)
	slot0.assistantHeroList_ = LuaList.New(handler(slot0, slot0.indexAssistantItem), slot0.assitUIListGo_, GuildBossAssistantHeadItemView)
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		if (uv0:IsInSelfTeam(slot0) and 1 or 0) ~= (uv0:IsInSelfTeam(slot1) and 1 or 0) then
			return true, slot5 < slot4
		end

		return false, false
	end)
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.assistFilterView_ = GuildBossAssistHeroFilterView.New(slot0.assistHeroFilterGo_)

	slot0.assistFilterView_:SetExtraSorter(function (slot0, slot1)
		if (GuildData:GetCurrentBossAssistantHeroId(slot0.assist_hero_id) and 1 or 0) ~= (GuildData:GetCurrentBossAssistantHeroId(slot1.assist_hero_id) and 1 or 0) then
			return true, slot3 < slot2
		end

		return false, false
	end)
	slot0.assistFilterView_:SetListChangeHandler(handler(slot0, slot0.OnAssistListChange))
end

function slot0.indexAssistantItem(slot0, slot1, slot2)
	slot2:SetData(slot0.assistantDataList_[slot1])
	slot2:SetSelected(slot0.selectedAssistHeroData_ ~= nil and slot2:GetHeroId() == slot0.selectedAssistHeroData_.assist_hero_id and slot2:GetOwnerId() == slot0.selectedAssistHeroData_.member_id)
	slot2:SetTeamMark(slot0:IsHeroInTeam(slot2:GetHeroId(), slot2:GetOwnerId()) > -1, GetTips("IN_TEAM"))
	slot2:RegisterClickListener(function ()
		uv0:SelectAssistantHero(uv1)
	end)
end

function slot0.indexSelfHeroItem(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]
	slot2.gameObject_.name = tostring(slot3)

	slot2:SetHeroData(slot3)
	slot2:SetSelected(slot2.heroId_ == slot0.selectSelfHeroID_)
	slot2:SetTeamMark(slot0:IsInSelfTeam(slot3), GetTips("IN_TEAM"))
	slot2:RegisterClickListener(function ()
		uv0:SelectSelfHero(uv1.heroId_)
	end)
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	if slot0.currentIndex_ ~= 1 then
		return
	end

	slot0.selfHeroList_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		if slot0:ChooseSelfFirstSelectIndex() then
			slot0:SelectSelfHero(slot0.heroIdList_[slot2])
		else
			slot0:SelectSelfHero(slot0.selectSelfHeroID_)
		end
	end
end

function slot0.OnAssistListChange(slot0, slot1)
	slot0.assistantDataList_ = slot1

	slot0.assistantHeroList_:StartScroll(#slot0.assistantDataList_)

	if slot0.selectedAssistHeroData_ == nil then
		if #slot0.assistantDataList_ > 0 then
			slot0:SelectAssistantHero(slot0:ChooseAssistFirstSelectIndex())
		else
			slot0:SelectEmptyAssistHero()
		end
	else
		slot2 = -1

		for slot6, slot7 in ipairs(slot0.assistantDataList_) do
			if slot7 ~= nil and slot7.assist_hero_id == slot0.selectedAssistHeroID_ and slot7.member_id == slot0.selectedAssistHeroData_.member_id then
				slot2 = slot6

				break
			end
		end

		if slot2 ~= -1 then
			slot0:SelectAssistantHero(slot2)
		else
			slot0:SelectEmptyAssistHero()
		end
	end
end

function slot0.ChooseSelfFirstSelectIndex(slot0)
	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 and slot1.type == 1 then
		return table.indexof(slot0.heroIdList_, slot1.heroId)
	end

	for slot5, slot6 in ipairs(slot0.heroIdList_) do
		if not slot0:IsInSelfTeam(slot6) then
			return slot5
		end
	end

	return 1
end

function slot0.ChooseAssistFirstSelectIndex(slot0)
	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 and slot1.type == 2 then
		slot2 = nil

		for slot6, slot7 in ipairs(slot0.assistantDataList_) do
			if slot1.info.assist_hero_id == slot7.assist_hero_id and slot1.info.member_id == slot7.member_id then
				slot2 = slot6

				break
			end
		end

		return slot2
	end

	return 1
end

function slot0.SelectSelfHero(slot0, slot1)
	slot0.infoEnabledBtnController_:SetSelectedState("true")

	slot5 = 0

	slot0.upgradeBtnController_:SetSelectedIndex(slot5)

	slot0.selectSelfHeroID_ = slot1
	slot4 = slot0.selfHeroList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0:UpdateSelfHeroView()
end

function slot0.SelectEmptyAssistHero(slot0)
	slot0.heroAvatarView_:ShowHeroModel(false)

	slot0.fightPowerText_.text = "--"
	slot0.nameText_.text = "--"
	slot0.subNameText_.text = "--"

	slot0.infoEnabledBtnController_:SetSelectedState("false")
	slot0.upgradeBtnController_:SetSelectedIndex(1)
end

function slot0.SelectAssistantHero(slot0, slot1)
	slot0.infoEnabledBtnController_:SetSelectedState("true")
	slot0.upgradeBtnController_:SetSelectedIndex(0)
	slot0.heroAvatarView_:ShowHeroModel(true)

	slot2 = slot0.assistantDataList_[slot1]
	slot0.selectedAssistHeroID_ = slot2.assist_hero_id
	slot0.selectedAssistHeroData_ = slot2

	slot0.assistantHeroList_:Refresh()
	slot0:UpdateAssistHeroView()
end

function slot0.UpdateSelfHeroView(slot0)
	slot0.heroAvatarView_:ShowHeroModel(true)

	slot2 = slot0.selectSelfHeroID_
	slot0.fightPowerText_.text = getHeroPower(slot2, false)

	slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.selectSelfHeroID_).id)

	slot3 = HeroCfg[slot2]
	slot0.nameText_.text = slot3.name
	slot0.subNameText_.text = slot3.suffix

	slot0:UpdateJoin(slot2)
end

function slot0.UpdateJoin(slot0, slot1, slot2)
	if slot0:IsOnlyCaptainToRemove() then
		slot0.joinText_.text = GetTips("CAN_NOT_REMOVE")
	elseif slot0:IsHeroInTeam(slot1, slot2) > -1 then
		slot0.joinText_.text = GetTips("REMOVE_FROM_TEAM")
	else
		slot0.joinText_.text = GetTips("JOIN_TEAM")
	end
end

function slot0.IsOnlyCaptainToRemove(slot0)
	if slot0.params_.selectHeroPos ~= 1 then
		return false
	end

	slot3 = nil

	if slot0.params_.heroList[1] ~= nil and slot1[2] == nil and slot1[3] == nil then
		if slot0.currentIndex_ ~= slot1[1].type then
			return false
		end

		if slot4.type == 1 then
			if slot0.selectSelfHeroID_ == slot4.heroId then
				return true
			end
		elseif slot4.type == 2 and slot0.selectedAssistHeroID_ == slot4.info.assist_hero_id and slot0.selectedAssistHeroData_.member_id == slot4.info.member_id then
			return true
		end
	end

	return false
end

function slot0.UpdateAssistHeroView(slot0)
	if slot0.selectedAssistHeroData_.assist_hero_skin == 0 then
		slot1 = slot0.selectedAssistHeroData_.assist_hero_id
	end

	slot0.fightPowerText_.text = slot0.selectedAssistHeroData_.fight_capacity

	slot0.heroAvatarView_:SetSkinId(slot1)

	slot3 = HeroCfg[slot0.selectedAssistHeroID_]
	slot0.nameText_.text = slot3.name
	slot0.subNameText_.text = slot3.suffix

	slot0:UpdateJoin(slot0.selectedAssistHeroData_.assist_hero_id, slot0.selectedAssistHeroData_.member_id)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.currentIndex_ == 1 then
			uv0:Go("/newHero", {
				isEnter = true,
				isTemp = false,
				hid = uv0.selectSelfHeroID_,
				tempHeroList = {}
			})
		else
			if uv0.selectedAssistHeroData_ == nil then
				return
			end

			slot0 = ForeignInfoAction

			slot0:TryToCheckForeignHeroInfo(uv0.selectedAssistHeroData_.member_id, uv0.selectedAssistHeroID_, 2, function ()
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					isForeign = true,
					notShowBar = true,
					hid = uv0.selectedAssistHeroID_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		if uv0:IsOnlyCaptainToRemove() then
			return
		end

		if uv0.currentIndex_ == 1 then
			if uv0.params_.selfInfoCallback ~= nil then
				slot0 = nil
				slot2 = nil

				if uv0:IsHeroInTeam(uv0.selectSelfHeroID_) > -1 then
					slot0 = nil
					slot2 = slot1
				else
					slot0 = uv0.selectSelfHeroID_
					slot2 = uv0.params_.selectHeroPos
				end

				if slot0 and uv0:GetHeroIdPosOfTeam(slot0) ~= -1 and slot1 == -1 and slot3 ~= uv0.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end

				uv0.params_.selfInfoCallback(slot2, slot0)
			end
		else
			if uv0.selectedAssistHeroData_ == nil then
				return
			end

			if uv0.params_.assistantInfoCallback ~= nil then
				slot0 = nil
				slot2 = nil

				if uv0:IsHeroInTeam(uv0.selectedAssistHeroID_, uv0.selectedAssistHeroData_.member_id) > -1 then
					slot0 = nil
					slot2 = slot1
				else
					slot0 = uv0.selectedAssistHeroData_
					slot2 = uv0.params_.selectHeroPos
				end

				if slot0 ~= nil then
					for slot6, slot7 in ipairs(uv0.params_.heroList) do
						if slot6 ~= uv0.params_.selectHeroPos and slot7.type == 2 and slot7.assist_hero_id ~= slot0.assist_hero_id then
							ShowTips("CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP")

							return
						end
					end

					if uv0:GetHeroIdPosOfTeam(slot0.assist_hero_id) ~= -1 and slot1 == -1 and slot3 ~= uv0.params_.selectHeroPos then
						ShowTips("TEAM_REPEAT_HERO")

						return
					end
				end

				uv0.params_.assistantInfoCallback(slot2, slot0)
			end
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.myHeroToggleBtn_, nil, function ()
		uv0:SelectIndex(1)
	end)
	slot0:AddBtnListener(slot0.helpHeroToggleBtn_, nil, function ()
		uv0:SelectIndex(2)
	end)
end

function slot0.SelectIndex(slot0, slot1)
	slot0.currentIndex_ = slot1

	if slot1 == 1 then
		SetActive(slot0.uiListGo_, true)
		SetActive(slot0.filterGo_, true)
		SetActive(slot0.assitUIListGo_, false)
		SetActive(slot0.assistHeroFilterGo_, false)
		slot0.toggleController1_:SetSelectedState("true")
		slot0.toggleController2_:SetSelectedState("false")
		slot0.filterView_:Reset(true)
		slot0.filterView_:SetHeroIdList(HeroTools.Sort(HeroData:GetHeroListExcept({
			0
		})))
	else
		SetActive(slot0.uiListGo_, false)
		SetActive(slot0.filterGo_, false)
		SetActive(slot0.assitUIListGo_, true)
		SetActive(slot0.assistHeroFilterGo_, true)
		slot0.toggleController1_:SetSelectedState("false")
		slot0.toggleController2_:SetSelectedState("true")
		slot0.assistFilterView_:Reset(true)
		slot0.assistFilterView_:SetHeroList(GuildData:GetAssistantBriefList())
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ASSIST_BRIEF_UPDATE, function ()
		if uv0.assistantHeroList_ == nil then
			return
		end

		if uv0.heroAvatarView_ then
			uv0.heroAvatarView_:OnEnter()
		end
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot0.ChangeTeam(slot0, slot1, slot2, slot3)
	SetHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID, slot1, slot2)
	ComboSkillData:SetNeedRefresh(slot3)
end

function slot0.IsInSelfTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.params_.heroList) do
		if slot6.type == 1 and slot6.heroId == slot1 then
			return true
		end
	end

	return false
end

function slot0.IsHeroInTeam(slot0, slot1, slot2)
	if slot2 then
		for slot6, slot7 in pairs(slot0.params_.heroList) do
			if slot7.type == 2 and slot7.info.assist_hero_id == slot1 and slot7.info.member_id == slot2 then
				return slot6
			end
		end

		return -1
	else
		for slot6, slot7 in pairs(slot0.params_.heroList) do
			if slot7.type == 1 and slot7.heroId == slot1 then
				return slot6
			end
		end

		return -1
	end
end

function slot0.GetHeroIdPosOfTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.params_.heroList) do
		if slot6.type == 2 then
			if slot6.info.assist_hero_id == slot1 then
				return slot5
			end
		elseif slot6.heroId == slot1 then
			return slot5
		end
	end

	return -1
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	manager.ui:SetMainCamera("hero")

	if slot0.filterView_ then
		slot0.filterView_:Reset(true)
	end

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Reset(true)
	end

	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 then
		if slot1.type == 1 then
			slot0:SelectIndex(1)
		else
			slot0:SelectIndex(2)
		end
	else
		slot0:SelectIndex(1)
	end
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.currentIndex_ == 1 then
		slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	else
		slot0.assistFilterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	end

	HeroData:SaveSortValue(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if slot0.heroIdList_ and #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	if slot0.assistantDataList_ and #slot0.assistantDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.assistFilterView_:Reset()
	end
end

function slot0.OnMainHomeViewTop(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Reset(true)
	end

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Reset(true)
	end
end

function slot0.Dispose(slot0)
	if slot0.assistantHeroList_ then
		slot0.assistantHeroList_:Dispose()

		slot0.assistantHeroList_ = nil
	end

	if slot0.selfHeroList_ then
		slot0.selfHeroList_:Dispose()

		slot0.selfHeroList_ = nil
	end

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Dispose()

		slot0.assistFilterView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
