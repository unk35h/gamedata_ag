ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("GuildActivitySubmoduleItem", ActivitySubmoduleItem)

function slot0.OnEnter(slot0)
	slot0.activiteData_ = ActivityData:GetActivityData(slot0.activityId_)
	slot0.startTime_ = slot0.activiteData_.startTime
	slot0.stopTime_ = slot0.activiteData_.stopTime

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	slot0:RefreshLock()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, ActivityConst.GUILD_ACTIVITY_START))
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.updateHandler_)
	slot0:StopTimer()
end

return slot0
