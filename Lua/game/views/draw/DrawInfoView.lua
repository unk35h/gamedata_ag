slot0 = class("DrawInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Draw/DrawInfoUI"
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

	slot0.probabilityCfgList = {}
	slot0.items = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshData(slot0.params_.poolId)
end

function slot0.RefreshData(slot0, slot1)
	if not DrawPoolCfg[slot1] then
		return
	end

	slot0.labDetailNote_.text = slot2.detail_note

	for slot8 = 1, #slot0:GetProbabilityList(slot1) do
		if not slot0.items[slot8] then
			slot0.items[slot8] = DrawProbabilityItem.New(Object.Instantiate(slot0.item_, slot0.itemParent_))
		end

		slot0.items[slot8]:RefreshData(slot3[slot8])
	end

	for slot8 = slot4 + 1, #slot0.items do
		slot0.items[slot8]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.layout_1)
end

function slot0.GetProbabilityList(slot0, slot1)
	if slot0.probabilityCfgList[slot1] then
		return slot0.probabilityCfgList[slot1]
	end

	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(DrawInfoProbabilityCfg.all) do
		if DrawInfoProbabilityCfg[slot8].pool_id == slot1 then
			if slot9.guarantee ~= 0 then
				slot10 = DrawInfoProbabilityCfg[slot9.guarantee]

				table.insert(slot3, slot10)

				slot9.guaranteeData = slot10
			end

			table.insert(slot2, slot9)
		end
	end

	for slot7, slot8 in pairs(slot3) do
		table.remove(slot2, table.keyof(slot2, slot8))
	end

	slot0.probabilityCfgList[slot1] = slot2

	return slot2
end

function slot0.Dispose(slot0)
	if slot0.items then
		for slot4, slot5 in ipairs(slot0.items) do
			slot5:Dispose()
		end

		slot0.items = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
