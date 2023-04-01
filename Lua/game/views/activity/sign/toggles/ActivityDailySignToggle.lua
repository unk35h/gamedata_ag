slot0 = class("ActivityDailySignToggle", ActivityBaseToggle)

function slot0.GetName(slot0)
	return "ActivityDailySignToggle"
end

function slot0.IsActivity(slot0)
	return ActivityData:GetActivityIsOpen(ActivityConst.SIGN)
end

function slot0.UIClass(slot0)
	return DailySignPage
end

function slot0.RedPointKey(slot0)
	return RedPointConst.SIGN_DAILY
end

function slot0.Check(slot0)
	return SignTools.GetDailySignIndex() ~= 0
end

function slot0.Title(slot0)
	return GetTips("SIGN_TITLE_DAILY")
end

function slot0.Image(slot0)
	return getSprite("Atlas/ActivityUI", "paging_everyday_b"), getSprite("Atlas/ActivityUI", "paging_everyday_a")
end

function slot0.Order(slot0)
	return 31
end

return slot0
