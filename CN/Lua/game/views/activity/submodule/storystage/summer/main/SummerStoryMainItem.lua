slot0 = class("SummerStoryMainItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = uv0.chapterID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = #ActivityStoryChapterCfg[slot0.chapterID_].stage_list
	slot2 = 0
	slot5 = StoryStageActivityData
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetStageData(slot7, slot0.chapterID_)) do
		if slot7.clear_times > 0 then
			slot2 = slot2 + 1
		end
	end

	slot2 = slot2 / slot1
	slot0.progressText_.text = string.format("%d%%", slot2 * 100)
	slot0.slider_.fillAmount = slot2

	if slot2 < 1 then
		slot0.controller_:SetSelectedState("enter")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
