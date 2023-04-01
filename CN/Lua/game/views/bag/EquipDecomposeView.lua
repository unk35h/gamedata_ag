slot0 = class("EquipDecomposeView", ReduxView)
slot1 = import("game.tools.HeroTools")
slot2 = import("game.tools.EquipTools")

function slot0.UIName(slot0)
	return "UI/Equip/EquipDecomposeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item_ = Asset.Load("UI/Common/CommonItem")
	slot4 = slot0.listGo_
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot4, CommonItem)
	slot0.starSelect_ = {}

	for slot4 = 1, 5 do
		slot0.starSelect_[slot4] = slot0:FindGo("panel/right/star/star" .. slot4 .. "/select")
	end

	slot0.rewardIndex_ = 0
	slot0.rewardItems_ = {}
	slot0.btnController_ = ControllerUtil.GetController(slot0.decomposeBtn_.transform, "btn_decompose")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.starbutBtn_, nil, function ()
		uv0.currentbutArrow.localEulerAngles = Vector3.New(0, 0, 0)

		SetActive(uv0.cultureContainer_, false)

		if EquipConst.EQUIP_SORT.RARE == uv0.params_.priority then
			return
		end

		uv0.params_.priority = EquipConst.EQUIP_SORT.RARE

		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.culturetbutBtn_, nil, function ()
		uv0.currentbutArrow.localEulerAngles = Vector3.New(0, 0, 0)

		SetActive(uv0.cultureContainer_, false)

		if EquipConst.EQUIP_SORT.LEVEL == uv0.params_.priority then
			return
		end

		uv0.params_.priority = EquipConst.EQUIP_SORT.LEVEL

		uv0:Render()
	end)
	slot0:AddBtnListener(slot0.currentbutBtn_, nil, function ()
		uv0.currentbutArrow.localEulerAngles = not uv0.cultureContainer_.activeSelf and Vector3.New(0, 0, 180) or Vector3.New(0, 0, 0)

		SetActive(uv0.cultureContainer_, slot0)
	end)

	slot4 = slot0.sortbutBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		uv0.params_.order = uv0.selectStatus_.order == ItemConst.SORT_TYPE.DOWN and ItemConst.SORT_TYPE.UP or ItemConst.SORT_TYPE.DOWN

		uv0:Render()
	end)

	slot0.starIsOn_ = {}

	for slot4 = 1, 5 do
		slot0:AddBtnListener("panel/right/star/star" .. slot4, nil, function ()
			uv0:QuickSelectEquip(uv1, not uv0.starIsOn_[uv1])
		end)
	end

	slot0:AddBtnListenerScale(slot0.btn_decompose, nil, function ()
		if uv0.currentSelectNum_ <= 0 then
			return
		end

		slot0 = false

		for slot4, slot5 in pairs(uv0.usedEquipList_) do
			if EquipCfg[slot5.id].starlevel >= 5 then
				slot0 = true
			end
		end

		if slot0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_RESOLVE_COST_RARE"),
				OkCallback = function ()
					uv0:DecomposeEquip()
					OperationRecorder.Record("EquipDecomposeView", "confirm")
				end,
				CancelCallback = function ()
					OperationRecorder.Record("EquipDecomposeView", "cancel")
				end
			})
		else
			uv0:DecomposeEquip()
		end
	end)
end

function slot0.DecomposeEquip(slot0)
	EquipAction.EquipDecompose(slot0.usedEquipList_)
end

function slot0.OnEquipDecompose(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		EquipAction.DeleteEquip(slot0.usedEquipList_)

		for slot6, slot7 in ipairs(slot0.totalList_) do
			slot9 = slot7.number

			if ItemCfg[slot7.id].type == ItemConst.ITEM_TYPE.CURRENCY then
				CurrencyAction.CurrencyModify(slot8, slot9)
			elseif slot10 == ItemConst.ITEM_TYPE.MATERIAL then
				MaterialAction.MaterialModify(slot8, slot9)
			elseif slot10 == ItemConst.ITEM_TYPE.HERO_PIECE then
				HeroAction.HeroPieceModify(ItemCfg[slot8].hero_id, slot9)
			end
		end

		slot0:Go("reward", {
			list = slot0.totalList_
		})

		slot0.usedEquipList_ = {}

		slot0:Render()
	else
		ShowTips(slot1.result)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot1 < 0 or slot1 > #slot0.itemList_ then
		return nil
	end

	slot3 = slot0.itemList_[slot1]

	slot2:RefreshData(slot3)
	slot2:RegistCallBack(function (slot0)
		OperationRecorder.Record(uv0.class.__cname, "equip_decompose_press_item")

		if uv0.usedEquipList_[slot0.equip_id] then
			uv1:ShowSelect(0)

			uv0.usedEquipList_[slot1] = nil
		else
			uv1:ShowSelect(1)

			uv0.usedEquipList_[slot1] = slot0
		end

		uv0:RefreshRewardItem()
		uv0:RefreshQuickClick()
	end)
	slot2:ShowSelect(slot0.usedEquipList_[slot3.equip_id] and 1 or 0)

	return slot2
end

function slot0.RefreshItem(slot0)
	slot0.scrollHelper:StartScroll(#slot0.itemList_)
end

function slot0.RefreshRewardItem(slot0)
	slot0.totalList_ = uv0.GetDecomposeRewardItem(slot0.usedEquipList_)

	SetActive(slot0.rewardNull_, #slot0.totalList_ == 0)

	if slot1 > 0 then
		slot0.btnController_:SetSelectedState("select")
	else
		slot0.btnController_:SetSelectedState("ash")
	end

	slot0.decomposeBtn_.interactable = slot1 > 0

	for slot5 = 1, slot1 do
		if slot0.rewardIndex_ < slot5 then
			slot0.rewardItems_[slot5] = CommonItem.New(Object.Instantiate(slot0.item_, slot0.rewardList_))
			slot7 = slot0.rewardItems_[slot5]

			slot7:RegistCallBack(function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end)

			slot0.rewardIndex_ = slot0.rewardIndex_ + 1
		end

		slot0.rewardItems_[slot5]:RefreshData(slot0.totalList_[slot5])
	end

	for slot5, slot6 in ipairs(slot0.rewardItems_) do
		slot6:Show(slot5 <= slot1)
	end
end

function slot0.QuickSelectEquip(slot0, slot1, slot2)
	OperationRecorder.Record(slot0.class.__cname, "quick_select_star")

	slot0.starIsOn_[slot1] = slot2

	SetActive(slot0.starSelect_[slot1], slot0.starIsOn_[slot1])

	if slot2 then
		for slot7 = 1, #slot0.itemList_ do
			if slot0.itemList_[slot7].equip_star == slot1 then
				slot0.usedEquipList_[slot8.equip_id] = slot8
			end
		end
	else
		for slot6, slot7 in pairs(slot0.usedEquipList_) do
			if slot7.equip_star == slot1 then
				slot0.usedEquipList_[slot6] = nil
			end
		end
	end

	slot0:RefreshRewardItem()
	slot0:RefreshQuickClick()
	slot0:RefreshSelect()
end

function slot0.RefreshQuickClick(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.itemList_) do
		slot7 = slot6.equip_star

		if not slot0.usedEquipList_[slot6.equip_id] and slot0.starIsOn_[slot7] then
			slot0.starIsOn_[slot7] = false
		end
	end

	for slot5 = 1, 5 do
		SetActive(slot0.starSelect_[slot5], slot0.starIsOn_[slot5])
	end

	for slot5, slot6 in pairs(slot0.usedEquipList_) do
		slot1 = slot1 + 1
	end

	slot0.currentSelectNum_ = slot1
	slot0.selectNum_.text = slot1
end

function slot0.RefreshSelect(slot0)
	slot3 = slot0.scrollHelper
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:ShowSelect(slot0.usedEquipList_[slot5:GetItemInfo().equip_id] and 1 or 0)
	end
end

function slot0.InitData(slot0)
	slot0.selectStatus_ = slot0:GetSelectStatus(slot0.params_.order or ItemConst.SORT_TYPE.DOWN, slot0.params_.priority or EquipConst.EQUIP_SORT.LEVEL, slot0.params_.suitPos or 0, slot0.params_.suit or 0, slot0.params_.skill or 0)
	slot0.itemList_ = slot0:GetItemList(slot0.params_.order or ItemConst.SORT_TYPE.DOWN, slot0.params_.priority or EquipConst.EQUIP_SORT.LEVEL, slot0.params_.suitPos or 0, slot0.params_.suit or 0, slot0.params_.hideIdList or {}, slot0.params_.skill or 0)
end

function slot0.RefreshCultureContainer(slot0)
	if slot0.selectStatus_.order == ItemConst.SORT_TYPE.DOWN then
		SetActive(slot0.sortbutUpper, false)
		SetActive(slot0.sortbutLower, true)
	else
		SetActive(slot0.sortbutUpper, true)
		SetActive(slot0.sortbutLower, false)
	end

	if slot0.selectStatus_.priority == EquipConst.EQUIP_SORT.LEVEL then
		SetActive(slot0.culturetbutSelect, true)
		SetActive(slot0.starbutSelect, false)

		slot0.currentbutText.text = GetTips("TIP_UPGRADE")
	else
		SetActive(slot0.culturetbutSelect, false)
		SetActive(slot0.starbutSelect, true)

		slot0.currentbutText.text = GetTips("TIP_RARE")
	end
end

function slot0.Render(slot0)
	slot0:InitData()
	slot0:RefreshItem()
	slot0:RefreshRewardItem()
	slot0:RefreshQuickClick()
	slot0:RefreshCultureContainer()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	slot0.usedEquipList_ = {}
	slot0.starIsOn_ = {}
	slot0.currentbutArrow.localEulerAngles = Vector3.New(0, 0, 0)

	SetActive(slot0.cultureContainer_, false)
	slot0:Render()
end

function slot0.GetItemList(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = EquipData:GetEquipListComplex(slot1, slot2, slot3, slot4, slot6)

	if slot5 then
		for slot11 = #slot7, 1, -1 do
			if table.keyof(slot5, slot7[slot11]) then
				table.remove(slot7, slot11)
			end
		end
	end

	slot8 = uv0.GetEquipMap(HeroData:GetHeroList())
	slot9 = ProposalData:GetEquipMap()

	for slot13 = #slot7, 1, -1 do
		if slot8[slot7[slot13]] then
			table.remove(slot7, slot13)
		end
	end

	slot10 = {}

	for slot14, slot15 in ipairs(slot7) do
		slot16 = EquipData:GetEquipData(slot15)
		slot17 = {
			isEquiped = false,
			number = 1,
			type = ItemConst.ITEM_TYPE.EQUIP,
			id = slot16.prefab_id,
			equip_id = slot16.equip_id,
			equip_info = slot16,
			equip_star = getItemStar(slot16.prefab_id),
			equip_lv = uv1.CountEquipLevel(slot16)
		}

		if not slot16.is_lock and not slot9[slot16.equip_id] then
			table.insert(slot10, slot17)
		end
	end

	return slot10 or {}
end

function slot0.GetSelectStatus(slot0, slot1, slot2, slot3, slot4, slot5)
	return {
		order = slot1,
		priority = slot2,
		suitPos = slot3,
		suit = slot4,
		skill = slot5
	}
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.toggle_ then
		for slot4, slot5 in pairs(slot0.toggle_) do
			slot5.onValueChanged:RemoveAllListeners()
		end

		slot0.toggle_ = nil
	end

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
