slot1 = class("SlayerStageItem_1_7", import("game.views.activity.Submodule.slayer.volume.VolumeSlayerItem"))

function slot1.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0:BindRedPoint(slot3)

	slot0.slayer_activity_id = slot2
	slot0.region_activity_id = slot3
	slot0.index = slot1
	slot0.m_name.text = ActivitySlayerCfg[slot3].name

	if SlayerData:GetPoint(slot0.slayer_activity_id, slot0.region_activity_id) == 0 then
		slot0.scoreController:SetSelectedIndex(0)
	else
		slot0.scoreController:SetSelectedIndex(1)

		slot0.m_maxPointLab.text = slot6
	end

	slot0:RefreshTime()

	slot7 = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot0.region_activity_id]

	SetActive(slot0.m_completeGo, ActivitySlayerPointRewardCfg[slot7[#slot7]].need <= slot6)
end

function slot1.Dispose(slot0)
	slot0:UnbindRedPoint()
	uv0.super.Dispose(slot0)
end

function slot1.BindRedPoint(slot0, slot1)
	if slot0.region_activity_id == nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot1))
	elseif slot0.region_activity_id ~= slot1 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.region_activity_id))
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot1))
	end
end

function slot1.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.region_activity_id))
end

return slot1
