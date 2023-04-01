slot0 = class("GuildActivityTeamInfoEnergyItemView", ReduxView)

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

	slot0.currentController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "current")
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.maxEnergy_ = slot1
	slot0.currentEnergy_ = slot2

	slot0:UpdateView()
end

function slot0.SetCurrent(slot0, slot1)
	slot0.currentController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.UpdateView(slot0)
	if GuildActivityData:IsFirstConfigFightRole() then
		slot0.maxEnergyLabel_.text = slot0.maxEnergy_
	else
		slot0.maxEnergyLabel_.text = "0"
	end

	slot0.currentEnergyLabel_.text = slot0.currentEnergy_
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
