slot0 = class("HeroPreviewListFilterView", ReduxView)

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
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

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
	slot0.isPreview_ = slot2 and slot2.isPreview

	for slot6, slot7 in ipairs(slot1) do
		if not HeroTools.GetIsHide(slot7) then
			table.insert(slot0.displayIdList_, slot7)
		end
	end

	slot0:UpdateList()
end

function slot0.RefreshSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.isAll_ = slot1
	slot0.curSortType_ = slot2
	slot0.curSortRace_ = slot3
	slot0.curAttackType_ = slot4
	slot0.curEnergyType_ = slot5
	slot0.displayIdList_ = {}

	if slot0.isAll_ then
		for slot9, slot10 in ipairs(slot0.idList_) do
			if not HeroTools.GetIsHide(slot10) then
				table.insert(slot0.displayIdList_, slot10)
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.idList_) do
			slot11 = HeroCfg[slot10]
			slot12 = false

			if #slot0.curSortRace_ <= 0 or table.indexof(slot0.curSortRace_, slot11.race) then
				slot12 = true
			end

			slot13 = false

			if #slot0.curEnergyType_ <= 0 or table.indexof(slot0.curEnergyType_, slot11.mechanism_type[1]) then
				slot13 = true
			end

			slot14 = false
			slot15 = slot11.ATK_attribute

			if #slot0.curAttackType_ <= 0 or #slot15 > 1 and table.indexof(slot0.curAttackType_, HeroConst.HERO_ATTACK_TYPE.MIX) then
				slot14 = true
			else
				for slot19, slot20 in ipairs(slot15) do
					if table.indexof(slot0.curAttackType_, slot20) then
						slot14 = true

						break
					end
				end
			end

			if slot12 and slot13 and slot14 and not HeroTools.GetIsHide(slot10) then
				table.insert(slot0.displayIdList_, slot10)
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

		if uv0.curSortType_ == 0 then
			if slot4.unlock ~= slot5.unlock then
				if uv0.curOrder_ == "desc" then
					return slot5.unlock < slot4.unlock
				else
					return slot4.unlock < slot5.unlock
				end
			end

			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:IDSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		else
			slot6, slot3 = uv0:RareSorter(slot4, slot5)

			if slot6 then
				return slot3
			end

			slot6, slot3 = uv0:IDSorter(slot4, slot5)

			if slot6 then
				return slot3
			end
		end
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

function slot0.IDSorter(slot0, slot1, slot2)
	if slot0.curOrder_ == "desc" then
		return true, slot2.id < slot1.id
	else
		return true, slot1.id < slot1.id
	end

	return false, false
end

function slot0.Reset(slot0)
	slot0:RemoveAllListeners()

	slot0.curOrder_ = "desc"
	slot0.isAll_ = true
	slot0.curSortType_ = 0
	slot0.curSortRace_ = {}
	slot0.curAttackType_ = {}
	slot0.curEnergyType_ = {}
	slot0.sortTypeDropdown_.value = slot0.curSortType_

	slot0:AddUIListener()
	slot0:RefreshType()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
