slot0 = class("RaceTrailReadyView", ReduxView)

function slot0.UIName(slot0)
	if ActivityTools.GetActivityTheme(slot0.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIDownRaceTrialSelectAffixUI"
	else
		return "UI/VersionUI/OsirisUI/OsirisSelectAffixUI"
	end
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.customScrollHelper_ = LuaList.New(handler(slot0, slot0.CustomIndexItem), slot0.customListGo_, CustomBox)
	slot0.customDesScrollHelper_ = LuaList.New(handler(slot0, slot0.CustomDesIndexItem), slot0.customDesListGo_, CustomDesItem)
end

function slot0.CustomIndexItem(slot0, slot1, slot2)
	slot3 = slot0.customTable_.all[slot1]

	slot2:RefreshUI(slot3, slot0.customTable_[slot3], slot0:GetSelectCustom(slot3))
	slot2:RegisterClickListener(function (slot0)
		if uv0:GetSelectCustom(ActivityAffixPoolCfg[slot0].affix[1]) ~= slot0 then
			uv0:SetSelectCustom(slot1, slot0)
		else
			uv0:SetSelectCustom(slot1)
		end

		uv1:RefreshUI(slot1, uv0.customTable_[slot1], uv0:GetSelectCustom(slot1))
		uv0:CalculatePoint()
		uv0:RefreshDesList(false, slot0)
	end)
end

function slot0.CustomDesIndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.customSelectList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrailAction:SaveCustomList(uv0.activityID_, uv0.customSelectList_)
		uv0:Go("/sectionSelectHero", {
			section = uv0.activityID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.RACE_TRAIL,
			forceRace = ActivityRaceTrialCfg[uv0.activityID_].race,
			activityID = uv0.params_.activityID
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.customSelectList_ = RaceTrailData:GetCustomList(slot0.activityID_)

	slot0:CreatCustomTable()
	slot0:CreatCustomSelectTable()
	slot0:RefreshUI()
end

function slot0.CreatCustomTable(slot0)
	slot0.customTable_ = {
		all = {}
	}
	slot2 = nil

	for slot6, slot7 in ipairs(ActivityRaceTrialCfg[slot0.activityID_].pool) do
		if not slot0.customTable_[ActivityAffixPoolCfg[slot7].affix[1]] then
			slot0.customTable_[slot2.affix[1]] = {}

			table.insert(slot0.customTable_.all, slot2.affix[1])
		end

		table.insert(slot0.customTable_[slot2.affix[1]], slot7)
	end
end

function slot0.CreatCustomSelectTable(slot0)
	slot1 = nil
	slot0.customSelectTable_ = {}

	for slot5, slot6 in ipairs(slot0.customSelectList_) do
		slot0.customSelectTable_[ActivityAffixPoolCfg[slot6].affix[1]] = slot6
	end
end

function slot0.GetSelectCustom(slot0, slot1)
	if slot0.customSelectTable_[slot1] then
		return slot0.customSelectTable_[slot1]
	end

	return nil
end

function slot0.SetSelectCustom(slot0, slot1, slot2)
	if slot0.customSelectTable_[slot1] then
		table.remove(slot0.customSelectList_, table.indexof(slot0.customSelectList_, slot3))
	end

	if slot2 then
		slot0.customSelectTable_[slot1] = slot2

		table.insert(slot0.customSelectList_, slot2)
	else
		slot0.customSelectTable_[slot1] = nil
	end
end

function slot0.RefreshUI(slot0)
	slot0:CalculatePoint()
	slot0:RefreshDesList(true)
	slot0.customScrollHelper_:StartScroll(#slot0.customTable_.all)
end

function slot0.CalculatePoint(slot0)
	slot1 = nil
	slot2 = ActivityRaceTrialCfg[slot0.activityID_].base_point

	for slot6, slot7 in ipairs(slot0.customSelectList_) do
		slot2 = slot2 + ActivityAffixPoolCfg[slot7].point
	end

	slot0.pointText_.text = string.format("<color=#FE972E>%d</color>", slot2)
end

function slot0.RefreshDesList(slot0, slot1, slot2)
	if slot1 then
		slot0.customDesScrollHelper_:StartScroll(#slot0.customSelectList_)
	elseif table.indexof(slot0.customSelectList_, slot2) then
		slot0.customDesScrollHelper_:StartScroll(#slot0.customSelectList_, slot3)
	else
		slot0.customDesScrollHelper_:StartScrollByPosition(#slot0.customSelectList_, slot0.customDesScrollHelper_:GetScrolledPosition())
	end
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistHomeCallBack(function ()
		RaceTrailAction:SaveCustomList(uv0.activityID_, uv0.customSelectList_)
		uv0:Go("/home", nil, , true)
	end)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		RaceTrailAction:SaveCustomList(uv0.activityID_, uv0.customSelectList_)
		uv0:Back()
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.customScrollHelper_:Dispose()
	slot0.customDesScrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
