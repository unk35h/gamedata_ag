slot0 = class("HellaSlayerRewardView", ReduxView)

function slot0.UIName(slot0)
	return SlayerTools.GetRewardUIName(slot0.params_.slayer_activity_id or 61131)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.slayer_activity_id = slot0.params_.slayer_activity_id or 61131
	slot1 = ActivityCfg[slot0.slayer_activity_id]

	if slot0.params_.region_activity_id then
		slot0.regionList = {
			slot0.params_.region_activity_id
		}

		SetActive(slot0.m_receiveLab.gameObject, false)
	else
		slot0.regionList = slot1 and slot1.sub_activity_list or {}

		SetActive(slot0.m_receiveLab.gameObject, true)
	end

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = 1

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

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems) do
		slot5:Dispose()
	end

	slot0.rewardItems = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnSlayerReward(slot0)
	slot0:Refresh()
end

return slot0
