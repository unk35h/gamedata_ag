slot0 = class("TowerGamePlaneItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI(slot1)

	slot0.islockcontroller_ = ControllerUtil.GetController(slot0.transform_, "islock")
	slot0.imagecontroller_ = ControllerUtil.GetController(slot0.transform_, "image")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.cfg = TowerGameData:GetPlaneCfgByTypeAndIndex(slot2, slot1)
	slot0.nametext_.text = slot0.cfg.name
	slot0.desctext_.text = slot0.cfg.desc

	slot0.imagecontroller_:SetSelectedState(slot0.cfg.id)

	if TowerGameData:GetPlaneIsUnlock(slot0.cfg.id) then
		slot0.islockcontroller_:SetSelectedState("false")
	else
		slot0.islockcontroller_:SetSelectedState("true")

		slot0.locktext_.text = string.format(GetTips("ACTIVITY_TOWER_DEFENSE_UNLOCK_DESC"), BattleTowerGameCfg[TowerGameCfg[TowerGamePlaneCfg[slot0.cfg.id].condition].stage_id].name)
	end
end

return slot0
