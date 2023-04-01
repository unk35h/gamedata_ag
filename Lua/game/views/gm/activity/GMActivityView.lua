slot0 = class("GMActivityView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.activityItemList_ = {}
	slot0.optionDataList_ = OptionDataList.New()
	slot0.themeDataList_ = {}
	slot2 = {}

	for slot6, slot7 in pairs(ActivityCfg.get_id_list_by_activity_theme) do
		if slot6 ~= 0 then
			table.insert(slot2, slot6)
		end
	end

	function slot6(slot0, slot1)
		return slot1 < slot0
	end

	table.sort(slot2, slot6)

	for slot6, slot7 in ipairs(slot2) do
		slot0.optionDataList_.options:Add(OptionData.New(tostring(slot7)))
		table.insert(slot0.themeDataList_, slot7)
	end

	slot0.themeDropDown_.options = slot0.optionDataList_.options

	slot0:InitTimeInput()
end

function slot0.OnEnter(slot0)
	slot0:RefreshItem()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.optionDataList_.options:Clear()

	slot0.optionDataList_ = nil

	for slot4, slot5 in ipairs(slot0.activityItemList_) do
		slot5:Dispose()
	end

	slot0.activityItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.selectAllToggle_, function (slot0)
		uv0:SelectAllItem(slot0)
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if #GMData:GetActivityList() <= 0 then
			ShowTips("请先选中上方需要更改的活动")

			return
		end

		slot6 = manager.time:Table2ServerTime({
			year = tonumber(uv0.startYearInput_.text),
			month = tonumber(uv0.startMonthInput_.text),
			day = tonumber(uv0.startDayInput_.text),
			hour = tonumber(uv0.startHourInput_.text),
			min = tonumber(uv0.startMinuterInput_.text),
			sec = tonumber(uv0.startSecondInput_.text)
		})
		slot13 = manager.time:Table2ServerTime({
			year = tonumber(uv0.endYearInput_.text),
			month = tonumber(uv0.endMonthInput_.text),
			day = tonumber(uv0.endDayInput_.text),
			hour = tonumber(uv0.endHourInput_.text),
			min = tonumber(uv0.endMinuterInput_.text),
			sec = tonumber(uv0.endSecondInput_.text)
		})
		slot16 = GMData
		slot18 = slot16

		for slot17, slot18 in ipairs(slot16.GetActivityList(slot18)) do
			slot19 = string.format("$ wjhd set %s %s %s", slot18, slot6, slot13)

			manager.net:Push(27100, {
				content = slot19
			})
			print(slot19)
		end
	end)
	slot0:AddToggleListener(slot0.themeDropDown_, function (slot0)
		uv0:RefreshItem()
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		uv0:RefreshItem()
	end)
end

function slot0.RefreshItem(slot0)
	for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_theme[slot0.themeDataList_[slot0.themeDropDown_.value + 1]]) do
		slot0.activityItemList_[slot6] = slot0.activityItemList_[slot6] or GMActivityItem.New(slot0.itemGo_, slot0.itemParent_)

		slot0.activityItemList_[slot6]:SetData(slot7)
	end

	for slot6 = #slot0.activityItemList_, #slot2 + 1, -1 do
		slot0.activityItemList_[slot6]:Dispose()

		slot0.activityItemList_[slot6] = nil
	end
end

function slot0.SelectAllItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.activityItemList_) do
		slot6:SelectItem(slot1)
	end
end

function slot0.InitTimeInput(slot0)
	slot1 = manager.time:GetServerTime()
	slot2 = tonumber(os.date("%Y", slot1))
	slot3 = tonumber(os.date("%m", slot1))
	slot4 = tonumber(os.date("%d", slot1))
	slot5 = tonumber(os.date("%H", slot1))
	slot6 = tonumber(os.date("%M", slot1))
	slot7 = tonumber(os.date("%S", slot1))
	slot0.startYearInput_.text = slot2
	slot0.startMonthInput_.text = slot3
	slot0.startDayInput_.text = slot4
	slot0.startHourInput_.text = slot5
	slot0.startMinuterInput_.text = slot6
	slot0.startSecondInput_.text = slot7
	slot0.endYearInput_.text = slot2
	slot0.endMonthInput_.text = slot3
	slot0.endDayInput_.text = slot4 + 1
	slot0.endHourInput_.text = slot5
	slot0.endMinuterInput_.text = slot6
	slot0.endSecondInput_.text = slot7
end

return slot0
