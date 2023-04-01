slot0 = class("IlluPlotItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.info_ = slot1
	slot0.selType_ = slot2

	table.sort(slot0.info_.storyList)

	slot3 = 0

	for slot7, slot8 in ipairs(slot0.info_.storyList) do
		if IllustratedData:GetPlotInfo()[slot8] then
			slot3 = slot3 + 1
		end
	end

	slot0.unlockNum_ = slot3

	if slot3 == 0 then
		slot0.controller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("1")

		if slot2 == 1 then
			slot0.nameText_.text = ChapterCfg[slot1.chapterID].subhead
			slot0.reveiveText_.text = slot3 .. "/" .. slot1.all

			getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotSmall.path .. ChapterClientCfg[slot1.chapterID].chapter_paint, function (slot0)
				uv0.iconImg_.sprite = slot0
			end)
		elseif slot2 == 2 then
			slot0.nameText_.text = ActivityCfg[slot1.chapterID].name
			slot0.reveiveText_.text = slot3 .. "/" .. slot1.all

			getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotSmall.path .. CollectStoryCfg[CollectStoryCfg.get_id_list_by_activity[slot1.chapterID][1]].picture, function (slot0)
				uv0.iconImg_.sprite = slot0
			end)
		elseif slot2 == 3 then
			slot0.nameText_.text = StoryCfg[BirthdayCfg[slot0.info_.chapterID].story_id].name
			slot0.reveiveText_.text = slot3 .. "/" .. slot1.all

			getSpriteWithoutAtlasAsync(SpritePathCfg.CollectPlotSmall.path .. BirthdayCfg[slot0.info_.chapterID].picture_path, function (slot0)
				uv0.iconImg_.sprite = slot0
			end)
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.unlockNum_ > 0 then
			JumpTools.OpenPageByJump("/illuPlotDetail", {
				storyList = uv0.info_.storyList,
				chapterID = uv0.info_.chapterID,
				selType = uv0.selType_
			})
		elseif uv0.selType_ == 1 then
			slot1 = getStageViaStoryID(uv0.info_.storyList[1])
			slot4, slot5 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot1).toggle, slot1)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot1), slot4, slot5))
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
