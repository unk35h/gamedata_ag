slot0 = class("EquipInheritComfirmView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipInheritPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.equipInfoView_ = EquipInheritInfoView.New(slot0.infoGo_)

	SetActive(slot0.infoGo_, true)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnInherit_, nil, function ()
		EquipAction.InheritEquip(uv0.equipID_, uv0.selectPrefabID_, uv0.suitID_)
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	slot0.equipInfoView_:Dispose()

	slot0.equipInfoView_ = nil
end

function slot0.OnEnter(slot0)
	slot0.equipID_ = slot0.params_.equipID
	slot5 = slot0.equipID_
	slot0.equipCfg_ = EquipCfg[EquipData:GetEquipData(slot5).prefab_id]
	slot0.suitID_ = slot0.params_.suitID

	for slot5 = #EquipCfg.get_id_list_by_suit[slot0.suitID_], 1, -1 do
		if EquipCfg[slot1[slot5]].pos == slot0.equipCfg_.pos and slot6.starlevel >= 5 then
			slot0.selectPrefabID_ = slot1[slot5]

			break
		end
	end

	slot2 = deepClone(EquipData:GetEquipData(slot0.equipID_))
	slot2.isKeep = true
	slot2.prefab_id = slot0.selectPrefabID_
	slot2.equipConfig = EquipCfg[slot0.selectPrefabID_]

	slot0.equipInfoView_:RefreshData(slot0, slot2)
end

function slot0.OnEquipInherit(slot0)
	slot0:Back()
end

return slot0
