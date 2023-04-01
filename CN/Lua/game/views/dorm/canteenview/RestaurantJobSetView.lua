slot0 = class("RestaurantJobSetView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dining/RoleConfigurationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.heroScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.heroUiList_, CanteenHeroItem)
	slot0.heroSkillScroll = LuaList.New(handler(slot0, slot0.heroSkillItem), slot0.uiSkillListGo_, CanteenSkillItem)
	slot0.switchBtnController = ControllerUtil.GetController(slot0.transform_, "btnState")
	slot0.fatigueBtnController = ControllerUtil.GetController(slot0.transform_, "fatigue")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.jobType = slot0.params_.jobType
	slot0.heroList = nil

	slot0:RefreshView()
	slot0:RegisterEvent()
end

function slot0.OnExit(slot0)
	slot0.selHero = nil

	slot0:RemoveAllEventListener()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function ()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		uv0:RefreshView()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.confirmBtn_, nil, function ()
		CanteenAction:SetCharacterJob(uv0.jobType, {
			uv0.selHero
		})
	end)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.removeBtn_, nil, function ()
		CanteenAction:SetCharacterJob(DormData:GetHeroTemplateInfo(uv0.selHero).jobType, {
			0
		})
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.heroList[slot1], slot0.selHero, slot0.jobType)
	slot2:ResetCharacterCallBack(function (slot0)
		slot1 = DormData:GetHeroTemplateInfo(slot0)

		if CanteenData:CheckHasChooseEntrustCharacter(slot0) == true then
			ShowTips("CANTEEN_TASK_CANT_CHOOSE")

			return
		end

		uv0.selHero = slot0

		uv0:RefreshHeroInfo()
		uv0.heroScroll:Refresh()
	end)
end

function slot0.heroSkillItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillItemList[slot1], slot0.heroLevel, slot1)
end

function slot0.RefreshView(slot0)
	slot0.jobText_.text = string.format(GetTips("CANTEEN_JOB_SET"), CanteenTools:GetJobName(slot0.jobType))

	slot0:RefreshCanUseHeroList()
	slot0:RefreshHeroInfo()
end

function slot0.RefreshCanUseHeroList(slot0)
	slot1 = DormData
	slot0.heroList = slot1:GetAllCanUseHeroInDorm()

	CommonTools.UniversalSortEx(slot0.heroList, {
		ascend = true,
		map = function (slot0)
			slot3 = CanteenData:CheckHasChooseEntrustCharacter(slot0)

			if not DormData:GetHeroTemplateInfo(slot0).jobType and not slot3 then
				return 1
			elseif slot2 then
				return 2
			else
				return 3
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

	if not slot0.selHero then
		slot0.selHero = slot0.heroList[1]
	end

	slot0.heroScroll:StartScroll(#slot0.heroList)
end

function slot0.RefreshHeroInfo(slot0)
	if not slot0.selHero then
		slot0.selHero = slot0.heroList[1]
	end

	slot1 = DormData:GetHeroTemplateInfo(slot0.selHero)
	slot2 = HeroData:GetHeroData(slot0.selHero)
	slot0.heroLevel = slot2.level
	slot0.nameText_.text = HeroCfg[slot0.selHero].suffix
	slot0.selHeroLevel = string.format(GetTips("DORM_LEVEL_TIPS"), slot0.heroLevel)
	slot3 = DormData:GetHeroFatigue(slot0.selHero)

	if slot2 then
		slot0.lvText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot2.level)
		slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		slot0.curText_.text = slot3
		slot0.progressImg_.fillAmount = slot3 / GameSetting.canteen_hero_fatigue_max.value[1]
	end

	slot0.fatigueRe_.text = string.format(GetTips("DORM_CANTEEN_FATIGUE_COST"), slot0:CalFatigurReduce())

	if slot3 < GameDisplayCfg.canteen_fatigue_red_warning.value[1] then
		slot0.fatigueBtnController:SetSelectedState("false")
		slot0.switchBtnController:SetSelectedState("false")
	else
		slot0.fatigueBtnController:SetSelectedState("true")
		slot0.switchBtnController:SetSelectedState("true")
	end

	if slot0.jobType == 1 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif slot0.jobType == 2 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif slot0.jobType == 3 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	if slot1.jobType then
		slot0.switchBtnController:SetSelectedState("remove")
	end

	slot0:RefreshHeroSkillInfo(slot0.selHero)
end

function slot0.CalFatigurReduce(slot0)
	slot1 = CanteenData:GetPopularityNum()
	slot2 = GameSetting.canteen_popular_cost_time.value
	slot3 = slot2[#slot2][2]

	for slot7, slot8 in ipairs(slot2) do
		if slot1 < slot8[1] then
			slot3 = slot8[2]
		end
	end

	slot4 = math.ceil(3600 / slot3)
	slot5 = GameSetting.dorm_canteen_fatigue_cost.value[1] / 100
	slot7 = 0

	for slot11, slot12 in ipairs(slot0:CheckSkillCanOpen(slot0.jobType)) do
		if BackHomeHeroSkillCfg[slot12].type == CanteenConst.HeroSkillType.FatigueRecuse then
			slot7 = slot7 + BackHomeHeroSkillCfg[slot12].param[1]
		end
	end

	return slot4 * slot5 * (100 - slot7) / 100
end

function slot0.CheckSkillCanOpen(slot0, slot1)
	slot3 = GameSetting.dorm_hero_skill_unlock.value
	slot4 = {}
	slot5 = HeroData:GetHeroData(slot0.selHero).level

	for slot9 = 1, #BackHomeHeroCfg[slot0.selHero].skill_list do
		if slot3[slot9] <= slot5 then
			table.insert(slot4, slot2[slot9])
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot4) do
		if BackHomeHeroSkillCfg[slot11].condition and #slot13 > 0 then
			if slot13[1] == 1 and slot1 == slot13[2] then
				table.insert(slot6, slot11)
			end
		else
			table.insert(slot6, slot11)
		end
	end

	return slot6
end

function slot0.RefreshHeroSkillInfo(slot0, slot1)
	slot0.skillItemList = BackHomeHeroCfg[slot1].skill_list

	slot0.heroSkillScroll:StartScroll(#slot0.skillItemList)
end

function slot0.Dispose(slot0)
	if slot0.heroScroll then
		slot0.heroScroll:Dispose()

		slot0.heroScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
