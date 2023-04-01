slot0 = class("GameGamepadOperationView", ReduxView)
slot1 = require("cjson")
slot2 = "OtherLayout"

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggleController_ = ControllerUtil.GetController(slot0.gamepadBtn_.transform, "toggle")
end

function slot0.AddUIListener(slot0)
	slot0:AddGamepadSettingListener()
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.changed_ = false
	slot0.gamepadType_ = LuaForGamepad.GetGamepadType()
	slot0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(uv0, LuaForGamepad.GetDefaultLayoutFileName(uv0))
end

function slot0.SaveData(slot0)
	slot0.changed_ = false
	slot0.gamepadType_ = LuaForGamepad.GetGamepadType()
	slot0.oldLayoutJson_ = LuaForGamepad.GetLayoutJson(uv0, LuaForGamepad.GetDefaultLayoutFileName(uv0))
end

function slot0.CheckDataChange(slot0)
	return slot0.changed_
end

function slot0.RecoverTmpData(slot0)
	LuaForGamepad.SetGamePadType(slot0.gamepadType_)
	LuaForGamepad.SaveLayoutJson(uv0, slot0.oldLayoutJson_)
	LuaForGamepad.ReloadLayout()
	slot0:RefreshGamepadSetting()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:StopGampadSetting()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.UpdatePageData(slot0)
	slot0:RefreshGamepadSetting()
end

function slot0.AddGamepadSettingListener(slot0)
	slot0:AddBtnListener(slot0.gamepadBtn_, nil, function ()
		if uv0.toggleController_:GetSelectedState() == "off" then
			uv0.toggleController_:SetSelectedState("on")
			LuaForGamepad.SetGamePadType(4)
			uv0:RefreshGamepadSetting()

			uv0.changed_ = true
		else
			uv0.toggleController_:SetSelectedState("off")
			LuaForGamepad.SetGamePadType(0)
			uv0:RefreshGamepadSetting()

			uv0.changed_ = true
		end
	end)
	slot0:AddBtnListener(slot0.gamepadMoveUpBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadMoveUpTxt_, P08.Gamepad.En_ButtonType.MoveUp:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadMoveDownBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadMoveDownTxt_, P08.Gamepad.En_ButtonType.MoveDown:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadMoveLeftBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadMoveLeftTxt_, P08.Gamepad.En_ButtonType.MoveLeft:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadMoveRightBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadMoveRightTxt_, P08.Gamepad.En_ButtonType.MoveRight:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadCameraLeftBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadCameraLeftTxt_, P08.Gamepad.En_ButtonType.CameraLeft:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadCameraRightBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadCameraRightTxt_, P08.Gamepad.En_ButtonType.CameraRight:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSubStickUpBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadSubStickUpTxt_, P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSubStickDownBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadSubStickDownTxt_, P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSubStickLeftBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadSubStickLeftTxt_, P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSubStickRightBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadSubStickRightTxt_, P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadMeleeBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadMeleeTxt_, P08.Gamepad.En_ButtonType.Melee:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSkill1Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadSkill1Txt_, P08.Gamepad.En_ButtonType.Skill1:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSkill2Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadSkill2Txt_, P08.Gamepad.En_ButtonType.Skill2:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadSkill3Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadSkill3Txt_, P08.Gamepad.En_ButtonType.Skill3:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadAvoidBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadAvoidTxt_, P08.Gamepad.En_ButtonType.Avoid:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadUltimate1Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadUltimate1Txt_, P08.Gamepad.En_ButtonType.Ultimate1:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadUltimate2Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadUltimate2Txt_, P08.Gamepad.En_ButtonType.Ultimate2:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadUltimate3Btn_, nil, function ()
		uv0:InputListener(uv0.gamepadUltimate3Txt_, P08.Gamepad.En_ButtonType.Ultimate3:ToInt())
	end)
	slot0:AddBtnListener(slot0.gamepadLockBtn_, nil, function ()
		uv0:InputListener(uv0.gamepadLockTxt_, P08.Gamepad.En_ButtonType.Lock:ToInt())
	end)
	slot0:AddToggleListener(slot0.sensitivitySlider_, function ()
		uv0:SetCameraSensitivity(uv0.sensitivitySlider_.value)
	end)
	slot0:AddPressingByTimeListener(slot0.sensitivityReduceBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.sensitivitySlider_.value > 1 then
			uv0:SetCameraSensitivity(uv0.sensitivitySlider_.value - 1)

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.sensitivityAddBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.sensitivitySlider_.value < 100 then
			uv0:SetCameraSensitivity(uv0.sensitivitySlider_.value + 1)

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("RESET_CAMERAANDKEYBOARD"),
			OkCallback = function ()
				LuaForGamepad.DeleteLayoutJson(uv0)
				LuaForGamepad.ReloadLayout()
				uv1:RefreshGamepadSetting()

				uv1.changed_ = true
			end
		})
	end)
end

function slot0.InputListener(slot0, slot1, slot2)
	if slot0.timer_ then
		return
	end

	slot0.localCnt_ = 0
	slot0.timer_ = Timer.New(function ()
		uv0.localCnt_ = uv0.localCnt_ + 1

		if uv0.localCnt_ < 10 then
			uv1.text = GetTips("INITING")

			return
		end

		uv1.text = GetTips("PLEASE_INPUT_KEY")

		if LuaForGamepad.GetInputValue() == "" then
			return
		end

		if uv0.timer_ then
			uv0.timer_:Stop()

			uv0.timer_ = nil
		end

		slot1 = uv2.decode(slot0)
		uv1.text = slot1.m_axisName

		LuaForGamepad.SetLayoutItem(uv3, LuaForGamepad.GetDefaultLayoutFileName(uv3), uv4, slot1.m_axisName)
		uv0:StopGampadSetting()
		uv0:RefreshGamepadSetting()

		uv0.changed_ = true
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.SetCameraSensitivity(slot0, slot1)
	if slot1 < 1 then
		slot1 = 1
	elseif slot1 > 100 then
		slot1 = 100
	end

	LuaForGamepad.SetCameraSensitivity(uv0, LuaForGamepad.GetDefaultLayoutFileName(uv0), slot1)
	slot0:RefreshGamepadSetting()

	slot0.changed_ = true
end

function slot0.StopGampadSetting(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	LuaForGamepad.ClearInputValue()
	LuaForGamepad.DisableListenerEnable()
end

function slot0.RefreshGamepadSetting(slot0)
	if LuaForGamepad.GetGamepadType() == 4 then
		slot0.toggleController_:SetSelectedState("on")
	else
		slot0.toggleController_:SetSelectedState("off")
	end

	if slot1 ~= 4 then
		return
	end

	if uv1.decode(LuaForGamepad.GetLayoutJson(uv0, LuaForGamepad.GetDefaultLayoutFileName(uv0))) == nil or slot3.m_buttonMapLayouts == nil then
		return
	end

	for slot7, slot8 in pairs(slot3.m_buttonMapLayouts) do
		if slot8.m_buttonType == P08.Gamepad.En_ButtonType.MoveUp:ToInt() then
			slot0.gamepadMoveUpTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.MoveDown:ToInt() then
			slot0.gamepadMoveDownTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.MoveLeft:ToInt() then
			slot0.gamepadMoveLeftTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.MoveRight:ToInt() then
			slot0.gamepadMoveRightTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.CameraLeft:ToInt() then
			slot0.gamepadCameraLeftTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.CameraRight:ToInt() then
			slot0.gamepadCameraRightTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickUp:ToInt() then
			slot0.gamepadSubStickUpTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickDown:ToInt() then
			slot0.gamepadSubStickDownTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickLeft:ToInt() then
			slot0.gamepadSubStickLeftTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.SubJoystickRight:ToInt() then
			slot0.gamepadSubStickRightTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Melee:ToInt() then
			slot0.gamepadMeleeTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Skill1:ToInt() then
			slot0.gamepadSkill1Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Skill2:ToInt() then
			slot0.gamepadSkill2Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Skill3:ToInt() then
			slot0.gamepadSkill3Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Avoid:ToInt() then
			slot0.gamepadAvoidTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate1:ToInt() then
			slot0.gamepadUltimate1Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate2:ToInt() then
			slot0.gamepadUltimate2Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Ultimate3:ToInt() then
			slot0.gamepadUltimate3Txt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		elseif slot8.m_buttonType == P08.Gamepad.En_ButtonType.Lock:ToInt() then
			slot0.gamepadLockTxt_.text = LuaForGamepad.ConvertName(slot8.m_value)
		end
	end

	slot4 = LuaForGamepad.GetCameraSensitivity()
	slot0.sensitivitySlider_.value = slot4
	slot0.sensitivityTxt_.text = slot4
end

return slot0
