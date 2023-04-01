slot0 = class("MartixTerminalTalentView", ReduxView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/Matrix/Terminal/MatrixTerminalTalentMiniUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.giftDataList = {}

	for slot4, slot5 in ipairs(MatrixTerminalGiftCfg.get_id_list_by_group) do
		slot0.giftDataList[slot4] = MatrixTools.GetGiftListByGroup(slot4)
	end

	slot5 = MatrixTerminalGroupItem
	slot0.terminalList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_termianlList, slot5)
	slot0.toggles_ = {}

	for slot5 = 1, slot0.m_switchContainer.childCount do
		table.insert(slot0.toggles_, slot0.m_switchContainer:GetChild(slot5 - 1):GetComponent(typeof(Toggle)))
	end

	slot0.showRightInfoCnotroller_ = ControllerUtil.GetController(slot0.transform_, "showRightInfo")
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SelectGroup(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.m_levelBtn, nil, function ()
		JumpTools.OpenPageByJump("matrixTerminalLevel")
	end)

	slot1 = slot0.m_scrollEvent

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:OnItemClick(0)
	end))
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		uv0:OnItemClick(0)
	end)
end

function slot0.OnTop(slot0)
	slot1 = manager.windowBar

	slot1:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})

	slot1 = manager.windowBar

	slot1:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)

	slot1 = manager.windowBar

	slot1:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)

	slot1 = manager.windowBar

	slot1:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function slot0.OnEnter(slot0)
	slot0.data = clone(MatrixData:GetCurrentTerminalGifi())
	slot0.allPoint = 0
	slot0.allPoint = MatrixTerminalLevelCfg[MatrixData:GetTerminalLevel()].point
	slot0.hasPoint = slot0.allPoint - slot0:GetUsePoint()
	slot0.m_giftLab.text = slot0.hasPoint
	slot0.toggles_[1].isOn = true

	slot0:SelectGroup(1)

	slot2 = MatrixData:GetTerminalLevel()
	slot3 = MatrixData:GetTerminalExp()
	slot0.m_levelLab.text = "" .. slot2

	if slot2 == #MatrixTerminalLevelCfg.all then
		slot4 = MatrixTerminalLevelCfg[slot2].exp - MatrixTerminalLevelCfg[slot2 - 1].exp
		slot0.m_expSlider.value = 1
		slot0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", slot4, slot4)
	else
		slot4 = MatrixTerminalLevelCfg[slot2 + 1].exp - MatrixTerminalLevelCfg[slot2].exp
		slot0.m_expSlider.value = slot3 / slot4
		slot0.m_expLab.text = string.format("<color=#FF9500>%d</color>/%d", slot3, slot4)
	end
end

function slot0.OnExit(slot0)
	slot0.curPage = nil

	slot0:OnItemClick(0)
end

function slot0.RefreshInfo(slot0)
	slot1 = slot0.data[slot0.curId] or 0
	slot2 = MatrixTerminalGiftCfg[slot0.curId]
	slot3 = slot0.data[slot0.curId] or 0
	slot0.m_infoNameLab.text = slot2.name
	slot4 = slot3 == 0 and 1 or slot3
	slot5 = slot3 + 1
	slot0.m_infoLvLab.text = slot4
	slot0.m_infoDesLab.text = MatrixDescCfg[slot2.desc_list[slot4]] and MatrixDescCfg[slot6].desc or ""
	slot0.m_infoIconImg.sprite = getSpriteWithoutAtlas("Textures/MatrixItem/MatrixTerminal/" .. slot2.icon)
end

function slot0.OnItemClick(slot0, slot1, slot2)
	if slot1 == 0 and slot0.selectId == slot1 then
		return
	end

	slot0.selectId = slot1
	slot3 = false

	if slot1 ~= 0 then
		slot0.showRightInfoCnotroller_:SetSelectedIndex(1)

		slot0.curId = slot1

		slot0:RefreshInfo(slot1)

		slot3 = true
	else
		slot0.showRightInfoCnotroller_:SetSelectedIndex(0)

		slot0.curId = nil
		slot3 = false
	end

	for slot8, slot9 in pairs(slot0.terminalList_:GetItemList()) do
		slot9:SetChoice(slot0.selectId)
		slot9:SetItemScrollMask(slot3)
	end

	slot0:SetSelect(slot2)
end

function slot0.SelectGroup(slot0, slot1)
	slot0:OnItemClick(0)

	if slot1 == slot0.curPage then
		return
	end

	slot0.curPage = slot1
	slot0.list = slot0.giftDataList[slot1] or {}

	slot0.terminalList_:StartScrollByPosition(#slot0.list, Vector2.New(0, 0))
end

function slot0.SetSelect(slot0, slot1)
	if slot1 then
		slot2 = slot1.transform_.parent
		slot4 = slot0.m_scrollContent.transform
		slot0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

		slot0:RemoveTween()

		slot6 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, -slot4:InverseTransformPoint(slot2:TransformPoint(Vector3(0, 0, 0))).x + 100, 0.2)
		slot0.tween_ = slot6:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot1, slot0.list[slot1], slot0.data, slot0.selectId, slot0.hasPoint)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
end

function slot0.GetUsePoint(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.data) do
		slot7 = MatrixTerminalGiftCfg[slot5]

		for slot11 = 1, slot6 do
			slot1 = slot1 + slot7.cost[slot11]
		end
	end

	return slot1
end

function slot0.Dispose(slot0)
	slot0.terminalList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
