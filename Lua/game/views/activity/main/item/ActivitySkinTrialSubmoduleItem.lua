ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("ActivitySkinTrialSubmoduleItem", ActivitySubmoduleItem)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityId_ = slot2
	slot0.theme_ = ActivityTools.GetActivityTheme(slot0.activityId_)
	slot0.refreshSkinTrialBtnHandler = handler(slot0, slot0.RefreshSkinTrialBtn)

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(SKIN_TRIAL_UPDATE, slot0.refreshSkinTrialBtnHandler)
	slot0:RefreshSkinTrialBtn()
	slot0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.super.OnExit(slot0)
	manager.notify:RemoveListener(SKIN_TRIAL_UPDATE, slot0.refreshSkinTrialBtnHandler)
end

function slot0.RefreshSkinTrialBtn(slot0)
	slot1 = nil
	slot5 = ActivityTemplateConst.SKIN_TRIAL

	for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot5]) do
		if ActivityData:GetActivityIsOpen(slot6) and ActivityTools.GetActivityTheme(slot6) == slot0.theme_ then
			slot0.activityId_ = slot6
		end
	end
end

return slot0
