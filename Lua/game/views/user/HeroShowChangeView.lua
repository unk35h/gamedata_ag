slot0 = class("HeroShowChangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Main/HeroShowChangeUI"
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
	slot0.btnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "show")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, HeroTeamHeadItem)
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(function (slot0, slot1)
		slot2 = PlayerData:GetHeroShowList()

		if uv0:indexof(slot2, slot0) ~= uv0:indexof(slot2, slot1) then
			return true, slot3 < slot4
		end

		return false, false
	end)
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			hid = uv0.selectID_
		})
	end)
	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		uv0:SetHeroShowList(uv0.lastHeroID_, uv0.selectID_)

		if uv0.heroAvatarView_ then
			uv0.heroAvatarView_:RemoveTween()
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.desShowBtn_, nil, function ()
		uv0:SetHeroShowList(uv0.lastHeroID_, nil)

		if uv0.heroAvatarView_ then
			uv0.heroAvatarView_:RemoveTween()
		end

		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")
	slot0:ShowDefaultBar()
	slot0.filterView_:Reset()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot0.heros_ = PlayerData:GetHeroShowList()

	slot0.filterView_:SetHeroIdList(slot0:GetHeroList())

	slot0.selectID_ = slot0:GetDefaultHeroID()

	slot0:SelectHero(slot0.selectID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroIDList_, table.keyof(slot0.heroIDList_, slot0.selectID_))
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIDList_[slot1]

	slot2:SetRedPointEnable(false)

	slot2.gameObject_.name = tostring(slot3)

	slot2:SetHeroId(slot3)
	slot2:SetSelected(slot2.heroId_ == slot0.selectID_)
	slot2:SetInShowFlag(slot0:IsInHeros(slot3))
	slot2:SetHp(false)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
	end)
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

function slot0.SelectHero(slot0, slot1)
	slot0.selectID_ = slot1
	slot4 = slot0.heroHeadList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshShowBtn()
end

function slot0.UpdateHeroView(slot0)
	slot0.heroAvatarView_:SetSkinId(HeroData:GetHeroData(slot0.selectID_).using_skin == 0 and slot1.id or slot1.using_skin)

	slot2 = HeroCfg[slot1.id]
	slot0.nameText_.text = slot2.name
	slot0.subNameText_.text = slot2.suffix
	slot0.fightPowerText_.text = getBattlePower(slot1)
end

function slot0.RefreshShowBtn(slot0)
	slot0.btnController_:SetSelectedState(slot0.lastHeroID_ == slot0.selectID_ and "disShow" or "show")
end

function slot0.GetHeroList(slot0)
	return HeroTools.Sort(HeroData:GetHeroList())
end

function slot0.GetDefaultHeroID(slot0)
	slot0.lastHeroID_ = slot0.params_.heroID

	if slot0.params_.heroID then
		return slot1
	end

	for slot5, slot6 in ipairs(slot0.heroIDList_) do
		if not slot0:IsInHeros(slot6) then
			return slot6
		end
	end

	for slot5, slot6 in ipairs(slot0.heroIDList_) do
		return slot6
	end

	return 0
end

function slot0.IsInHeros(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.heros_) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.SetHeroShowList(slot0, slot1, slot2)
	if slot1 == nil and slot2 == nil then
		return
	end

	slot3 = PlayerData:GetHeroShowList()

	if slot1 == nil then
		for slot7 = 1, #slot3 do
			if slot3[slot7] == slot2 then
				table.remove(slot3, slot7)
			end
		end

		table.insert(slot3, slot2)
	elseif slot2 == nil then
		for slot7 = 1, #slot3 do
			if slot3[slot7] == slot1 then
				table.remove(slot3, slot7)

				break
			end
		end
	else
		slot4 = 0

		for slot8 = 1, #slot3 do
			if slot3[slot8] == slot2 then
				slot4 = slot8
			end
		end

		for slot8 = 1, #slot3 do
			if slot3[slot8] == slot1 then
				if slot4 == 0 then
					slot3[slot8] = slot2
				else
					slot3[slot4] = slot3[slot8]
					slot3[slot8] = slot3[slot4]
				end
			end
		end
	end

	PlayerAction.ChangeHeros(slot3)
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnExit(slot0)
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
