slot0 = class("SummerPlotRemasteredItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		saveData("osirisExtraStory", "summer_" .. uv0.storyID_, 1)

		slot0 = uv0

		slot0:RefreshNotice()

		slot0 = manager.notify

		slot0:Invoke(PLAY_EXTRA_STORY_START)

		slot0 = manager.story

		slot0:StartStoryById(uv0.storyID_, function ()
			manager.notify:Invoke(PLAY_EXTRA_STORY_OVER)
		end)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.controller_:SetSelectedState("false")

	slot0.nameText_.text = StoryCfg[slot1].name
	slot0.storyID_ = slot1

	slot0:RefreshNotice()
end

function slot0.RefreshNotice(slot0)
	if getData("osirisExtraStory", "summer_" .. slot0.storyID_) then
		SetActive(slot0.noticeGo_, false)
	else
		SetActive(slot0.noticeGo_, true)
	end
end

return slot0
