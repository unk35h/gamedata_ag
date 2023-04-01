slot0 = class("ChooseCharacterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/canteen/EmptyDreamHreoTaskPop"
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

	slot0.characterScroll_ = LuaList.New(handler(slot0, slot0.indexCharacter), slot0.characteruilistUilist_, CharacterItem)
	slot0.recomendScroll_ = LuaList.New(handler(slot0, slot0.indexRecommendClass), slot0.recuilistUilist_, DormRecommendBigItem)
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DORM_REFRESH_DISPATCH_LIST, function ()
		uv0.characterScroll_:Refresh()
		uv0.recomendScroll_:Refresh()
		uv0:UpdateSuccess()
		uv0:UpdataDispatchNum()
		uv0:UpdataNeedFatigue()
	end)
	slot0:RegistEventListener(CANTEEN_HERO_FATIGUR_REFRESH, function ()
		uv0.characterScroll_:Refresh()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvent()
	slot0:UpdateItemData()
	slot0:UpdataRecItem()
	slot0:UpdataDispatchNum()
	slot0:UpdataNeedFatigue()
	slot0.characterScroll_:StartScroll(#slot0.itemList_)
	slot0.recomendScroll_:StartScroll(#slot0.reList_)

	slot0.successnumText_.text = 0
	slot0.tasknmaeText_.text = BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].name
end

function slot0.indexCharacter(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0, slot1)
		slot2 = DormData:GetHeroTemplateInfo(slot0)

		if CanteenData:CheckHasChooseEntrustCharacter(slot0) == true or slot2.jobType then
			ShowTips("CANTEEN_TASK_CANT_CHOOSE")

			return
		end

		if CanteenData:CheckDispatchCharacterArchiveList(slot0) and not CanteenData:CheckDispatchCharacterList(slot0) then
			ShowTips(GetTips("DORM_SAME_HERO_CHOOSE"))

			return
		end

		if DormData:GetHeroFatigue(slot0) < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
			ShowTips("CANTEEN_HERO_FATIGUE_NULL")

			return
		end

		if #CanteenData:GetDispatchCharacterList() < DormConst.CANTEEN_TRUST_CHARACTER_NUM and CanteenData:CheckDispatchCharacterList(slot0) == false then
			CanteenData:SetDispatchCharacterList(slot0)
			slot1:SetSelectedState("select")
		elseif CanteenData:CheckDispatchCharacterList(slot0) == true then
			CanteenData:RemoveDispatchCharacterList(slot0)
			slot1:SetSelectedState("normal")
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
	slot2:RegistFullListCallBack(function (slot0, slot1)
		if #CanteenData:GetDispatchCharacterList() == BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].need[2] then
			if not CanteenData:CheckDispatchCharacterList(slot0) then
				slot1:SetSelectedState("full")
			else
				slot1:SetSelectedState("select")
			end
		elseif not CanteenData:CheckDispatchCharacterList(slot0) then
			slot1:SetSelectedState("normal")
		else
			slot1:SetSelectedState("select")
		end
	end)
	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.indexRecommendClass(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.reList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.battlebtnBtn_, nil, function ()
		if #CanteenData:GetDispatchCharacterList() < BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].need[1] then
			ShowTips(string.format(GetTips("CANTEEN_TASK_NOT_CHOOSE"), BackHomeCanteenTaskCfg[slot0.id].need[1]))

			return false
		end

		slot2 = 0

		for slot6, slot7 in ipairs(slot1) do
			slot2 = slot2 + DormData:GetHeroFatigue(slot7)
		end

		if slot2 < uv0.fatigue then
			ShowTips("CANTEEN_TASK_FATIGUE_NOT_ENOUGH")

			return false
		end

		CanteenData:ConfirmEntrustList()
		JumpTools.OpenPageByJump("/dormTaskDispatchView")
		ShowTips("CANTEEN_TASK_DISPATCH")
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.quickBtn_, nil, function ()
		slot0 = CanteenData:GetCurDispatchTask()

		CanteenData:ClearDispatchCharacterList()

		uv0.autoHeroList = {}

		for slot4 = DormConst.DORM_HERO_TAG_MAX, 0, -1 do
			uv0.autoHeroList[slot4] = {}
		end

		slot1 = CanteenData:GetEntrustByPos(slot0.pos).tags

		for slot5, slot6 in ipairs(uv0.itemList_) do
			while true do
				if DormData:GetHeroFatigue(slot6) < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
					break
				end

				slot9 = DormData:GetHeroTemplateInfo(slot6)

				if CanteenData:CheckHasChooseEntrustCharacter(slot6) == true or slot9.jobType then
					break
				end

				if DormConst.DORM_HERO_TAG_MAX < CanteenData:CalHeroMatchNum(slot6, slot1) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, slot6) / BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].tag_success then
					slot10 = DormConst.DORM_HERO_TAG_MAX
				end

				if not uv0.autoHeroList[slot10] then
					uv0.autoHeroList[slot10] = {}
				end

				table.insert(uv0.autoHeroList[slot10], slot6)

				break
			end
		end

		for slot5, slot6 in pairs(uv0.autoHeroList) do
			if #slot6 > 0 then
				CommonTools.UniversalSortEx(slot6, {
					map = function (slot0)
						return DormData:GetHeroFatigue(slot0)
					end
				})
			end
		end

		slot3 = {}
		slot4 = BackHomeCanteenTaskCfg[slot0.id].cost
		uv0.trackFlag = false
		uv0.fatigueNum = slot4
		uv0.fatigueNum = 0

		uv0:BackTrack(slot3, BackHomeCanteenTaskCfg[slot0.id].need[2], DormConst.DORM_HERO_TAG_MAX, 1, slot4)

		if #slot3 == 0 then
			ShowTips(GetTips("DORM_CANTEEN_TASK_CANT_FIT"))

			return
		end

		for slot8, slot9 in ipairs(slot3) do
			CanteenData:SetDispatchCharacterList(slot9)
		end

		manager.notify:Invoke(DORM_REFRESH_DISPATCH_LIST)
	end)
end

function slot0.BackTrack(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot2 == 0 then
		if slot5 <= 0 then
			slot0.trackFlag = true
		end

		return
	end

	for slot9 = slot3, 0, -1 do
		while true do
			if #slot0.autoHeroList[slot9] == 0 or #slot0.autoHeroList[slot9] > 0 and slot4 > #slot0.autoHeroList[slot9] then
				if slot9 == 0 and slot5 <= 0 then
					slot0.trackFlag = true

					return
				end

				slot4 = 1

				break
			end

			for slot13 = slot4, #slot0.autoHeroList[slot9] do
				if slot0.autoHeroList[slot9][slot13] then
					while true do
						slot15 = HeroRecordCfg.get_id_list_by_hero_id[slot14][1]
						slot16 = false

						for slot20, slot21 in ipairs(slot1) do
							if slot15 == HeroRecordCfg.get_id_list_by_hero_id[slot21][1] then
								slot16 = true

								break
							end
						end

						if slot16 then
							break
						end

						table.insert(slot1, slot14)
						slot0:BackTrack(slot1, slot2 - 1, slot9, slot13 + 1, slot5 - DormData:GetHeroFatigue(slot14) - (slot0.fatigueNum - math.ceil(slot0.fatigueNum * (100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, slot14)) / 100)))

						if slot0.trackFlag then
							return

							break
						end

						table.remove(slot1, #slot1)

						break
					end
				end
			end

			break
		end
	end
end

function slot0.UpdateItemData(slot0)
	slot1 = DormData
	slot0.itemList_ = slot1:GetAllCanUseHeroInDorm()

	CommonTools.UniversalSortEx(slot0.itemList_, {
		ascend = true,
		map = function (slot0)
			if (CanteenData:CheckHasChooseEntrustCharacter(slot0) or DormData:GetHeroTemplateInfo(slot0).jobType ~= nil) == false then
				return 1
			else
				return 2
			end
		end
	}, {
		map = function (slot0)
			return DormData:GetHeroFatigue(slot0)
		end
	}, {
		map = function (slot0)
			return slot0
		end
	})
end

function slot0.UpdataRecItem(slot0)
	slot0.reList_ = {}

	for slot6 = 1, #CanteenData:GetEntrustList()[CanteenData:GetCurDispatchTask().pos].tags do
		table.insert(slot0.reList_, {
			type = slot2.tags[slot6].type,
			tag = slot2.tags[slot6].tag
		})
	end

	slot0.recomendScroll_:StartScroll(#slot0.reList_)

	slot0.recuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function slot0.UpdateSuccess(slot0)
	slot0.successnumText_.text = CanteenData:CalculateEntrustSuccess() .. "%"
end

function slot0.UpdataDispatchNum(slot0)
	slot0.numText_.text = string.format("%d<size=28><color=#767878>/%d</color></size>", #CanteenData:GetDispatchCharacterList(), BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].need[2])
end

function slot0.UpdataNeedFatigue(slot0)
	slot2 = 0

	if CanteenData:GetDispatchCharacterList() then
		for slot6, slot7 in ipairs(slot1) do
			slot2 = slot2 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustTotalFatigueReduce, slot7)
		end

		if slot2 > 100 then
			slot2 = 100
		end
	end

	slot0.fatigue = math.ceil(BackHomeCanteenTaskCfg[CanteenData:GetCurDispatchTask().id].cost * (100 - slot2) / 100)
	slot0.resourcetextText_.text = slot0.fatigue
end

function slot0.OnExit(slot0)
	CanteenData:RemoveCurEntrustCharacterList()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.characterScroll_ then
		slot0.characterScroll_:Dispose()
	end

	if slot0.recomendScroll_ then
		slot0.recomendScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
