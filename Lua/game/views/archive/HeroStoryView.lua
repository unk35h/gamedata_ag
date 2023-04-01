slot0 = class("HeroStoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroArchive/ArchiveStoryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.itemInstance_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
	manager.ui:SetMainCamera("hero")

	slot0.heroID_ = slot0.params_.heroID
	slot0.archiveID_ = HeroTools.GetHeroOntologyID(slot0.heroID_)

	if #HeroRecordCfg[slot0.archiveID_].plot_id > 1 then
		slot0.controller_:SetSelectedState("unlock")

		slot0.itemList_ = HeroRecordCfg[slot0.archiveID_].plot_id
		slot5 = "HeroIcon"
		slot0.picImg_.sprite = getSpriteViaConfig(slot5, slot0.heroID_)

		for slot5 = 1, #slot0.itemList_ do
			slot6 = slot0["itemGo_" .. slot5]

			if not slot0.itemInstance_[slot5] then
				slot0.itemInstance_[slot5] = HeroArchiveStoryItem.New(slot6)
			end

			slot0.itemInstance_[slot5]:RefreshUI(slot5, slot0.archiveID_)
		end
	else
		slot0.controller_:SetSelectedState("lock")
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	OperationRecorder.RecordStayView("STAY_VIEW_HERO_STORY", slot0:GetStayTime(), slot0.heroID_)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemInstance_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
