slot1 = class("DreamSkinTrialActivityView", import("game.views.skinTrialActivity.FactorySkinTrialActivityView"))

function slot1.UIName(slot0)
	if slot0.params_.activityID == ActivityConst.THOR_SKIN_TRIAL then
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_1"
	else
		return "UI/EmptyDream/SkinTrialUI/EDreamSkinTrialMainUI_2"
	end
end

function slot1.GetItemClass(slot0)
	return DreamSkinTrialActivityItem
end

return slot1
