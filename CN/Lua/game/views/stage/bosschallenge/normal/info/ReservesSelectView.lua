slot0 = class("ReservesSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StagePrepare/HeroTeamInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, HeroTeamHeadItem)
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.favoriteCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "favorite")
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIDList_[slot1]

	slot2:SetRedPointEnable(false)

	slot2.gameObject_.name = tostring(slot3)

	slot2:SetHeroId(slot3)
	slot2:SetSelected(slot2.heroId_ == slot0.selectID_)
	slot2:SetInTeamFlag(slot0:IsInTeam(slot3))
	slot2:SetHp(false)
	slot2:SetLove(HeroData:IsFavorite(slot3) == false)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			hid = uv0.selectID_
		})
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, handler(slot0, slot0.OnJoinClick))
	slot0:AddBtnListener(slot0.favoriteBtn_, nil, function ()
		if HeroData:IsFavorite(uv0.selectID_) then
			HeroAction.SetFavoriteHeroOff(uv0.selectID_)
		else
			HeroAction.SetFavoriteHeroOn(uv0.selectID_)
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")
	slot0.filterView_:Reset(true)

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot0.heroTeam_ = slot0.params_.hero_list
	slot0.index_ = slot0.params_.index
	slot0.pos_ = slot0.params_.pos

	slot0.filterView_:SetHeroIdList(slot0:GetHeroList())

	slot0.selectID_ = slot0:GetDefaultHeroID()

	slot0:SelectHero(slot0.selectID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroIDList_, table.keyof(slot0.heroIDList_, slot0.selectID_))
	slot0:RegistEventListener(FAVORITE_HERO, handler(slot0, slot0.OnHeroFavorite))
end

function slot0.IsInTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroTeam_) do
		if slot1 == slot6 then
			return true, slot5 == 1, slot5
		end
	end

	return false, false, -1
end

function slot0.SelectHero(slot0, slot1)
	slot0.selectID_ = slot1
	slot4 = slot0.heroHeadList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
	slot0:RefreshFavorite()
end

function slot0.UpdateHeroView(slot0)
	slot0.heroAvatarView_:SetSkinId(HeroData:GetHeroData(slot0.selectID_).using_skin == 0 and slot1.id or slot1.using_skin)

	slot2 = HeroCfg[slot1.id]
	slot0.nameText_.text = slot2.name
	slot0.subNameText_.text = slot2.suffix
	slot0.fightPowerText_.text = getBattlePower(slot1)
end

function slot0.RefreshJoinBtn(slot0)
	slot0.joinBtn_.interactable = true

	if slot0.selectID_ == slot0.heroTeam_[slot0.pos_] and slot0.heroTeam_[slot0.pos_] ~= 0 then
		slot0.contorller_:SetSelectedState("2")

		slot0.joinText_.text = string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM"))
	else
		slot0.contorller_:SetSelectedState("0")

		slot0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER"))
	end
end

function slot0.ExtraSorter(slot0, slot1, slot2)
	slot3 = slot0.heroTeam_

	if slot0:indexof(slot3, slot1) ~= slot0:indexof(slot3, slot2) then
		return true, slot4 < slot5
	end

	return false, false
end

function slot0.indexof(slot0, slot1, slot2, slot3)
	slot4 = slot3 or 1

	for slot7 = slot4, #slot1 do
		if slot1[slot7] == slot2 then
			return slot7
		end
	end

	return 9999
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIDList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot0.heroIDList_)

	if #slot0.heroIDList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")

		if slot0:indexof(slot0.heroIDList_, slot0.params_.heroID) > #slot0.heroIDList_ then
			slot0:SelectHero(slot0.heroIDList_[1])
		else
			slot0:SelectHero(slot0.params_.heroID)
		end
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.OnJoinClick(slot0)
	slot0:RefreshCombo()

	if slot0.selectID_ == slot0.heroTeam_[slot0.pos_] and slot0.heroTeam_[slot0.pos_] ~= 0 then
		BattleTeamData:SetReservesTempTeamList(slot0.index_, slot0.pos_, 0)
	else
		BattleTeamData:SetReservesTempTeamList(slot0.index_, slot0.pos_, slot0.selectID_)
	end

	slot0:Back(1, {
		isInit = false
	})
end

function slot0.GetHeroList(slot0)
	return HeroTools.Sort(HeroData:GetHeroList())
end

function slot0.GetDefaultHeroID(slot0)
	if slot0.heroTeam_[slot0.pos_] and slot1 ~= 0 then
		return slot1
	end

	for slot5, slot6 in ipairs(slot0.heroIDList_) do
		if not slot0:IsInTeam(slot6) then
			return slot6
		end
	end

	for slot5, slot6 in ipairs(slot0.heroIDList_) do
		return slot6
	end

	return 0
end

function slot0.RefreshCombo(slot0)
	slot1 = slot0.params_.combo ~= 0 and slot0.params_.combo or nil
	slot2 = deepClone(slot0.heroTeam_)

	if slot0.selectID_ == slot0.heroTeam_[slot0.pos_] and slot0.heroTeam_[slot0.pos_] ~= 0 then
		slot2[slot0.pos_] = 0
	else
		slot2[slot0.pos_] = slot0.selectID_
	end

	if ComboSkillTools.CheckError(slot1, slot2, true) ~= slot1 then
		BattleTeamData:ChangeComboSkillID(slot0.index_, slot3)
	end
end

function slot0.OnTop(slot0)
	slot0:ShowDefaultBar()

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		uv0:Back(1, {
			isInit = false
		})
	end)
end

function slot0.RefreshFavorite(slot0)
	SetActive(slot0.favoriteBtn_.gameObject, true)
	slot0.favoriteCon_:SetSelectedState(HeroData:IsFavorite(slot0.selectID_) == false and "false" or "true")
end

function slot0.OnHeroFavorite(slot0)
	slot0:RefreshFavorite()
	slot0.heroHeadList_:Refresh()
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	HeroData:SaveSortValue(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if #slot0.heroIDList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.heroHeadList_ then
		slot0.heroHeadList_:Dispose()

		slot0.heroHeadList_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
