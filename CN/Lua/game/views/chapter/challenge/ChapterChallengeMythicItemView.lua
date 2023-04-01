slot1 = class("ChapterChallengeMythicItemView", import(".ChapterChallengeItemView"))

function slot1.GetLostTime(slot0)
	return MythicData:GetNextRefreshTime()
end

function slot1.ClickItem(slot0)
	if MythicData:GetDifficulty() == MythicData:GetFinalId() then
		JumpTools.GoToSystem("/mythicUltimateView", nil, ViewConst.SYSTEM_ID.MYTHIC)
	else
		JumpTools.GoToSystem("/mythic", nil, ViewConst.SYSTEM_ID.MYTHIC)
	end
end

function slot1.AddRedPoint(slot0)
	if MythicData:GetDifficulty() == MythicData:GetFinalId() then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.MYTHIC_FINAL_AWARD)
	else
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.MYTHIC_TIMES_AWARD)
	end
end

function slot1.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

return slot1
