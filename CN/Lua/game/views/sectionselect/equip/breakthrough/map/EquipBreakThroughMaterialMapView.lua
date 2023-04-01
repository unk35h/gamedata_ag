slot0 = class("EquipBreakThroughMaterialMapView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipBreakThroughMaterialMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)
	slot0.itemList_ = {}
	slot0.lineList_ = {}
	slot0.affixItemList_ = {}
	slot0.updateHandler_ = handler(slot0, slot0.UpdateBreakThroughData)
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshUI)
	slot0.refreshItemHandler_ = handler(slot0, slot0.RefreshItem)
	slot0.showController_ = ControllerUtil.GetController(slot0.transform_, "show")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_BREAK_THROUGH_INFO")
	EquipBreakThroughMaterialAction.CheckTimeout()
	slot0:RefreshUI()
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, slot0.refreshHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, slot0.refreshItemHandler_)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD)
end

function slot0.OnTop(slot0)
	slot4 = {
		BACK_BAR,
		HOME_BAR,
		slot5
	}
	slot5 = INFO_BAR

	manager.windowBar:SwitchBar(slot4)

	slot0.selectMapStageID_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnTop()
	end

	SetActive(slot0.difficultyPanel_, true)
end

function slot0.OnUpdate(slot0)
	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnBehind()
	end

	if slot0:IsOpenSectionInfo() then
		slot0:RefreshScroll()
	else
		slot0.scrollView_.enabled = true
	end
end

function slot0.OnBehind(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(slot0.difficultyPanel_, false)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE, slot0.refreshHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE, slot0.refreshItemHandler_)

	slot4 = slot0.rewardBtn_.transform
	slot5 = RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL_REWARD

	manager.redPoint:unbindUIandKey(slot4, slot5)

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0.scrollMoveView_:OnExit()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
	slot0.updateHandler_ = nil
	slot0.refreshHandler_ = nil
	slot0.refreshItemHandler_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Dispose()
	end

	slot0.lineList_ = nil

	for slot4, slot5 in pairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("EQUIP_BREAK_THROUGH_RESET_MAP"),
			OkCallback = function ()
				EquipBreakThroughMaterialAction.ResetMap(function (slot0)
					if isSuccess(slot0.result) then
						ShowTips("ASTROLABE_RESET")
						uv0:RefreshUI()
					end
				end)
			end
		})
	end)
	slot0:AddBtnListener(slot0.difficultyBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()
			uv0:RefreshScroll()

			return
		end

		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			uv0:Go("equipBreakThroughMaterialMode")
		end
	end)
	slot0:AddBtnListener(slot0.teamInfoBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()
			uv0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.TEAM
		})
	end)
	slot0:AddBtnListener(slot0.buffInfoBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()
			uv0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialMapInfo", {
			toggleType = EquipBreakThroughMaterialConst.TOGGLE_TYPE.BUFF
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()
			uv0:RefreshScroll()

			return
		end

		JumpTools.OpenPageByJump("equipBreakThroughMaterialTask", {})
	end)
end

function slot0.UpdateBreakThroughData(slot0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDifficultyBtn()

	slot0.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	slot0:RefreshItem()
	slot0:CreateLineItemList()
	slot0:RefreshAffix()
	slot0:RefreshScroll()
	slot0:RefreshButton()
end

function slot0.RefreshScroll(slot0)
	slot0.selectMapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()

	if slot0.selectMapStageID_ == nil then
		slot1 = EquipBreakThroughMaterialData:GetFinishStageList()

		if slot1[#slot1] == nil then
			slot2 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()][1]
		end

		slot0.selectMapStageID_ = slot2
	end

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(), slot0:GetScrollWidth())
end

function slot0.RefreshDifficultyBtn(slot0)
	slot0.difficultyText_.text = EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialData:GetSelectModeID()].name
	slot0.difficultyBtn_.interactable = table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0
	slot0.difficultyImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", slot1))
end

function slot0.RefreshItem(slot0)
	for slot6, slot7 in ipairs(EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]) do
		slot0.itemList_[slot6] = slot0.itemList_[slot6] or EquipBreakThroughMaterialMapItem.New(slot0.item_, slot0.itemParent_)

		slot0.itemList_[slot6]:SetData(slot7)
	end

	for slot6 = #slot0.itemList_, #slot2 + 1, -1 do
		slot0.itemList_[slot6]:Dispose()

		slot0.itemList_[slot6] = nil
	end
end

function slot0.RefreshButton(slot0)
	if table.length(EquipBreakThroughMaterialData:GetFinishStageList()) > 0 then
		slot0.showController_:SetSelectedState("true")
	else
		slot0.showController_:SetSelectedState("false")
	end
end

function slot0.RefreshAffix(slot0)
	for slot5, slot6 in ipairs(EquipBreakThroughMaterialData:GetGlobalAffixList()) do
		if slot0.affixItemList_[slot5] then
			slot0.affixItemList_[slot5]:SetData(slot6)
		else
			slot0.affixItemList_[slot5] = AffixItemView.New(slot0.affixItem_, slot0.affixPanel_, slot6)
		end
	end

	for slot5 = #slot0.affixItemList_, #slot1 + 1, -1 do
		slot0.affixItemList_[slot5]:Show(false)
	end
end

function slot0.GetScrollWidth(slot0)
	slot2 = EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]

	return EquipBreakThroughMaterialStagePositionCfg[0].row_position * EquipBreakThroughMaterialMapCfg[slot2[#slot2]].col
end

function slot0.GetScrollPos(slot0)
	return EquipBreakThroughMaterialMapCfg[slot0.selectMapStageID_].col * EquipBreakThroughMaterialStagePositionCfg[0].row_position
end

function slot0.CreateLineItemList(slot0)
	for slot4, slot5 in pairs(slot0.lineList_) do
		slot5:Show(false)
	end

	slot1 = 1

	for slot7, slot8 in pairs(EquipBreakThroughMaterialMapCfg.get_id_list_by_map_id[EquipBreakThroughMaterialData:GetMapID()]) do
		slot13 = 10
		slot14 = 0
		slot9 = slot0.itemList_[slot7]:GetLocalPosition() + Vector3(50, slot13, slot14)

		for slot13, slot14 in ipairs(EquipBreakThroughMaterialMapCfg[slot8].next_id_list) do
			slot0.lineList_[slot1] = slot0.lineList_[slot1] or EquipBreakThroughMaterialLine.New(slot0.lineGo_, slot0.itemParent_, slot0.pointGo_)

			slot0.lineList_[slot1]:Show(true)
			slot0.lineList_[slot1]:RefreshUI(slot9, slot0.itemList_[table.keyof(slot3, slot14)]:GetLocalPosition() + Vector3(-50, 10, 0))

			slot1 = slot1 + 1
		end
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("equipBreakThroughMaterialStageInfo")
end

return slot0
