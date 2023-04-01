ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("ActivityHeroTrialItem", ActivitySubmoduleItem)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityId_ = slot2
	slot0.theme_ = ActivityTools.GetActivityTheme(slot0.activityId_)
	slot0.refreshHeroTrialBtnHandler = handler(slot0, slot0.RefreshHeroTrialBtn)

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(HERO_TRIAL_UPDATE, slot0.refreshHeroTrialBtnHandler)
	slot0:RefreshHeroTrialBtn()
	slot0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.super.OnExit(slot0)
	manager.notify:RemoveListener(HERO_TRIAL_UPDATE, slot0.refreshHeroTrialBtnHandler)
end

function slot0.RefreshHeroTrialBtn(slot0)
	slot1 = nil

	for slot5, slot6 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		if ActivityData:GetActivityIsOpen(slot5) and ActivityTools.GetActivityTheme(slot5) == slot0.theme_ then
			slot0.activityId_ = slot5
		end
	end
end

return slot0
