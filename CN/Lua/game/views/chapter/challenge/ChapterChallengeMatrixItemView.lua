slot1 = class("ChapterChallengeMatrixItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
	return ActivityData:GetActivityData(PolyhedronData:GetActivityID()).stopTime
end

function slot1.ClickItem(slot0)
	if not PolyhedronData:GetPolyhedronInfo() then
		return
	end

	if slot0.isShowNew_ == 1 then
		slot0.isShowNew_ = 0

		RedPointData:SetJsonCacheRedPoint("Polyhedron")
		SetActive(slot0.newNoticeGo_, false)
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.POLYHEDRON)
	end

	if PolyhedronConst.STATE_TYPE.SETTLEMENT == slot1:GetState() then
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronOver", nil)
	else
		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, ViewConst.SYSTEM_ID.MATRIX)
	end
end

function slot1.AddRedPoint(slot0)
	slot0.isShowNew_ = RedPointData:GetJsonCacheRedPoint("Polyhedron")

	if slot0.isShowNew_ == 1 and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		SetActive(slot0.newNoticeGo_, true)
	else
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.POLYHEDRON)
	end
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot1
