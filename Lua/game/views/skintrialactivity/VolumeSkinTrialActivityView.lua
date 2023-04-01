slot0 = class("VolumeSkinTrialActivityView", SkinTrialActivityView)

function slot0.UIName(slot0)
	if ActivityTools.GetActivityTheme(slot0.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		if slot0.params_.activityID == ActivityConst.TYR_SKIN_TRIAL then
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_1"
		else
			return "UI/VolumeIIIDownUI/SkinTrial/VolumeIIIDownSkinTrialMainUI_2"
		end
	else
		return "UI/VolumeIIIUI/VolumeSkinTrialMainUI"
	end
end

function slot0.RefreshSkinItem(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot5] then
			slot0.skinItemList_[slot5]:SetSkinTrialID(slot6)
		else
			slot0.skinItemList_[slot5] = slot0:GetItemClass().New(slot0.skinItemPanel_:GetChild(slot5 - 1).gameObject, slot6)
		end
	end

	for slot5 = #slot0.skinItemList_, #slot0.skinTrialIDList_ + 1, -1 do
		slot0.skinItemList_[slot5]:Dispose()

		slot0.skinItemList_[slot5] = nil
	end
end

function slot0.GetItemClass(slot0)
	return VolumeSkinTrialActivityItem
end

return slot0
