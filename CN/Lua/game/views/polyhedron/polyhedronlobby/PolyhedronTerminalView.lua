slot0 = class("PolyhedronTerminalView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/Terminal/PolyhedronTalentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot1 = handler(slot0, slot0.OnItemClick)
	slot0.itemList = {}

	for slot5, slot6 in ipairs(PolyhedronTerminalCfg.all) do
		slot8 = PolyhedronTerminalItem.New(slot0.m_tablentContent:Find(slot6), slot6)

		slot8:RegistCallBack(slot1)
		table.insert(slot0.itemList, slot8)
	end

	slot0.lineList = {}

	for slot6 = 0, slot0.m_lineContent.childCount - 1 do
		slot7 = slot0.m_lineContent:GetChild(slot6).gameObject

		table.insert(slot0.lineList, PolyhedronTerminalLine.New(slot7, slot7.name))
	end

	slot0.showTipContorller = ControllerUtil.GetController(slot0.transform_, "showTip")
	slot0.infoController_ = ControllerUtil.GetController(slot0.m_infoTrans, "state")
	slot0.selectId = 0
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		uv0:OnItemClick(0)
	end)

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:OnItemClick(0)
	end))
	slot0:AddBtnListener(slot0.m_resetBtn, nil, function ()
		if #uv0.data == 0 then
			return
		end

		slot3 = PolyhedronData

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("POLYHEDRON_RESET_TERMINAL_GIFT"),
			SecondTip = GetTips("WEEK_RESET_TIME"),
			SecondValue = slot3:GetResetTimes(),
			OkCallback = function ()
				if PolyhedronData:GetResetTimes() > 0 then
					PolyhedronAction.ResetTerminal()
				else
					ShowTips(GetTips("MATRIX_TERMINAL_NO_REFRESH_TIMES"))
				end
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_levelBtn, nil, function ()
		JumpTools.OpenPageByJump("polyhedronTerminalLevel")
	end)
	slot0:AddBtnListener(slot0.m_infoUnlockBtn, nil, function ()
		if uv0.selectId == 0 then
			return
		end

		uv0:UnlockTerminal(uv0.selectId)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.m_content.localPosition = Vector3(0, -127, 0)
	slot0.data = clone(PolyhedronData:GetTerminalGift())
	slot0.data_bak = clone(slot0.data)
	slot0.allPoint = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point
	slot2 = PolyhedronData:GetTerminalLevel()
	slot3 = PolyhedronData:GetTerminalExp()
	slot0.m_levelLab.text = "" .. slot2

	if slot2 == #PolyhedronTerminalLevelCfg.all then
		slot0.m_expSlider.value = 1
	else
		slot0.m_expSlider.value = slot3 / (PolyhedronTerminalLevelCfg[slot2 + 1].exp - PolyhedronTerminalLevelCfg[slot2].exp)
	end

	slot0:RegistEventListener(POLYHEDRON_TERMINAL_RESET, function ()
		uv0.data = {}

		uv0:RefreshUI()
	end)
	slot0:RefreshUI()
end

function slot0.OnPolyhedronGameUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.GetUsePoint(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.data) do
		slot1 = slot1 + PolyhedronTerminalCfg[slot6].cost
	end

	return slot1
end

function slot0.IsEqual(slot0)
	for slot4, slot5 in pairs(slot0.data) do
		if not table.indexof(slot0.data_bak, slot5) then
			return false
		end
	end

	return true
end

function slot0.OnExit(slot0)
	if not slot0:IsEqual() then
		PolyhedronAction.QuerySetTerminal(slot0.data)
	end

	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:OnItemClick(0)
end

function slot0.UnlockTerminal(slot0, slot1)
	if table.indexof(slot0.data, slot1) then
		slot0:RefreshUI()

		return
	end

	if PolyhedronTerminalCfg[slot1].cost > slot0.allPoint - slot0:GetUsePoint() then
		ShowTips(GetTips("POLYHEDRON_TERMINAL_LACK_POINT"))

		return
	end

	ShowTips(GetTips("POLYHEDRON_TERMINAL_UNLOCK_SUCCESS"))
	table.insert(slot0.data, slot1)
	slot0:RefreshUI()
end

function slot0.OnItemClick(slot0, slot1, slot2)
	if slot1 ~= 0 then
		slot0.showTipContorller:SetSelectedIndex(1)
	else
		slot0.showTipContorller:SetSelectedIndex(0)
	end

	if slot1 == 0 and slot0.selectId == slot1 then
		return
	end

	slot0.selectId = slot1

	if slot2 then
		slot5 = slot0.m_scrollContent.transform:InverseTransformPoint(slot2.transform_:TransformPoint(Vector3(0, 0, 0)))
		slot0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		slot0:RemoveTween()

		slot0.tween_ = LeanTween.moveLocal(slot0.m_scrollContent.gameObject, Vector3.New(-slot5.x, -slot5.y, 0), 0.2)
	else
		slot0:RemoveTween()

		slot0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.m_resetTimeLabel_.text = PolyhedronData:GetResetTimes()

	if #slot0.data == 0 then
		-- Nothing
	end

	slot0.m_pointLab.text = slot0.allPoint - slot0:GetUsePoint()

	for slot5, slot6 in ipairs(slot0.itemList) do
		slot6:SetChoice(slot6:GetId() == slot0.selectId)

		slot8 = 0

		slot6:SetData(slot0.data, table.indexof(slot0.data, slot7) and 0 or slot1 < PolyhedronTerminalCfg[slot7].cost and 3 or slot0:GetCanUnlock(slot7) and 1 or 2)
	end

	for slot5, slot6 in ipairs(slot0.lineList) do
		slot6:SetData(slot0.data)
	end

	if slot0.selectId == 0 then
		return
	end

	slot2 = PolyhedronTerminalCfg[slot0.selectId]
	slot0.m_infoIconImg.sprite = getSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. slot2.icon)
	slot0.m_infoNameLab.text = slot2.name
	slot0.m_infoCostLab.text = slot2.cost
	slot0.m_infoDesLab.text = slot2.desc
	slot5, slot6 = slot0:GetCanUnlock(slot0.selectId)

	if not slot5 then
		slot0.m_infoLimitTip.text = slot6

		slot0.infoController_:SetSelectedIndex(2)

		return
	end

	if table.indexof(slot0.data, slot0.selectId) then
		slot0.infoController_:SetSelectedIndex(3)
	else
		slot0.infoController_:SetSelectedIndex(0)
	end
end

function slot0.GetCanUnlock(slot0, slot1)
	if PolyhedronData:GetTerminalLevel() < PolyhedronTerminalCfg[slot1].need_level then
		return false, string.format(GetTips("POLYHEDRON_TERMINAL_LEVEL_UNLOCK"), slot3)
	end

	slot6 = 0

	for slot10, slot11 in ipairs(slot2.pre_id_list) do
		if slot11 == 0 or table.indexof(slot0.data, slot11) then
			return true, ""
		else
			slot6 = slot11
		end
	end

	slot7 = PolyhedronTerminalCfg[slot6]

	return false, GetTips("POLYHEDRON_TERMINAL_GIFT_UNLCOK")
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.OnPolyhedronGameUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	slot0.itemList = {}

	for slot4, slot5 in ipairs(slot0.lineList) do
		slot5:Dispose()
	end

	slot0.lineList = {}

	uv0.super.Dispose(slot0)
end

return slot0
