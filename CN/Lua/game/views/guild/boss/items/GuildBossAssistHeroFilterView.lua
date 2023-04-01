slot0 = class("GuildBossAssistHeroFilterView", ReduxView)

function slot0.OnCtor(slot0, slot1)
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

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
end

function slot0.SetHeroList(slot0, slot1)
	slot0.heroList_ = slot1
	slot0.displayHeroList_ = {}

	slot0:RefreshSort(slot0.isAll_, slot0.curSortType_, slot0.curSortRace_, slot0.curAttackType_, slot0.curEnergyType_)
end

function slot0.SortListByType(slot0, slot1)
	slot0.curSortType_ = slot1

	HeroData:SaveSortType(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.RefreshSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.isAll_ = slot1
	slot0.curSortType_ = slot2
	slot0.curSortRace_ = slot3
	slot0.curAttackType_ = slot4
	slot0.curEnergyType_ = slot5
	slot0.displayHeroList_ = {}

	if slot0.isAll_ then
		slot6 = ipairs
		slot8 = slot0.heroList_ or {}

		for slot9, slot10 in slot6(slot8) do
			table.insert(slot0.displayHeroList_, slot10)
		end
	else
		slot6 = ipairs
		slot8 = slot0.heroList_ or {}

		for slot9, slot10 in slot6(slot8) do
			slot12 = HeroCfg[slot10.assist_hero_id]
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

function slot0.SortListByOrder(slot0, slot1)
	slot0.curOrder_ = slot1

	slot0.orderController_:SetSelectedState(slot1)

	if not slot0.gameObject_.activeInHierarchy then
		return
	end

	slot0:UpdateList()
end

function slot0.UpdateList(slot0)
	slot1 = GameSetting.unlock_hero_need.value

	table.sort(slot0.displayHeroList_, function (slot0, slot1)
		slot2 = false
		slot3 = false

		if uv0.extraSorter_ ~= nil then
			slot4, slot3 = uv0.extraSorter_(slot0, slot1)

			if slot4 then
				return slot3
			end
		end

		slot4 = slot0
		slot5 = slot1

		if uv0.curSortType_ == 0 then
			slot6, slot3 = uv0:FightPowerSorter(slot4, slot5)

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

		if slot0.assist_hero_id ~= slot1.assist_hero_id then
			return slot1.assist_hero_id < slot0.assist_hero_id
		end

		return tonumber(slot1.member_id) < tonumber(slot0.member_id)
	end)

	if slot0.callback_ ~= nil then
		slot0.callback_(slot0.displayHeroList_)
	end
end

function slot0.FightPowerSorter(slot0, slot1, slot2)
	if slot1.fight_capacity ~= slot2.fight_capacity then
		if slot0.curOrder_ == "desc" then
			return true, slot4 < slot3
		else
			return true, slot3 < slot4
		end
	end

	return false, false
end

function slot0.RareSorter(slot0, slot1, slot2)
	if slot1.hero_rare ~= slot2.hero_rare then
		if slot0.curOrder_ == "desc" then
			return true, slot4 < slot3
		else
			return true, slot3 < slot4
		end
	end

	return false, false
end

function slot0.LevelSorter(slot0, slot1, slot2)
	if slot1.hero_level ~= slot2.hero_level then
		if slot0.curOrder_ == "desc" then
			return true, slot2.hero_level < slot1.hero_level
		else
			return true, slot1.hero_level < slot2.hero_level
		end
	end

	return false, false
end

function slot0.SetListChangeHandler(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.SetExtraSorter(slot0, slot1)
	slot0.extraSorter_ = slot1
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
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

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
