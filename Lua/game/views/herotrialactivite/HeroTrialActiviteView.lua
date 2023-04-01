slot0 = class("HeroTrialActiviteView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUIontrial"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroItemList_ = {}
	slot0.rewardItemList_ = {}
	slot0.onClickTrialHandler_ = handler(slot0, slot0.OnClickTrial)
	slot0.controller_ = ControllerUtil.GetController(slot0.transformBtn_, "name")
	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.imageIcon_.transform)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HERO_TRIAL_DESCRIPE")
	manager.notify:RegistListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)

	slot0.activiteID_ = slot0.params_.activiteID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activiteID_).stopTime

	slot0:AddTimer()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.onClickTrialHandler_ = nil

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	for slot4, slot5 in pairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil
end

function slot0.OnTop(slot0)
	if slot0.selectActiviteHeroID_ == nil then
		ShowTips("TIME_OVER")
		slot0:Back()

		return
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnReceive_, nil, function ()
		HeroTrialAction.GetTrialReward(uv0.selectActiviteHeroID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivityHeroTrialCfg[uv0.selectActiviteHeroID_].reward_list)
				uv0.controller_:SetSelectedState("complete")
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.btnTrial_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.activiteHeroIDList_) do
			table.insert(slot0, ActivityHeroTrialCfg[slot5].trial_id)
		end

		uv0:Go("/newHero", {
			isEnter = true,
			isTemp = true,
			hid = ActivityHeroTrialCfg[uv0.selectActiviteHeroID_].trial_id,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		HeroTrialData:SaveStageID(uv0.selectActiviteHeroID_)
		uv0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[uv0.selectActiviteHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = uv0.activiteID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.activiteHeroIDList_ = slot0:GetActiviteHeroIDList()
	slot2 = HeroTrialData:GetSelectActiviteHeroID(slot0.activiteID_) or slot1[1]
	slot0.selectActiviteHeroID_ = slot2

	if slot2 == nil then
		return
	end

	HeroTrialData:SetSelectActiviteHeroID(slot0.activiteID_, slot2)
	slot0:RefreshHeroItem()

	slot3 = ActivityHeroTrialCfg[slot2]
	slot4 = slot3.trial_id
	slot0.heroID_ = HeroStandardSystemCfg[slot4].hero_id
	slot0.heroCfg_ = HeroCfg[slot0.heroID_]
	slot0.imageIcon_.sprite = getSpriteWithoutAtlas("Textures/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[slot4].skin_id].picture_id)

	slot0.imageIcon_:SetNativeSize()
	slot0.adaptImg_:AdaptImg()
	slot0:RefreshTextName(slot3.name)

	slot0.textTips_.text = string.format(GetTips("COMPLETE_TRAIL_STAGE"), slot3.name)
	slot0.imageRace_.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot0.heroCfg_.race].icon)

	slot0:RefreshReward(slot2)

	slot0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. slot0.heroCfg_.rare)
end

function slot0.RefreshTextName(slot0, slot1)
	slot0.textName_.text = slot1
end

function slot0.RefreshHeroItem(slot0)
	slot1 = slot0.selectActiviteHeroID_

	for slot6, slot7 in ipairs(slot0.activiteHeroIDList_) do
		if slot0.heroItemList_[slot6] then
			slot0.heroItemList_[slot6]:SetActiviteHeroID(slot0.activiteID_, slot7)
		else
			slot0.heroItemList_[slot6] = HeroTrialActiviteItem.New(slot0.goItem_, slot0.goItemParent_, slot7, slot0.activiteID_)
		end
	end

	for slot6 = #slot0.heroItemList_, #slot2 + 1, -1 do
		slot0.heroItemList_[slot6]:Dispose()

		slot0.heroItemList_[slot6] = nil
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7 == slot1 then
			slot0:RefreshSelectActiviteHero(slot1)

			return
		end
	end

	slot0:RefreshSelectActiviteHero(slot2[1])
end

function slot0.RefreshReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityHeroTrialCfg[slot1].reward_list) do
		if slot0.rewardItemList_[slot6] then
			slot0.rewardItemList_[slot6]:SetData(slot7, false)
		else
			slot0.rewardItemList_[slot6] = slot0:GetRewardItem(slot7)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot6]:Show(false)
	end

	if HeroTrialData:GetHeroTrialStateList()[slot1] then
		if slot3 == 1 then
			slot0.controller_:SetSelectedState("receive")
		elseif slot3 == 2 then
			slot0.controller_:SetSelectedState("complete")
		else
			slot0.controller_:SetSelectedState("not")
		end
	else
		slot0.controller_:SetSelectedState("not")
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goRewardPanel_, slot1, false)
end

function slot0.OnClickTrial(slot0)
	slot0:RefreshUI()
end

function slot0.GetActiviteHeroIDList(slot0)
	slot1 = {}
	slot5 = slot0.activiteID_

	for slot5, slot6 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[slot5]) do
		if true then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.RefreshSelectActiviteHero(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroItemList_) do
		slot6:OnSelect(slot1)
	end
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		slot0:Back()

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
