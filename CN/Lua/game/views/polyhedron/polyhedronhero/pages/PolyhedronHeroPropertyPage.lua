slot0 = class("PolyhedronHeroPropertyPage", NewHeroPropertyPage)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isUnlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isUnlock")
	slot0.levelStateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "levelState")
	slot0.playableDirector_ = slot0.playableDirectorGo_:GetComponent("PlayableDirector")
	slot0.heroInfoView_ = PolyhedronHeroInfoView.New(slot0, slot0.infoViewGo_)
end

function slot0.UpdateView(slot0)
	uv0.super.UpdateView(slot0)
	slot0.isUnlockController_:SetSelectedState("false")
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.unlockDirty_ = true

	if slot0.heroInfo_ == nil then
		slot0.unlockDirty_ = false
	elseif slot2.unlock == 1 and slot1.unlock == 1 then
		slot0.unlockDirty_ = false
	end

	slot0:UpdateView()

	if slot0.unlockDirty_ then
		slot0.playableDirector_.time = 0

		slot0.playableDirector_:Play()
	end
end

return slot0
