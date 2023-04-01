slot1 = class("SlayerRewardItem_1_7", import("game.views.activity.Submodule.slayer.HellaSlayerRewardItem"))

function slot1.SetData(slot0, slot1, slot2)
	slot0.slayer_activity_id = slot1
	slot0.region_activity_id = slot2
	slot0.pointRewards = ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot2] or {}

	slot0.list:StartScroll(#slot0.pointRewards)

	slot0.hight = slot0.transform_.sizeDelta.y
	slot0.m_title.text = ActivitySlayerCfg[slot2] and ActivitySlayerCfg[slot2].name or ""
end

return slot1
