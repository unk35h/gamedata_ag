slot0 = class("SubPlotExtraStoryBtn", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, getChapterClientCfgByChapterID(slot0.chapterID_).id))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, getChapterClientCfgByChapterID(slot0.chapterID_).id))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if getChapterClientCfgByChapterID(uv0.chapterID_).extra_story_unlock_condition ~= "" then
			for slot4, slot5 in ipairs(slot0.extra_story_unlock_condition) do
				if not isMeetCondition(slot5) then
					ShowTips(getConditionText(slot5))

					return
				end
			end
		end

		BattleStageAction.ClickSubPlotExtraStory(slot0.id)

		if type(slot0.extra_strory_system) == "table" then
			JumpTools.JumpToPage2(slot0.extra_strory_system)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if type(getChapterClientCfgByChapterID(slot0.chapterID_).extra_strory_system) == "table" then
		SetActive(slot0.gameObject_, true)
	else
		SetActive(slot0.gameObject_, false)
	end
end

return slot0
