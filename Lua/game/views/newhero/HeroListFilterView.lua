slot0 = class("HeroListFilterView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.isSelfHero_ = true
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.curOrder_ = "desc"
	slot0.curSortType_ = 0
	slot0.curRaceIndex_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroSorter_ = HeroSorter.New()
	slot0.orderController_ = ControllerUtil.GetController(slot0.sortBtn_.gameObject.transform, "order")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		uv0:SortListByOrder(uv0.orderController_:GetSelectedState() == "asc" and "desc" or "asc")
	end)
	slot0:AddToggleListener(slot0.sortTypeDropdown_, function (slot0)
		uv0:SortListByType(slot0)
	end)
	slot0:AddToggleListener(slot0.campDropdown_, function (slot0)
		uv0:FilterListByRace(slot0)
	end)
end

function slot0.SortListByOrder(slot0, slot1)
	slot0.curOrder_ = slot1

	slot0.orderController_:SetSelectedState(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.SortListByType(slot0, slot1)
	slot0.curSortType_ = slot1

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.FilterListByRace(slot0, slot1)
	slot0.curRaceIndex_ = slot1
	slot0.displayIdList_ = {}

	if slot1 == 0 then
		for slot5, slot6 in ipairs(slot0.idList_) do
			if not HeroTools.GetIsHide(slot6) then
				table.insert(slot0.displayIdList_, slot6)
			end
		end
	else
		for slot5, slot6 in ipairs(slot0.idList_) do
			if HeroCfg[slot6].race == slot1 and not HeroTools.GetIsHide(slot6) then
				table.insert(slot0.displayIdList_, slot6)
			end
		end
	end

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.SetHeroIdList(slot0, slot1, slot2)
	slot0.idList_ = slot1
	slot0.displayIdList_ = {}
	slot0.extra_ = slot2
	slot0.isForeign_ = slot2 and slot2.isForeign
	slot0.isTemp_ = slot2 and slot2.isTemp

	for slot6, slot7 in ipairs(slot1) do
		if not HeroTools.GetIsHide(slot7) then
			table.insert(slot0.displayIdList_, slot7)
		end
	end

	if slot0.curRaceIndex_ ~= 0 then
		slot0:FilterListByRace(slot0.curRaceIndex_)
	end

	slot0:UpdateList()
end

function slot0.UpdateList(slot0)
	slot1 = GameSetting.unlock_hero_need.value
	slot2 = slot0.heroSorter_

	slot2:Reset()
	table.sort(slot0.displayIdList_, function (slot0, slot1)
		slot2 = false
		slot3 = false

		if uv0.extraSorter_ ~= nil then
			slot4, slot3 = uv0.extraSorter_(slot0, slot1)

			if slot4 then
				return slot3
			end
		end

		slot4, slot5 = nil

		if uv0.isForeign_ then
			-- Nothing
		elseif uv0.isTemp_ then
			slot4 = TempHeroData:GetHeroDataByHeroID(uv0.extra_.tempHeroList, slot0)
			slot5 = TempHeroData:GetHeroDataByHeroID(uv0.extra_.tempHeroList, slot1)
		else
			slot4 = HeroData:GetHeroData(slot0)
			slot5 = HeroData:GetHeroData(slot1)
		end

		if slot4.unlock ~= slot5.unlock then
			return slot5.unlock < slot4.unlock
		end

		if slot4.unlock == 0 and slot5.unlock == 0 and (uv1[HeroCfg[slot0].rare] <= slot4.piece and 1 or 0) ~= (uv1[HeroCfg[slot1].rare] <= slot5.piece and 1 or 0) then
			return slot9 < slot8
		end

		if not uv0.extra_ and HeroData:IsFavorite(slot0) ~= HeroData:IsFavorite(slot1) and (not slot6 or not slot7) then
			return slot6 ~= false
		end

		if uv0.curSortType_ == 0 then
			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		else
			slot6, slot3 = uv0:StarSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:LevelSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		end

		return slot1 < slot0
	end)

	if slot0.callback_ ~= nil then
		slot0.callback_(slot0.displayIdList_)
	end
end

function slot0.SetListChangeHandler(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetExtraSorter(slot0, slot1)
	slot0.extraSorter_ = slot1
end

function slot0.SetIsSelfHero(slot0, slot1)
	slot0.isSelfHero_ = slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.FightPowerSorter(slot0, slot1, slot2)
	slot3, slot4 = nil

	if slot0.isForeign_ then
		-- Nothing
	elseif slot0.isTemp_ then
		slot3 = TempHeroData:GetBattlePower(slot1, slot0.extra_)
		slot4 = TempHeroData:GetBattlePower(slot2, slot0.extra_)
	else
		slot3 = slot0.heroSorter_:GetHeroPower(slot1)
		slot4 = slot0.heroSorter_:GetHeroPower(slot2)
	end

	if slot3 ~= slot4 then
		if slot0.curOrder_ == "desc" then
			return true, slot4 < slot3
		else
			return true, slot3 < slot4
		end
	end

	return false, false
end

function slot0.StarSorter(slot0, slot1, slot2)
	if slot1.star ~= slot2.star then
		if slot0.curOrder_ == "desc" then
			return true, slot2.star < slot1.star
		else
			return true, slot1.star < slot2.star
		end
	end

	return false, false
end

function slot0.RareSorter(slot0, slot1, slot2)
	if HeroCfg[slot1.id].rare ~= HeroCfg[slot2.id].rare then
		if slot0.curOrder_ == "desc" then
			return true, slot4.rare < slot3.rare
		else
			return true, slot3.rare < slot4.rare
		end
	end

	return false, false
end

function slot0.LevelSorter(slot0, slot1, slot2)
	if slot1.exp ~= slot2.exp then
		if slot0.curOrder_ == "desc" then
			return true, slot2.exp < slot1.exp
		else
			return true, slot1.exp < slot2.exp
		end
	end

	return false, false
end

function slot0.Reset(slot0)
	slot0:RemoveAllListeners()

	slot0.campDropdown_.value = 0
	slot0.sortTypeDropdown_.value = 0

	slot0.orderController_:SetSelectedState("desc")

	slot0.curOrder_ = "desc"
	slot0.curSortType_ = 0
	slot0.curRaceIndex_ = 0

	slot0:AddUIListener()
end

function slot0.Dispose(slot0)
	if slot0.heroSorter_ then
		slot0.heroSorter_:Reset()

		slot0.heroSorter_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
