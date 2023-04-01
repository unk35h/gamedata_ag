slot0 = class("IlluEnemyFileDetailItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.RefreshUI(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.titleText_.text = slot1.name

	if slot1.isLock then
		slot0.controller_:SetSelectedState("lock")

		slot0.requireText_.text = slot1.info
	else
		slot0.controller_:SetSelectedState("unlock")

		slot0.descText_.text = slot1.info
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.AddUIListener(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
