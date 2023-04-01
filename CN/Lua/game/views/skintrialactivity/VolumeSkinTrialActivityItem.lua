SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")
slot0 = class("VolumeSkinTrialActivityItem", SkinTrialActivityItem)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activityID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:SetSkinTrialID(slot2)
	SetActive(slot0.gameObject_, true)
end

function slot0.RefreshUI(slot0)
	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.stateController_:SetSelectedState("true")
	end
end

return slot0
