slot0 = class("ResourceHeroBreakStgeItem", ChapterDailyItemView)

function slot0.ClickItem(slot0, slot1)
	slot4 = ChapterClientCfg[slot1].chapter_list[1]

	if BattleFieldData:GetStageByClientID(slot1) then
		slot4 = getChapterIDByStageID(slot5)
	end

	BattleFieldData:SetCacheChapterClient(slot2.toggle, slot1)

	slot7 = slot2.chapter_list

	BattleFieldData:SetSecondCacheChapter(ChapterClientCfg[slot1].toggle, slot1)
	slot0:Go("/daily", {
		chapterID = slot4
	})
end

return slot0
