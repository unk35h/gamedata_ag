slot0 = class("HeroListFilterWithTrialView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.isSelfHero_ = true
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.curOrder_ = "desc"
	slot0.isAll_ = true
	slot0.curSortType_ = 0
	slot0.curSortRace_ = {}
	slot0.curAttackType_ = {}
	slot0.curEnergyType_ = {}

	slot0:InitUI()
	slot0:InitDropDown()
	slot0:AddUIListener()
end

function slot0.InitDropDown(slot0)
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
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		JumpTools.OpenPageByJump("sortHeroType", {
			isAll = uv0.isAll_,
			sortType = uv0.curSortType_,
			sortRace = uv0.curSortRace_,
			attackType = uv0.curAttackType_,
			energyType = uv0.curEnergyType_
		})
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

	HeroData:SaveSortType(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.SetHeroDataList(slot0, slot1)
	slot0.heroList_ = slot1

	slot0:RefreshSort(slot0.isAll_, slot0.curSortType_, slot0.curSortRace_, slot0.curAttackType_, slot0.curEnergyType_)
end

function slot0.RefreshSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.isAll_ = slot1
	slot0.curSortType_ = slot2
	slot0.curSortRace_ = slot3
	slot0.curAttackType_ = slot4
	slot0.curEnergyType_ = slot5
	slot0.displayHeroList_ = {}

	if slot0.isAll_ then
		for slot9, slot10 in ipairs(slot0.heroList_) do
			table.insert(slot0.displayHeroList_, slot10)
		end
	else
		for slot9, slot10 in ipairs(slot0.heroList_) do
			slot12 = HeroCfg[slot10.id]
			slot13 = false

			if #slot0.curSortRace_ <= 0 or table.indexof(slot0.curSortRace_, slot12.race) then
				slot13 = true
			end

			slot14 = false

			if #slot0.curEnergyType_ <= 0 or table.indexof(slot0.curEnergyType_, slot12.mechanism_type[1]) then
				slot14 = true
			end

			slot15 = false
			slot16 = slot12.ATK_attribute

			if #slot0.curAttackType_ <= 0 or #slot16 > 1 and table.indexof(slot0.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				slot15 = true
			else
				for slot20, slot21 in ipairs(slot16) do
					if table.indexof(slot0.curAttackType_, slot21) then
						slot15 = true

						break
					end
				end
			end

			if slot13 and slot14 and slot15 then
				table.insert(slot0.displayHeroList_, slot10)
			end
		end
	end

	slot0:RefreshType()
	slot0:UpdateList()
end

function slot0.RefreshType(slot0)
	slot0.typeTxt_.text = slot0.isAll_ and GetTips("ALL") or GetTips("ROLE_FILTERING")
end

function slot0.UpdateList(slot0)
	slot1 = GameSetting.unlock_hero_need.value
	slot2 = slot0.heroSorter_

	slot2:Reset()
	table.sort(slot0.displayHeroList_, function (slot0, slot1)
		slot2 = false
		slot3 = false

		if uv0.extraSorter_ ~= nil then
			slot4, slot3 = uv0.extraSorter_(slot0, slot1, uv0.curSortType_, uv0.curOrder_)

			if slot4 then
				return slot3
			end
		end

		if HeroData:GetHeroData(slot0.id).unlock ~= HeroData:GetHeroData(slot1.id).unlock then
			return slot7.unlock < slot6.unlock
		end

		if slot6.unlock == 0 and slot7.unlock == 0 and (uv1[HeroCfg[slot4].rare] <= slot6.piece and 1 or 0) ~= (uv1[HeroCfg[slot5].rare] <= slot7.piece and 1 or 0) then
			return slot11 < slot10
		end

		if not uv0.extra_ and HeroData:IsFavorite(slot4) ~= HeroData:IsFavorite(slot5) and (not slot8 or not slot9) then
			return slot8 ~= false
		end

		if uv0.curSortType_ == 0 then
			slot8, slot3 = uv0:FightPowerSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:StarSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:RareSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:LevelSorter(slot6, slot7)

			if slot8 then
				return slot3
			end
		else
			slot8, slot3 = uv0:StarSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:RareSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:FightPowerSorter(slot6, slot7)

			if slot8 then
				return slot3
			end

			slot8, slot3 = uv0:LevelSorter(slot6, slot7)

			if slot8 then
				return slot3
			end
		end

		return slot5 < slot4
	end)

	if slot0.callback_ ~= nil then
		slot0.callback_(slot0.displayHeroList_)
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
	if slot0.heroSorter_:GetHeroPower(slot1) ~= slot0.heroSorter_:GetHeroPower(slot2) then
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

function slot0.Reset(slot0, slot1)
	slot0:RemoveAllListeners()
	slot0.orderController_:SetSelectedState("desc")

	slot0.curOrder_ = "desc"

	if slot1 then
		slot0.isAll_, slot0.curSortType_, slot0.curSortRace_, slot0.curAttackType_, slot0.curEnergyType_ = HeroData:GetSortValue()
	else
		slot0.isAll_ = true
		slot0.curSortType_ = 0
		slot0.curSortRace_ = {}
		slot0.curAttackType_ = {}
		slot0.curEnergyType_ = {}
	end

	slot0.sortTypeDropdown_.value = slot0.curSortType_

	slot0:AddUIListener()
	slot0:RefreshType()
end

function slot0.ShowDropDown(slot0, slot1)
	SetActive(slot0.panel_, slot1)
end

function slot0.Dispose(slot0)
	if slot0.heroSorter_ then
		slot0.heroSorter_:Reset()

		slot0.heroSorter_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
