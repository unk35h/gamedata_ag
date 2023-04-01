slot0 = require("cjson")
slot1 = class("BattleUIAdjustView", ReduxView)

function slot1.UIName(slot0)
	return "UI/Setting/BattlePanelSetting"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.adapter_ = slot0:FindCom("BattleUIAdapter", "")
	slot0.targets_ = {}
	slot0.trans_ = {}
	slot4 = "conName"
	slot0.panelController_ = ControllerUtil.GetController(slot0.panelGo_.transform, slot4)

	for slot4 = 0, slot0.adapter_.listToChange.Count - 1 do
		table.insert(slot0.targets_, slot0:FindCom(typeof(Image), slot0.adapter_.listToChange[slot4]))
		table.insert(slot0.trans_, slot0:FindCom(typeof(RectTransform), slot0.adapter_.listToChange[slot4]))
	end

	slot0.canvasGroupList_ = {}

	for slot4 = 0, slot0.adapter_.m_alphaList.Count - 1 do
		table.insert(slot0.canvasGroupList_, slot0:FindCom(typeof(CanvasGroup), slot0.adapter_.m_alphaList[slot4]))
	end

	slot0.typeTgls_ = {
		slot0.type0Btn_,
		slot0.type1Btn_,
		slot0.type2Btn_,
		slot0.type3Btn_
	}
end

function slot1.OnEnter(slot0)
	slot0:AdaptScreen()

	slot0.settingData_ = SettingData:GetBattleUISettingData()
	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
	slot0.currentIndex_ = 0

	if slot0.tmpSettingData_.battle_ui_cur_type == slot0.tmpSettingData_.battle_ui_type_0 then
		slot0.currentIndex_ = 0
	elseif slot0.tmpSettingData_.battle_ui_cur_type == slot0.tmpSettingData_.battle_ui_type_1 then
		slot0.currentIndex_ = 1
	elseif slot0.tmpSettingData_.battle_ui_cur_type == slot0.tmpSettingData_.battle_ui_type_2 then
		slot0.currentIndex_ = 2
	elseif slot0.tmpSettingData_.battle_ui_cur_type == slot0.tmpSettingData_.battle_ui_type_3 then
		slot0.currentIndex_ = 3
	end

	slot0:UpdateSelectTrans(slot0.targets_[1])
	slot0:UpdateIndex(slot0.currentIndex_)

	slot0.isDirty_ = false

	if manager.windowBar:GetIsShow() then
		slot0.barList_ = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	end

	slot0.typeTgls_[slot0.currentIndex_ + 1].isOn = true
end

function slot1.OnExit(slot0)
	if slot0.barList_ then
		manager.windowBar:SwitchBar(slot0.barList_)
	end
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.sizeSlr_.onValueChanged:RemoveAllListeners()
	slot0.alphaSlider_.onValueChanged:RemoveAllListeners()
	slot0.rotateSpeedSlider_.onValueChanged:RemoveAllListeners()
end

function slot1.UpdateSelectTrans(slot0, slot1)
	if slot0.selectTarget_ then
		slot0.selectTarget_.color = Color.white
	end

	slot0.selectTarget_ = slot1
	slot0.selectTarget_.color = Color.green
	slot0.sizeSlr_.value = slot0.selectTarget_.transform.localScale.x - 0.5
end

function slot1.UpdateIndex(slot0, slot1)
	slot0.currentIndex_ = slot1
	slot0.tmpSettingData_.battle_ui_cur_type = slot0.tmpSettingData_["battle_ui_type_" .. slot1]
	slot0.tmpSettingData_.battle_ui_cur_alpha_value = slot0.tmpSettingData_["battle_ui_type_" .. slot1]
	slot2 = tonumber(slot0.tmpSettingData_["battle_ui_alpha_" .. slot1])

	slot0.adapter_:ResetToDefault()
	slot0.adapter_:Set(slot0.tmpSettingData_.battle_ui_cur_type, slot2)

	slot0.sizeSlr_.value = slot0.selectTarget_.transform.localScale.x - 0.5
	slot0.alphaSlider_.value = 1 - slot2
	slot0.tmpSettingData_.battle_ui_cur_rotate_speed = slot0.tmpSettingData_["battle_ui_rotate_speed_" .. slot1]
	slot0.rotateSpeedSlider_.value = tonumber(slot0.tmpSettingData_["battle_ui_rotate_speed_" .. slot1])
end

function slot1.ApplyData(slot0)
	slot0.tmpSettingData_.battle_ui_cur_type = slot0.adapter_:Save()
	slot0.tmpSettingData_.battle_ui_cur_alpha_value = 1 - slot0.alphaSlider_.value
	slot0.tmpSettingData_.battle_ui_cur_rotate_speed = slot0.rotateSpeedSlider_.value

	if slot0.currentIndex_ < 0 or slot0.currentIndex_ > 3 then
		return
	end

	slot1 = {}
	slot2 = nil

	for slot7 = 0, slot0.adapter_:DecodeData(slot0.tmpSettingData_.battle_ui_cur_type).datas.Count - 1 do
		slot8 = slot3.datas[slot7]

		table.insert(slot1, {
			slot8.path,
			slot8.offest.x,
			slot8.offest.y,
			slot8.scale
		})
	end

	print(slot3)
	SDKTools.SendMessageToSDK("diy_battle_setting", {
		diy_battle = uv0.encode(slot1)
	})

	slot0.tmpSettingData_["battle_ui_type_" .. slot0.currentIndex_] = slot0.tmpSettingData_.battle_ui_cur_type
	slot0.tmpSettingData_["battle_ui_alpha_" .. slot0.currentIndex_] = slot0.tmpSettingData_.battle_ui_cur_alpha_value
	slot0.tmpSettingData_["battle_ui_rotate_speed_" .. slot0.currentIndex_] = slot0.tmpSettingData_.battle_ui_cur_rotate_speed
end

function slot1.SaveFunc(slot0)
	slot0:ApplyData()

	slot0.settingData_ = deepClone(slot0.tmpSettingData_)

	SettingData:ModifyBattleUISetting("allData", slot0.settingData_)

	slot0.isDirty_ = false

	ShowTips("SAVE_SYSTEM_SETTING")
end

function slot1.BackFunc(slot0)
	slot1 = false

	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		slot1 = true
	end

	if slot1 or slot0.isDirty_ then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SETTING_CHANGE"),
			OkCallback = function ()
				uv0:SaveFunc()
				OperationRecorder.Record(uv0.class.__cname, "panel/btn_save")
				uv0:Back()
			end,
			CancelCallback = function ()
				OperationRecorder.Record(uv0.class.__cname, "cancel")
				uv0:Back()
			end
		})
	else
		slot0:Back()
	end
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.returnBtn_, nil, function ()
		uv0:BackFunc()
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		uv0.adapter_:ResetToDefault()

		uv0.sizeSlr_.value = uv0.selectTarget_.transform.localScale.x - 0.5
		uv0.alphaSlider_.value = 0
		uv0.rotateSpeedSlider_.value = 0.5
		uv0.isDirty_ = true

		uv0:ValidCheck()
	end)

	slot4 = slot0.saveBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0:SaveFunc()
	end)

	for slot4, slot5 in ipairs(slot0.typeTgls_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if uv0.currentIndex_ == uv1 - 1 then
				return
			end

			uv0:ApplyData()
			uv0:UpdateIndex(uv1 - 1)
			uv0:ValidCheck()
		end)
	end

	slot0.sizeSlr_.onValueChanged:AddListener(function ()
		if uv0.selectTarget_ then
			slot0 = uv0.sizeSlr_.value + 0.5
			uv0.selectTarget_.transform.localScale = Vector3.New(slot0, slot0, slot0)
		end

		uv0.isDirty_ = true

		uv0:ValidCheck()
	end)
	slot0.alphaSlider_.onValueChanged:AddListener(function ()
		slot0 = uv0.alphaSlider_.value

		for slot4, slot5 in pairs(uv0.canvasGroupList_) do
			slot5.alpha = 1 - slot0
		end

		uv0.isDirty_ = true

		uv0:ValidCheck()
	end)

	function slot4()
		uv0.isDirty_ = true
	end

	slot0.rotateSpeedSlider_.onValueChanged:AddListener(slot4)

	for slot4, slot5 in pairs(slot0.targets_) do
		slot6 = slot0:GetOrAddComponent(slot5.gameObject, typeof(EventTriggerListener))

		slot6:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function ()
			uv0.isDirty_ = true

			uv0:UpdateSelectTrans(uv1)
			uv0:ValidCheck()
		end))
	end

	slot0:AddBtnListener(slot0.zoombtnBtn_, nil, function ()
		uv0.panelController_:SetSelectedState(uv0.panelController_:GetSelectedState() == "1" and "0" or "1")
	end)
end

function slot1.GetScreenRect(slot0, slot1)
	slot2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	if slot0.corners == nil then
		slot0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	slot1:GetWorldCorners(slot0.corners)

	slot3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[0])

	return UnityEngine.Rect.New(slot3, UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[2]) - slot3)
end

function slot1.Overlap(slot0, slot1, slot2)
	return slot0:GetScreenRect(slot1):Overlaps(slot0:GetScreenRect(slot2))
end

function slot1.ValidCheck(slot0)
	if slot0.invalidList_ then
		for slot4, slot5 in ipairs(slot0.invalidList_) do
			if slot0.selectTarget_ == slot0.targets_[slot5] then
				slot0.targets_[slot5].color = Color.green
			else
				slot0.targets_[slot5].color = Color.white
			end
		end
	end

	slot0.invalidList_ = {}

	for slot4, slot5 in ipairs(slot0.trans_) do
		for slot9, slot10 in ipairs(slot0.trans_) do
			if slot5 ~= slot10 and slot0:Overlap(slot5, slot10) then
				table.insert(slot0.invalidList_, slot4)
				table.insert(slot0.invalidList_, slot9)
			end
		end
	end

	for slot4, slot5 in ipairs(slot0.invalidList_) do
		slot0.targets_[slot5].color = Color.red
	end
end

return slot1
