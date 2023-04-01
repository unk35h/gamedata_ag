slot0 = class("AntitheticalCoupletResultView", ReduxView)

function slot0.UIName(slot0)
	return AntitheticalCoupletTools.GetResultUIName(slot0.params_.activityId)
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
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityId = uv0.params_.activityId
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.couplet1_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/couplets/" .. ActivitySpringFestivalCoupletsCfg[slot0.params_.id].start_picture)

	if not slot0.params_.isComplet then
		slot3 = manager.story:GetStoryChoice()[1] or 1
		slot0.couplet2_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/couplets/" .. slot1.result_picture[slot3])

		AntitheticalCoupletAction:ChooseStoryID(slot0.params_.id, slot3)
	else
		slot0.couplet2_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/couplets/" .. slot1.result_picture[AntitheticalCoupletData:GetData(slot0.params_.id) and slot2.chooseID or 1])
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
