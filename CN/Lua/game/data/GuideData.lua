slot0 = singletonClass("GuideData")

function slot0.Init(slot0)
	slot0.finishGuideID_ = {}
end

function slot0.InitGuideData(slot0, slot1)
	slot0.finishGuideID_ = {}

	for slot5, slot6 in ipairs(slot1.mod_guide_list) do
		table.insert(slot0.finishGuideID_, slot6)
	end
end

function slot0.IsFinish(slot0, slot1)
	return table.keyof(slot0.finishGuideID_, slot1) ~= nil
end

function slot0.FinishGuideID(slot0, slot1)
	table.insert(slot0.finishGuideID_, slot1)
end

return slot0
