slot1 = class("HellaSlayerRewardView", import("game.views.activity.Submodule.slayer.HellaSlayerRewardView"))

function slot1.Refresh(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = 0

	for slot8 = #slot0.regionList, 1, -1 do
		slot1 = slot1 + #(ActivitySlayerPointRewardCfg.get_id_list_by_activity_id[slot0.regionList[slot8]] or {})
		slot11 = SlayerData:GetPoint(slot0.slayer_activity_id, slot9)

		for slot15, slot16 in ipairs(slot10) do
			if ActivitySlayerPointRewardCfg[slot16].need <= slot11 and not SlayerData:GetReceivedReward(slot0.slayer_activity_id, slot16) then
				slot3 = slot8
			end
		end
	end

	slot0.m_receiveLab.text = slot2 + SlayerData:GetRewardCount(slot0.slayer_activity_id) .. "/" .. slot1

	for slot9 = 1, #slot0.regionList do
		if not slot0.rewardItems[slot9] then
			slot0.rewardItems[slot9] = SlayerTools.GetRewardItemClass(slot0.slayer_activity_id).New(Object.Instantiate(slot0.m_item, slot0.m_content))
		end

		slot0.rewardItems[slot9]:SetData(slot0.slayer_activity_id, slot0.regionList[slot9])
		slot0.rewardItems[slot9]:SetActive(true)
	end

	for slot10 = slot5 + 1, #slot0.rewardItems do
		slot0.rewardItems[slot10]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)

	if slot3 ~= 0 then
		slot7 = 0

		for slot12 = 1, slot3 - 1 do
			slot7 = slot7 + (slot0.rewardItems[slot12] and slot0.rewardItems[slot12]:GetHeight() or 0)
		end

		slot0.m_content.anchoredPosition = Vector2.New(0, slot7)
	end
end

return slot1
