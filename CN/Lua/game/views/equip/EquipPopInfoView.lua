slot0 = class("EquipPopInfoView", EquipInfoView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.starController = ControllerUtil.GetController(slot0.m_starController, "star")
end

function slot0.RefreshTitle(slot0)
	uv0.super.RefreshTitle(slot0)
	slot0.starController:SetSelectedIndex(math.max(0, EquipCfg[slot0.info_.prefab_id].starlevel - 2))
end

return slot0
