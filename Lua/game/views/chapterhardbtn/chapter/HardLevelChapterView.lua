slot0 = class("HardLevelChapterView", import("..HardLevelBaseView"))

function slot0.GetHardLevelItem(slot0)
	return HardLevelChapterItem
end

function slot0.RefreshCollectRate(slot0)
	slot0.difficultTargetText_.text = ""
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:ShowRedPoint(true)
end

function slot0.ShowDifficultPanel(slot0, slot1)
	uv0.super.ShowDifficultPanel(slot0, slot1)
	slot0:ShowRedPoint(slot1)
end

function slot0.ShowRedPoint(slot0, slot1)
	if not slot1 then
		if not slot0.isBind_ then
			manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COMBAT_PLOT, {
				x = 184.7,
				y = -27.5
			})

			slot0.isBind_ = true
		end
	elseif slot0.isBind_ then
		manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.COMBAT_PLOT)

		slot0.isBind_ = false
	end
end

return slot0
