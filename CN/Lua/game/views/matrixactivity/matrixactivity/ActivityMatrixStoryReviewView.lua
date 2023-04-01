slot0 = class("ActivityMatrixStoryReviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeStoryReviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.storyItems = {}
	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
end

function slot0.AddUIListener(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot1 = ActivityStoryCollect[ActivityConst.VOLUME_MATRIX] and ActivityStoryCollect[ActivityConst.VOLUME_MATRIX].story_id or {}
	slot0.storyList = {}

	for slot5, slot6 in ipairs(slot1) do
		if manager.story:IsStoryPlayed(slot6) then
			table.insert(slot0.storyList, slot6)
		end
	end

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	for slot5 = 1, #slot0.storyList do
		if not slot0.storyItems[slot5] then
			slot0.storyItems[slot5] = ActivityMatrixStoryReviewItem.New(Object.Instantiate(slot0.m_item, slot0.m_content))
		end

		slot0.storyItems[slot5]:SetData(slot0.storyList[slot5])
		slot0.storyItems[slot5]:SetActive(true)
	end

	for slot6 = slot1 + 1, #slot0.storyItems do
		slot0.storyItems[slot6]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)

	if #slot0.storyList == 0 then
		slot0.emptyController:SetSelectedIndex(1)
	else
		slot0.emptyController:SetSelectedIndex(0)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.storyItems) do
		slot5:Dispose()
	end

	slot0.storyItems = {}

	uv0.super.Dispose(slot0)
end

return slot0
