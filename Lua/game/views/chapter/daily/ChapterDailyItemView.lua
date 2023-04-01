slot0 = class("ChapterDailyItemView", import("..ChapterBaseItemView"))

function slot0.Dispose(slot0)
	slot0.rewardIcon_.sprite = nil

	uv0.super.Dispose(slot0)

	slot0.rewardIcon_ = nil
	slot0.rewardName_ = nil
end

function slot0.RefreshCustomItem(slot0, slot1)
	if slot0.oldCfgID_ ~= slot1.id then
		slot0.rewardName_.text = slot1.desc

		SetSpriteWithoutAtlasAsync(slot0.chapterPaint_, SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint)
		getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterIcon.path .. slot1.drop_icon, function (slot0)
			if uv0.rewardIcon_ == nil then
				return
			end

			uv0.rewardIcon_.sprite = slot0

			uv0.rewardIcon_:SetNativeSize()
		end)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.ClickItem(slot0, slot1)
	slot2 = ChapterClientCfg[slot1]
	slot4 = slot2.chapter_list[1]

	if slot2.not_chapter_id then
		slot4 = BattleFieldData:GetSecondCacheChapter(ChapterClientCfg[slot4].toggle) or slot4

		BattleFieldData:SetSecondCacheChapter(ChapterClientCfg[slot4].toggle, slot4)
		JumpTools.GoToSystem("/resourceHeroBreak", {
			chapterClientID = slot1
		}, ViewConst.SYSTEM_ID.BATTLE)
	else
		if BattleFieldData:GetStageByClientID(slot1) then
			slot4 = getChapterIDByStageID(slot5)
		end

		slot0:Go("/daily", {
			chapterID = slot4
		})
	end
end

return slot0
