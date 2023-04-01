slot0 = class("GuildActivityFightHeroSettingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityFightHeroPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.headList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, GuildActivityFightHeadItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetEditing(slot0.editing_)
	slot2:SetData(slot1, slot0.heroDataList_, slot0.putOffHeroList_, slot0.params_.activityID)
	slot2:SetHeroChangeHandler(handler(slot0, slot0.OnHeroChange))
end

function slot0.OnHeroChange(slot0, slot1, slot2, slot3)
	if slot1 > #slot0.heroDataList_ + 1 then
		slot1 = #slot0.heroDataList_ + 1
	end

	if slot2 ~= 0 then
		for slot7, slot8 in ipairs(slot0.heroDataList_) do
			if slot8.id == slot2 then
				slot0.heroDataList_[slot7].fatigue = 0

				break
			end
		end

		if not table.indexof(slot0.putOffHeroList_, slot2) then
			table.insert(slot0.putOffHeroList_, slot2)
		end
	end

	if slot3 == 0 then
		for slot7 = slot1, #slot0.heroDataList_ - 1 do
			slot0.heroDataList_[slot7] = slot0.heroDataList_[slot7 + 1]
		end

		table.remove(slot0.heroDataList_, #slot0.heroDataList_)
	else
		slot0.heroDataList_[slot1] = {
			fatigue = 0,
			id = slot3
		}
	end

	slot0.headList_:Refresh()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.statusController_:GetSelectedState() ~= "edit" then
			uv0:Back()
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:SwitchToList()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if GuildActivityData:IsFirstConfigFightRole() and #uv0.heroDataList_ < GuildActivityData:GetMaxFightHeroCount() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_FIGHT_HERO_NOT_FULL_TIP"),
				OkCallback = function ()
					uv0:SaveHeroes()
				end,
				CancelCallback = function ()
				end
			})

			return
		end

		uv0:SaveHeroes()
	end)
	slot0:AddBtnListener(slot0.editBtn_, nil, function ()
		uv0:StartEdit()
	end)
end

function slot0.StartEdit(slot0)
	slot0.statusController_:SetSelectedState("edit")

	slot0.editing_ = true

	slot0.headList_:StartScroll(ActivityClubLevelSettingCfg[ActivityClubLevelSettingCfg.all[#ActivityClubLevelSettingCfg.all]].max_hero)
end

function slot0.SwitchToList(slot0)
	slot0.putOffHeroList_ = {}
	slot0.heroDataList_ = GuildActivityData:GetFightHeroList()
	slot0.heroDataList_ = deepClone(slot0.heroDataList_)

	slot0.statusController_:SetSelectedState("list")

	slot0.editing_ = false

	slot0.headList_:StartScroll(#slot0.heroDataList_)
end

function slot0.SaveHeroes(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.heroDataList_) do
		table.insert(slot1, slot7.id)
	end

	for slot6, slot7 in ipairs(slot0.putOffHeroList_) do
		for slot11, slot12 in ipairs(slot0.heroDataList_) do
			if slot12.id == slot7 then
				table.insert(slot2, slot7)

				break
			end
		end
	end

	GuildActivityAction.SetFightMember(slot1, slot2)
	slot0:SwitchToList()
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ACTIVITY_HERO_LIST_UPDATE, function ()
		uv0:SwitchToList()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		if uv0.editing_ then
			uv0:SwitchToList()

			return
		end

		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	slot0:AddEventListeners()

	if slot0.params_.isEnter then
		slot0:SwitchToList()

		slot0.params_.isEnter = false
	end

	slot0.hoursLabel_.text = string.format(GetTips("ACTIVITY_CLUB_VITALITY_RECOVER"), tostring(60 / GameSetting.activity_club_hero_fatigue_recovery.value[1]))
end

function slot0.OnExit(slot0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.headList_ then
		slot0.headList_:Dispose()

		slot0.headList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
