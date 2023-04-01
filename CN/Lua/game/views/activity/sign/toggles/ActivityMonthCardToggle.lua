slot0 = class("ActivityMonthCardToggle", ActivityBaseToggle)

function slot0.GetName(slot0)
	return "ActivityMonthCardToggle"
end

function slot0.IsActivity(slot0)
	return RechargeData:HaveMonthCard()
end

function slot0.UIClass(slot0)
	return MonthCardPage
end

function slot0.Check(slot0)
	return RechargeData:HaveMonthCard() and not RechargeData:IsSignToday()
end

function slot0.Title(slot0)
	return GetTips("SIGN_TITLE_MONTHCARD")
end

function slot0.Image(slot0)
	return getSprite("Atlas/ActivityUI", "paging_monthCard_b"), getSprite("Atlas/ActivityUI", "paging_monthCard_a")
end

function slot0.Order(slot0)
	return 21
end

return slot0
