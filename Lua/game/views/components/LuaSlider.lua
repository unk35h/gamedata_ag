slot0 = class("LuaSlider", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:Reset()
end

function slot0.Reset(slot0)
	slot0.useNumSlider_.value = 1
	slot0.selectNum_ = 1
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.inputTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "inputType")
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	slot0.inputField_ = slot0.numInputGo_:GetComponent("Input")
end

function slot0.AddUIListener(slot0)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0:GetMaxBuyNum() then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:RefreshNum()
			uv0:UpdateSliderPosition()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:RefreshNum()
			uv0:UpdateSliderPosition()

			return true
		end

		return false
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.selectNum_ = uv0.useNumSlider_.value

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		elseif uv0:GetMaxBuyNum() < uv0.selectNum_ then
			uv0.selectNum_ = uv0:GetMaxBuyNum()
		end

		uv0:RefreshNum()
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:RefreshNum()
		uv0:UpdateSliderPosition()
		OperationRecorder.Record("shop", "shop_number_slide")
	end))
end

function slot0.SetNumChangeHandler(slot0, slot1)
	slot0.numChangeHandler_ = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	if slot2 < slot1 then
		slot2 = slot1
	end

	slot0.min_ = slot1
	slot0.max_ = slot2
	slot0.useNumSlider_.minValue = slot1
	slot0.useNumSlider_.maxValue = slot2

	slot0:UpdateSliderPosition()
	slot0:RefreshNum()
	slot0:UpdateSliderPositionBySelectNum()
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.RefreshNum(slot0)
	if slot0:GetMaxBuyNum() <= slot0.selectNum_ then
		slot0:SetBtnEnable(slot0.addBtn_, false)
	else
		slot0:SetBtnEnable(slot0.addBtn_, true)
	end

	if slot0.selectNum_ <= 1 then
		slot0:SetBtnEnable(slot0.delBtn_, false)
	else
		slot0:SetBtnEnable(slot0.delBtn_, true)
	end

	if slot1 == 1 then
		slot0.useNumSlider_.minValue = 0
	else
		slot0.useNumSlider_.minValue = 1
	end

	if slot0.numChangeHandler_ ~= nil then
		slot0.numChangeHandler_(slot0.selectNum_)
	end
end

function slot0.UpdateSliderPosition(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_
end

function slot0.GetMaxBuyNum(slot0)
	return slot0.max_
end

function slot0.AddEventListeners(slot0)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.GetSelectedNum(slot0)
	return slot0.selectNum_
end

function slot0.SetBtnEnable(slot0, slot1, slot2)
	slot1.interactable = slot2
end

function slot0.Dispose(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	uv0.super.Dispose(slot0)
	ReduxFactory.GetInstance():OnManagedObjDisposed(slot0)
end

return slot0
