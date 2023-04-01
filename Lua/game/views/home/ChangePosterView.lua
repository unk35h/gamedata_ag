slot0 = class("ChangePosterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Hero/ExchangeTheRolesoUI"
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
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, NewHeroHead)
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroIdList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot0.heroIdList_)

	if #slot0.heroIdList_ > 0 then
		slot0.emptyController_:SetSelectedState("false")
		slot0:SelectHero(slot0.heroIdList_[1])
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		PlayerAction.ChangePosterGirl(uv0.curHeroId_)
	end)
	slot0:AddBtnListener(slot0.skinbtnBtn_, nil, function ()
		uv0:Go("/heroSkin", {
			heroID = uv0.curHeroId_
		})
	end)
end

function slot0.OnChangePosterGirl(slot0, slot1, slot2)
	if slot0.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		slot0:Back()
	end
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroIdList_[slot1]

	slot2:SetRedPointEnable(false)

	slot2.gameObject_.name = tostring(slot3)

	slot2:SetHeroId(slot3)
	slot2:SetSelected(slot2.heroId_ == slot0.curHeroId_)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_)
		OperationRecorder.Record("changePoster", "selectHero")
	end)
end

function slot0.SelectHero(slot0, slot1)
	slot0.curHeroId_ = slot1
	slot0.curHeroInfo_ = HeroData:GetHeroList()[slot0.curHeroId_]
	slot0.heroCfg_ = HeroCfg[slot1]
	slot4 = slot0.heroHeadList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
end

function slot0.UpdateHeroView(slot0)
	slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.curHeroId_).id)

	slot0.nameText_.text = slot0.heroCfg_.name
	slot0.subNameText_.text = slot0.heroCfg_.suffix
	slot0.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(slot0.curHeroId_))
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.filterView_:SetHeroIdList(HeroTools.Sort(HeroData:GetHeroList()))
	slot0:UpdateBar()
	manager.ui:SetMainCamera("hero")

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot2 = PlayerData:GetPlayerInfo().poster_girl
	slot3 = 1

	if slot0.params_.index then
		slot2 = slot0.heroIdList_[slot0.params_.index]
	else
		for slot7, slot8 in ipairs(slot0.heroIdList_) do
			if slot8 == slot2 then
				slot3 = slot7

				break
			end
		end
	end

	slot0:SelectHero(slot2)
	slot0.heroHeadList_:StartScroll(#slot0.heroIdList_, slot3)
end

function slot0.OnMainHomeViewTop(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Reset()
	end

	slot0.pos_ = nil
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if #slot0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	slot0.params_.index = table.keyof(slot0.heroIdList_, slot0.curHeroId_)
	slot0.pos_ = slot0.heroHeadList_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	if slot0.heroHeadList_ then
		slot0.heroHeadList_:Dispose()

		slot0.heroHeadList_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
