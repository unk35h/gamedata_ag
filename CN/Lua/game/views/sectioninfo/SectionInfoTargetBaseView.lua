slot0 = class("SectionInfoTargetBaseView", import(".SectionInfoBaseView"))

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.sectionTargets_ = {}

	for slot4 = 1, 3 do
		slot0.sectionTargets_[slot4] = SectionTargetItem.New(slot0[string.format("targetItem%s_", slot4)], slot4)
	end

	SetActive(slot0.targetPanel_, true)
end

function slot0.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0:RefreshTarget()
end

function slot0.RefreshTarget(slot0)
	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot6, slot7 = slot0:GetThreeStar(slot4)

		slot5:Refresh(slot6, slot7)
	end
end

function slot0.GetThreeStar(slot0, slot1)
	return false, nil
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot5:Dispose()
	end

	slot0.sectionTargets_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
