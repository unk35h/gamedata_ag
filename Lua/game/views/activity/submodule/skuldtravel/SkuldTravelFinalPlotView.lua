slot0 = class("SkuldTravelFinalPlotView", ReduxView)
slot1 = "Textures/EmptyDream/travel/image/"

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelEndDetails"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = TravelSkuldEndingCfg[slot0.params_.endingid]
	slot0.stroytext_.text = slot1.story_word
	slot0.storyname_.text = slot1.story_name
	slot2 = uv0
	slot0.itemimage_.sprite = getSpriteWithoutAtlas(SkuldTravelData:GetSkuldBtnIsBreach() and slot2 .. slot1.destroy_picture or slot2 .. slot1.picture)

	SetActive(slot0.panelGo_, false)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
