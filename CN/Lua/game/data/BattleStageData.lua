slot0 = singletonClass("BattleStageData")

function slot0.Init(slot0)
	slot0.stageList_ = {}
	slot0.maxChapterLevel_ = 1
	slot0.chapterStarReward_ = {}
	slot0.chapterStarCnt_ = {}
	slot0.openChapter_ = {}
	slot0.subPlotRedPointFlag_ = {}
end

slot1 = -1

function slot0.InitPlotData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ChapterCfg[getChapterIDByStageID(slot7.id)] ~= nil then
			slot0.stageList_[slot7.id] = {
				id = slot7.id,
				clear_times = slot7.clear_times,
				stars = {}
			}

			if slot9.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
				slot0:ModifyThreeStar(slot7.id, slot7.star_list)

				if slot0.maxChapterLevel_ < slot9.sub_type then
					slot0.maxChapterLevel_ = slot9.sub_type
				end

				slot2[slot8] = true
				slot0.openChapter_[slot8] = true
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot0:CalcChapterStarCnt(slot6)
	end

	slot3 = uv0
	uv0 = 0

	for slot7, slot8 in pairs(slot0.openChapter_) do
		if ChapterTools.IsClearChapter(slot7) then
			uv0 = uv0 + 1
		end
	end

	if slot3 >= 0 and slot3 < uv0 then
		SendMessageManagerToSDK("chapter_main", {
			passChapter = uv0
		})
	end

	manager.notify:Invoke(BATTLE_STAGE_PLOT_CHANGE)
end

function slot0.ModifyThreeStar(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot0.stageList_[slot1].stars[slot6] = slot7
	end
end

function slot0.CalcChapterStarCnt(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in ipairs(ChapterCfg[slot1].section_id_list) do
		if slot0.stageList_[slot8] then
			for slot12 = 1, 3 do
				slot3 = slot3 + slot0.stageList_[slot8].stars[slot12]
			end
		end
	end

	slot0.chapterStarCnt_[slot1] = slot3
end

function slot0.ClientModifyThreeStar(slot0, slot1, slot2)
	slot0:ModifyThreeStar(slot1, slot2)
	slot0:CalcChapterStarCnt(getChapterIDByStageID(slot1))
end

slot2 = {
	[2014.0] = 0,
	[202.0] = 0,
	[2012.0] = 0,
	[2015.0] = 0,
	[2013.0] = 0,
	[2016.0] = 0,
	[2011.0] = 0
}
slot3 = -1

function slot0.InitResourceData(slot0, slot1)
	slot2, slot3, slot4 = nil

	for slot8, slot9 in ipairs(slot1) do
		print(slot9.id)

		chapterID = getChapterIDByStageID(slot9.id)
		slot0.stageList_[slot9.id] = {
			id = slot9.id,
			clear_times = slot9.clear_times
		}
		slot3 = slot9.id
		slot0.openChapter_[chapterID] = true
	end

	slot5 = BattleDailyStageCfg[slot3]
	slot6 = PlayerData:GetPlayerInfo().userLevel

	if uv0 > 0 then
		if slot5 and slot5.level <= slot6 and ChapterTools.IsClearChapter(chapterID) then
			print(uv1[chapterID])

			if uv1[chapterID] == 0 then
				uv1[chapterID] = 1

				SendMessageManagerToSDK("unlockStage", {
					chapterID = chapterID
				})
			end
		end
	else
		uv0 = 1

		for slot10, slot11 in pairs(uv1) do
			print(slot10)

			if ChapterTools.IsClearChapter(slot10) then
				uv1[slot10] = 1

				print(uv1[slot10])
			end
		end
	end
end

function slot0.InitChallengeData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = getChapterIDByStageID(slot6.id)
		slot8 = ChapterCfg[slot7]
		slot0.stageList_[slot6.id] = {
			id = slot6.id,
			clear_times = slot6.clear_times,
			stars = {}
		}
		slot0.openChapter_[slot7] = true

		slot0:ModifyThreeStar(slot6.id, slot6.star_list)
	end
end

function slot0.InitChapterStarReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.chapterStarReward_[slot6.id] = {}

		for slot10, slot11 in ipairs(slot6.reward_list) do
			slot0.chapterStarReward_[slot6.id][slot11.reward_order] = slot11.is_received
		end
	end
end

function slot0.GetMaxChapterLevel(slot0)
	return slot0.maxChapterLevel_
end

function slot0.GetStageData(slot0)
	return slot0.stageList_
end

function slot0.SetChapterStarReward(slot0, slot1, slot2)
	if slot0.chapterStarReward_[slot1] == nil then
		slot0.chapterStarReward_[slot1] = {}
	end

	slot0.chapterStarReward_[slot1][slot2] = 2
end

function slot0.GetChapterStarRewardState(slot0)
	return slot0.chapterStarReward_
end

function slot0.IsOpenChapter(slot0, slot1)
	return slot0.openChapter_[slot1]
end

function slot0.GetChapterStarCnt(slot0, slot1)
	return slot0.chapterStarCnt_[slot1] or 0
end

function slot0.GetChapterStarList(slot0)
	return slot0.chapterStarCnt_
end

function slot0.GetChapterRedPointNotice(slot0, slot1)
	slot2 = slot0.chapterStarReward_
	slot3 = slot0.chapterStarCnt_[slot1] or 0

	for slot7 = 1, 3 do
		if ChapterCfg[slot1].star_need[slot7] <= slot3 then
			if not slot2[slot1] or not slot2[slot1][slot7] or slot2[slot1][slot7] < 1 then
				return true
			end
		end
	end

	return false
end

function slot0.GetOpenChapter(slot0)
	return slot0.openChapter_
end

function slot0.SetSubPlotRedPointFlag(slot0, slot1)
	slot0.subPlotRedPointFlag_[slot1] = 1
end

function slot0.GetSubPlotRedPointFlag(slot0, slot1)
	return slot0.subPlotRedPointFlag_[slot1]
end

return slot0
