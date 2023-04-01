slot0 = class("EquipRecGroupItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.titleStrings_ = {
		GetTips("EQUIP_RECOMMEND_1"),
		GetTips("EQUIP_RECOMMEND_2"),
		GetTips("EQUIP_RECOMMEND_3")
	}
	slot0.descItems_ = {}

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "index"
	slot0.indexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.items_ = {}
	slot0.itemGos_ = {
		slot0.item1,
		slot0.item2,
		slot0.item3,
		slot0.item4,
		slot0.item5,
		slot0.item6
	}

	for slot4 = 1, 6 do
		table.insert(slot0.items_, EquipRecItem.New(slot0.itemGos_[slot4]))
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.equipList_ = slot2
	slot0.heroId_ = slot3

	slot0.indexController_:SetSelectedState(tostring(slot1))
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.titleStrings_[slot0.index_]

	for slot4 = 1, #slot0.items_ do
		slot5 = slot0.equipList_[slot4]

		slot0.items_[slot4]:SetEquipId(slot4, slot0.heroId_, slot5, slot0:HaveEquipWithRace(slot5))
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.equipList_) do
		if not table.indexof(slot1, EquipCfg[slot6].suit) then
			table.insert(slot1, slot8)
		end
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = EquipSuitCfg[slot6]
		slot10 = GetCfgDescription(EquipEffectCfg[slot7.suit_effect[1]].desc[1], 1)
		slot11 = slot7.name

		if not slot0.descItems_[slot5] then
			slot0.descItems_[slot5] = EquipRecDescItem.New(Object.Instantiate(slot0.descItemPrefab_, slot0.container_))
		end

		slot0.descItems_[slot5]:SetData(slot11, slot10)
	end

	while #slot0.descItems_ > #slot1 do
		slot0.descItems_[#slot0.descItems_]:Dispose()
		table.remove(slot0.descItems_, #slot0.descItems_)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.container_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.gotoChangeBtn_, nil, function ()
		slot1 = {}

		if (EquipRecommendCfg[uv0.heroId_] and EquipRecommendCfg[uv0.heroId_].suit_list or {})[1] then
			table.insert(slot1, slot0[1])
		end

		if slot0[2] then
			table.insert(slot1, slot0[2])
		end

		uv0:Go("/heroEquipBag", {
			isOpenInfo = false,
			suitPos = 0,
			isClearPos = true,
			suit = "recommend",
			heroId = uv0.heroId_,
			ids = slot1
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.HaveEquipWithRace(slot0, slot1)
	slot2 = {
		slot1
	}

	if EquipCfg[slot1].race == 0 then
		for slot8, slot9 in ipairs(EquipCfg.get_id_list_by_suit[slot3.suit]) do
			if EquipCfg[slot9].starlevel == slot3.starlevel and slot10.pos == slot3.pos then
				table.insert(slot2, slot9)
			end
		end
	end

	for slot8, slot9 in pairs(EquipData:GetEquipList()) do
		if table.indexof(slot2, slot9.prefab_id) then
			return true
		end
	end

	return false
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.items_ then
		for slot4, slot5 in ipairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	if slot0.descItems_ then
		for slot4, slot5 in ipairs(slot0.descItems_) do
			slot5:Dispose()
		end

		slot0.descItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
