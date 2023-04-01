slot0 = class("StageArchiveView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/plot/MardukplotPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot2 = StageArchiveCfg[slot0.params_.archiveID]
	slot0.nameText_.text = slot2.name
	slot0.archiveText_.text = slot2.desc

	if slot0.iconImage_ then
		slot0.iconImage_.sprite = getSpriteWithoutAtlas(slot2.iconPath)
	end

	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
	if slot0.iconImage_ then
		slot0.iconImage_.sprite = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

return slot0
