slot0 = class("SummerPlotItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not uv0.isLock_ then
			WarChessAction.SetActivityChessPlotRedPoint(ActivityConst.THEME.SUMMER, uv0.storyID_)

			slot0 = manager.story

			slot0:StartStoryById(uv0.storyID_, function ()
			end)
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, slot0.storyID_))
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot3 < slot2 then
		slot0.controller_:SetSelectedState("lock")

		slot0.nameText_.text = string.format(GetTips("EXPLORE_UNLOCK"), slot2)
	else
		slot0.controller_:SetSelectedState("false")

		slot0.nameText_.text = StoryCfg[slot1].name
	end

	slot0.storyID_ = slot1
	slot0.isLock_ = slot4

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, slot0.storyID_))
end

return slot0
