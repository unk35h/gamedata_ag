slot0 = class("SkinTrialSelect105", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeSkinTrialUI_" .. slot0.params_.skinTrialID
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
end

function slot0.OnEnter(slot0)
	if slot0.params_.canPlayAnim == true and slot0.animator_ ~= nil then
		slot0.params_.canPlayAnim = false

		slot0.animator_:Play("VolumeSkinTrialUI_105_02", -1, 0)
	else
		slot0.animator_:Play("VolumeSkinTrialUI_105_01", -1, 0)
	end

	uv0.super.OnEnter(slot0)
end

return slot0
