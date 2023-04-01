slot0 = class("HellaParkourTargetItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.m_lab.text = BattleInstance.GetStarMissionText(slot3[1], slot3[2], slot3[3])

	if ParkourData:GetParkourStarState(slot2, slot1) then
		slot0.stateController:SetSelectedIndex(slot4 and 2 or 0)
	else
		slot0.stateController:SetSelectedIndex(1)
	end
end

return slot0
