ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivityMainView_1_7", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFMainUI/DFMainUI"
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.leftBtn2_, ActivityConst.TYR_PT),
		ActivitySubmoduleItem.New(slot0.leftBtn4_, ActivityConst.ACTIVITY_1_7_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(slot0.leftBtn5_, ActivityConst.TYR_SLAYER),
		ActivitySubmoduleItem.New(slot0.rightBtn2_, ActivityConst.TYR_SOLO),
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.ACTIVITY_1_7_HERO_TRIAL),
		ActivitySubmoduleItem.New(slot0.rightBtn3_, ActivityConst.ACTIVITY_1_7_AFFIX_SELECT),
		ActivitySubmoduleItem.New(slot0.rightBtn4_, ActivityConst.TYR_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(slot0.rightBtn5_, ActivityConst.TYR_VALENTINE_GAME),
		ActivityShopSubmoduleItem.New(slot0.shopGo_, slot0:GetActivityID())
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.ACTIVITY_1_7
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot1.startTime, "!%m/%d %H:%M"), manager.time:STimeDescS(slot1.stopTime, "!%m/%d %H:%M"))
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.leftBtn1_.transform.transform, ActivityTools.GetRedPointKey(ActivityConst.TYR_SUB_PLOT) .. ActivityConst.TYR_SUB_PLOT)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.leftBtn1_, nil, function ()
		if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityConst.TYR_SUB_PLOT).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1.startTime)))

			return
		end

		ActivityTools.JumpToSubmodulePage(slot0)
	end)
end

return slot0
