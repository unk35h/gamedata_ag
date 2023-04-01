slot0 = class("AchievementStoryInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Achievement/AchievementStoryInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	SetActive(slot0.imageBg_.gameObject, AchievementStoryCfg[slot0.params_.storyID].bg ~= "")

	if slot1.bg ~= "" then
		slot0.imageBg_.sprite = getSpriteViaConfig("Loading", slot1.bg)
	end

	slot0.textTitle_.text = slot1.name
	slot0.textContent_.text = slot1.desc
	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
end

return slot0
