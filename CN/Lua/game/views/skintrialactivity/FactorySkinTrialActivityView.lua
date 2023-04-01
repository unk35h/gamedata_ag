slot1 = class("FactorySkinTrialActivityView", import("game.views.skinTrialActivity.SkinTrialActivityView"))

function slot1.UIName(slot0)
	if slot0.params_.activityID == ActivityConst.FACTORY_SKIN_TRIAL then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_1"
	else
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_2"
	end
end

function slot1.RefreshSkinItem(slot0)
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

function slot1.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		return
	end

	for slot4, slot5 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot4] and slot0.skinItemList_[slot4].RefreshTime ~= nil then
			slot0.skinItemList_[slot4]:RefreshTime()
		end
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			return
		end

		for slot3, slot4 in ipairs(uv0.skinTrialIDList_) do
			if uv0.skinItemList_[slot3] and uv0.skinItemList_[slot3].RefreshTime ~= nil then
				uv0.skinItemList_[slot3]:RefreshTime()
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot1.GetItemClass(slot0)
	return FactorySkinTrialActivityItem
end

return slot1
