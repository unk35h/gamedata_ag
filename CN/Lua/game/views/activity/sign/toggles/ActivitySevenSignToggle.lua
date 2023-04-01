slot0 = class("ActivitySevenSignToggle", ActivityBaseToggle)

function slot0.Ctor(slot0, slot1)
	slot0.activityId = slot1
end

function slot0.GetName(slot0)
	return "ActivitySevenSignToggle" .. slot0.activityId
end

function slot0.IsActivity(slot0)
	return ActivityData:GetActivityIsOpen(slot0.activityId) and SignData:GetSevenDaySignInfo(slot0.activityId) ~= nil
end

function slot0.UIClass(slot0)
	return SevenDaySignPage
end

function slot0.RedPointKey(slot0)
	return string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, slot0.activityId)
end

function slot0.Check(slot0)
	return SignTools.GetSevenDaySignIndex(slot0.activityId) ~= 0
end

function slot0.Title(slot0)
	if ActivityCumulativeSignCfg[slot0.activityId] then
		return ActivityCumulativeSignCfg[slot0.activityId].title
	end

	return ""
end

function slot0.Image(slot0)
	return getSprite("Atlas/ActivityUI", "paging_7_b"), getSprite("Atlas/ActivityUI", "paging_7_a")
end

function slot0.Order(slot0)
	return 11
end

function slot0.GetParams(slot0)
	return slot0.activityId
end

function slot0.GetLimitLevel(slot0)
	if ActivityCumulativeSignCfg[slot0.activityId] then
		return ActivityCumulativeSignCfg[slot0.activityId].limit_level
	end

	return 0
end

return slot0
