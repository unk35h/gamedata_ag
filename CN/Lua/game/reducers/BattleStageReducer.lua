slot0 = import("game.const.BattleConst")

function slot1(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		slot0.chapterList[slot1].stars[slot6] = slot7
	end
end

return function (slot0, slot1)
	if slot0 == nil then
		slot0 = {
			chapterList = {},
			hardLevel = getData("ChapterMap", "HardLevel") or 1,
			selectChapterID = getData("ChapterMap", "chapterClientID") or ChapterCfg.get_id_list_by_type[uv0.TOGGLE.PLOT][1]
		}
	end

	if ({
		[ACTIONS.CHAPTER_INIT] = function (slot0)
			for slot4, slot5 in ipairs(uv0.data) do
				slot6 = getChapterIDByStageID(slot5.id)
				slot7 = ChapterCfg[slot6]
				slot0.chapterList[slot5.id] = {
					id = slot5.id,
					chapter_id = slot6,
					section_id = table.keyof(slot7.section_id_list, slot5.id),
					difficulty = slot7.type,
					clear_times = slot5.clear_times,
					stars = {}
				}

				uv1(slot0, slot5.id, slot5.star_list)
			end
		end,
		[ACTIONS.CHAPTER_THREE_STAR] = function (slot0)
			uv0(slot0, uv1.data.stageID, uv1.data.starList)
		end,
		[ACTIONS.CHANGE_HARD_LEVEL] = function (slot0)
			slot0.hardLevel = uv0.data.hardLevel

			saveData("ChapterMap", "HardLevel", uv0.data.hardLevel)

			slot1 = slot0.selectChapterID % 100 + 100 * uv0.data.hardLevel
			slot0.selectChapterID = slot1

			saveData("ChapterMap", "chapterClientID", slot1)
		end,
		[ACTIONS.CHANGE_SELECT_CHAPTER] = function (slot0)
			slot0.selectChapterID = uv0.data.chapterID

			saveData("ChapterMap", "chapterClientID", uv0.data.chapterID)
		end
	})[slot1.type] then
		return immer.produce(slot0, function (slot0)
			uv0[uv1.type](slot0)
		end)
	else
		return slot0
	end
end
