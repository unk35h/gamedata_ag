slot0 = class("BirthdaySettingView", ReduxView)
slot1 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
slot2 = {
	31,
	29,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}

function slot0.UIName(slot0)
	return "UI/PopUp/ChooseBrithdayUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.monthScrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshMonthItem), slot0.monthList_, BirtndaySettingItem)
	slot0.dayScrollHelper_ = LuaList.New(handler(slot0, slot0.RefreshDayItem), slot0.dayList_, BirtndaySettingItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		SetActive(uv0.Go, false)
		ShowMessageBox({
			content = string.format(GetTips("TIPS_SET_BIRTHDAY"), uv0.monthPageIndex_, uv0.dayPageIndex_),
			OkCallback = function ()
				PlayerAction.ChangePlayerBirthday(uv0.monthPageIndex_, uv0.dayPageIndex_)
			end,
			MaskCallback = function ()
				SetActive(uv0.Go, true)
				uv0.monthScrollHelper_:StartScroll(#uv1, uv0.monthPageIndex_, true, false)
				uv0.dayScrollHelper_:StartScroll(uv2[uv0.monthPageIndex_], uv0.dayPageIndex_, true, false)
			end,
			CancelCallback = function ()
				SetActive(uv0.Go, true)
				uv0.monthScrollHelper_:StartScroll(#uv1, uv0.monthPageIndex_, true, false)
				uv0.dayScrollHelper_:StartScroll(uv2[uv0.monthPageIndex_], uv0.dayPageIndex_, true, false)
			end
		})
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, JumpTools.Back)
	slot0.monthScrollHelper_:SetPageChangeHandler(handler(slot0, slot0.OnMonthPageChange))
	slot0.dayScrollHelper_:SetPageChangeHandler(handler(slot0, slot0.OnDayPageChange))
end

function slot0.OnChangeBirthday(slot0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		content = GetTips("TIPS_SET_BIRTHDAY_SURE"),
		OkCallback = JumpTools.Back
	})
end

function slot0.OnMonthPageChange(slot0, slot1)
	if slot1 == 0 then
		slot1 = 1
	end

	slot0.monthPageIndex_ = slot1 > #uv0 and #uv0 or slot1

	if uv1[slot0.monthPageIndex_] < slot0.dayPageIndex_ then
		slot0.dayPageIndex_ = 1
	end

	slot0.dayScrollHelper_:StartScroll(uv1[slot0.monthPageIndex_], slot0.dayPageIndex_, true, false)
end

function slot0.OnDayPageChange(slot0, slot1)
	if slot1 == 0 then
		slot1 = 1
	end

	slot0.dayPageIndex_ = uv0[slot0.monthPageIndex_] < slot1 and uv0[slot0.monthPageIndex_] or slot1
end

function slot0.RefreshMonthItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.monthPageIndex_)
end

function slot0.RefreshDayItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.dayPageIndex_)
end

function slot0.OnEnter(slot0)
	slot0.dayPageIndex_ = 1
	slot0.monthPageIndex_ = 1

	slot0.monthScrollHelper_:StartScroll(#uv0, slot0.monthPageIndex_, true, false)
	slot0.dayScrollHelper_:StartScroll(uv1[slot0.monthPageIndex_], slot0.dayPageIndex_, true, false)
end

function slot0.Dispose(slot0)
	slot0.monthScrollHelper_:Dispose()

	slot0.monthScrollHelper_ = nil

	slot0.dayScrollHelper_:Dispose()

	slot0.dayScrollHelper_ = nil

	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
