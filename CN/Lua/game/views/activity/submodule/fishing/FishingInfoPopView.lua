slot0 = class("FishingInfoPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingInfoPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bgController_ = ControllerUtil.GetController(slot0.talkBgTransform_, "talkbg")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "unlock")
	slot0.rareController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rare")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.rect_ = slot0.params_.rect
	slot0.id_ = slot0.params_.id
	slot0.cfg_ = RareFishCfg[slot0.params_.id]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot2 = 0

	if FishingData:GetFish(slot0.id_) ~= nil then
		slot0.unlockController_:SetSelectedState("true")

		slot2 = slot1.len
	else
		slot0.unlockController_:SetSelectedState("false")
	end

	slot0.nameLabel_.text = slot0.cfg_.name
	slot0.descLabel_.text = slot0.cfg_.desc

	slot0.rareController_:SetSelectedState(FishingData:GetRareLabel(slot0.cfg_.rare))

	slot0.tipLabel_.text = slot0.cfg_.talk
	slot0.sizeDescLabel_.text = string.format("%d-%dcm", slot0.cfg_.size[1], slot0.cfg_.size[2])
	slot0.maxSizeLabel_.text = string.format("%dcm", slot2)
	slot3 = 1080 / Screen.height
	slot5 = slot0.params_.rect.y * slot3 - slot0.params_.rect.height * slot3
	slot6 = slot0.container_.transform.localPosition
	slot6.x = slot0.params_.rect.x * slot3 + slot0.params_.rect.width * slot3 + 5

	slot0.bgController_:SetSelectedState("leftBg")

	if slot6.x + slot0.container_.transform.rect.width > Screen.width * slot3 then
		slot6.x = slot0.params_.rect.x * slot3 - slot0.container_.transform.rect.width - 5

		slot0.bgController_:SetSelectedState("rightBg")
	end

	slot6.y = slot5
	slot0.container_.transform.localPosition = slot6

	CustomLog.Log(string.format("%s", tostring(slot0.params_.rect)))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
