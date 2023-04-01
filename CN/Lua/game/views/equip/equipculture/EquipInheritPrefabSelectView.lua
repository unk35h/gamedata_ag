slot0 = class("EquipInheritPrefabSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/SuitSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tgl_ = {}
	slot0.tglCon_ = {}

	for slot4 = 0, #EquipSuitCfg.get_id_list_by_equip_type + 1 do
		slot5 = Object.Instantiate(slot0.tempBtn_.gameObject, slot0.contentGo_.transform)

		if slot4 <= #EquipSuitCfg.get_id_list_by_equip_type then
			slot5.name = "tgl_" .. slot4

			if slot4 ~= 0 then
				slot5.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("EQUIP_TYPE_" .. slot4)
			else
				slot5.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("RACE_TYPE_9")
			end
		else
			slot5.name = "tgl_all"
			slot5.transform:Find("text").gameObject:GetComponent("Text").text = GetTips("ALL")
		end

		SetActive(slot5, true)

		slot0.tgl_[slot4] = slot5.transform:GetComponent("Toggle")
		slot0.tglCon_[slot4] = ControllerUtil.GetController(slot0.tgl_[slot4].transform, "toggle")
	end

	slot0.tgl_[#EquipSuitCfg.get_id_list_by_equip_type + 1].transform:SetAsFirstSibling()
	slot0.tgl_[0].transform:SetAsLastSibling()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itempanelGo_, SuitSelectItem)
end

function slot0.UpdateData(slot0)
	slot0.suitList_ = {}
	slot1 = HideInfoData:GetEquipSuitHideList()
	slot2 = {}
	slot2 = (slot0.select_ > #EquipSuitCfg.get_id_list_by_equip_type or EquipSuitCfg.get_id_list_by_equip_type[slot0.select_]) and EquipSuitCfg.get_id_list_by_suit
	slot3 = EquipCfg[EquipData:GetEquipData(slot0.params_.equipID).prefab_id].suit

	for slot7, slot8 in ipairs(slot2) do
		slot9 = slot8

		if type(slot8) == "table" then
			slot9 = slot8[1]
		end

		if not slot1[slot9] and slot9 ~= slot3 and EquipSuitCfg[slot9].inherit_cost_type ~= 0 then
			table.insert(slot0.suitList_, slot9)
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.suitList_[slot1] == slot0.selectSuitId_ then
		slot2:ShowSelect(true)
	else
		slot2:ShowSelect(false)
	end

	if slot3 == slot0.params_.currentSuitId then
		slot2:ShowCurrentUp(true)
	else
		slot2:ShowCurrentUp(false)
	end

	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:RegistCallBack(function (slot0)
		uv0:SelectSuitItem(slot0)
	end)
end

function slot0.SelectSuitItem(slot0, slot1)
	slot3 = table.indexof(slot0.suitList_, slot1.id)

	if slot0.scrollHelper_:GetItemList()[table.indexof(slot0.suitList_, slot0.selectSuitId_)] then
		slot2[slot4]:ShowSelect(false)
	end

	slot0.selectSuitId_ = slot1.id

	slot2[slot3]:ShowSelect(true)
	slot0:RefreshSelectSuitInfo()
end

function slot0.RefreshSelectSuitInfo(slot0)
	if not EquipSuitCfg[slot0.selectSuitId_] then
		SetActive(slot0.infoGo_, false)

		return
	end

	SetActive(slot0.infoGo_, true)

	slot0.nameText_.text = slot1.name
	slot0.numText_.text = slot1.need
	slot0.contentText_.text = EquipTools.GetEffectDesc(slot1.suit_effect[1])
	slot0.contRect_.anchoredPosition = Vector2(slot0.contRect_.anchoredPosition.x, 0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.bgMaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.upBtn_, nil, function ()
		if uv0.selectSuitId_ == nil then
			return
		end

		if uv0.selectHandler_ ~= nil then
			uv0.selectHandler_(uv0.selectSuitId_)
		end

		JumpTools.Back()
	end)

	slot4 = slot0.selectBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0.buttonUp_ and uv0.buttonUp_ > 0 then
			uv0:HidePop()
			FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

			uv0.clickTimer_ = nil

			return
		end

		SetActive(uv0.contentGo_, true)
		uv0:AddClickTimer()
	end)

	for slot4, slot5 in pairs(slot0.tgl_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SetSelect(uv1)
				uv0:RefreshUI()
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.selectSuitId_ = slot0.params_.suitId
	slot0.selectHandler_ = slot0.params_.selectSuitHandler

	slot0:SetSelect(#EquipSuitCfg.get_id_list_by_equip_type + 1)
	slot0:ResetSort()
	slot0:RefreshUI()
end

function slot0.ResetSort(slot0)
	slot0.tgl_[#EquipSuitCfg.get_id_list_by_equip_type + 1].isOn = true

	for slot4 = 0, #EquipSuitCfg.get_id_list_by_equip_type + 1 do
		if slot4 < #EquipSuitCfg.get_id_list_by_equip_type + 1 then
			slot0.tglCon_[slot4]:SetSelectedState("off")
		else
			slot0.tglCon_[slot4]:SetSelectedState("on")
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0:UpdateData()

	slot1 = false

	if slot0.selectSuitId_ then
		if not table.indexof(slot0.suitList_, slot0.selectSuitId_) then
			slot1 = 1
			slot0.selectSuitId_ = slot0.suitList_[1]
		end
	else
		slot1 = 1
		slot0.selectSuitId_ = slot0.suitList_[1]
	end

	slot0.scrollHelper_:StartScroll(#slot0.suitList_, slot1 - 5 < 1 and 1 or slot1 - slot2)
	slot0:RefreshSelectSuitInfo()
end

function slot0.SetSelect(slot0, slot1)
	slot0.select_ = slot1

	if slot1 == 0 then
		slot0.selectText_.text = GetTips("RACE_TYPE_9")
	elseif slot1 == #EquipSuitCfg.get_id_list_by_equip_type + 1 then
		slot0.selectText_.text = GetTips("ALL")
	else
		slot0.selectText_.text = GetTips("EQUIP_TYPE_" .. slot1)
	end
end

function slot0.OnChangeUpSuit(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		JumpTools.Back()
	end
end

function slot0.AddClickTimer(slot0)
	slot0:StopTimer()

	slot0.buttonUp_ = 0
	slot1 = FuncTimerManager.inst
	slot0.clickTimer_ = slot1:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				uv0:HidePop()
				FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

				uv0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.HidePop(slot0)
	slot0.buttonUp_ = 0

	SetActive(slot0.contentGo_, false)
end

function slot0.OnExit(slot0)
	slot0.selectSuitId_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
