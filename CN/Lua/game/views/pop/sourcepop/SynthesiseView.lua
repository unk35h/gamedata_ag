slot0 = class("SynthesiseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/SynthesiseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem1_ = CommonItem.New(slot0.commonItemGo1_)
	slot0.commonItem2_ = CommonItem.New(slot0.commonItemGo2_)
	slot0.useNumTriggerListener_ = slot0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		slot1 = 0

		if MaterialData:GetMaterial(uv0.sourceId_) then
			slot1 = slot0.num
		end

		if uv0.haveNum_ < uv0.mergeCfg_.cost[1][2] * uv0.selectNum_ then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		MaterialAction.MergeItem(uv0.targetId_, uv0.selectNum_)
	end)

	slot1 = slot0.useNumSlider_.onValueChanged

	slot1:AddListener(function ()
		uv0.selectNum_ = math.floor(uv0.canUseMaxNum_ * uv0.useNumSlider_.value + 1e-05)

		if uv0.selectNum_ < 1 then
			uv0.selectNum_ = 1

			uv0:UpdateSliderPositionBySelectNum()
		end

		uv0:UpdateDelAddBtn()
		uv0:UpdateNum()
	end)

	slot1 = slot0.useNumTriggerListener_

	slot1:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:FormatSliderPosition()
		uv0:UpdateDelAddBtn()
		uv0:UpdateNum()
		OperationRecorder.Record("bag", "mergeDrag")
	end))
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ > 1 then
			uv0.selectNum_ = uv0.selectNum_ - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdateNum()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum_ < uv0.canUseMaxNum_ then
			uv0.selectNum_ = uv0.selectNum_ + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()

			return true
		end

		return false
	end)
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum_ / slot0.canUseMaxNum_
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.okBtn_.enabled = slot0.selectNum_ >= 1
	slot0.delBtn_.interactable = slot0.selectNum_ > 1
	slot0.addBtn_.interactable = slot0.selectNum_ < slot0.canUseMaxNum_
end

function slot0.FormatSliderPosition(slot0)
	slot0.useNumSlider_.value = math.floor(slot0.canUseMaxNum_ * slot0.useNumSlider_.value + 1e-05) / slot0.canUseMaxNum_
end

function slot0.InitData(slot0)
	slot0.sourceId_ = slot0.params_.id
	slot0.targetId_ = ItemMergeCfg.get_id_list_by_sourceId[slot0.sourceId_][1]
	slot0.mergeCfg_ = ItemMergeCfg[slot0.targetId_]
	slot0.costNum_ = slot0.mergeCfg_.cost[1][2]
	slot0.sourceCfg_ = ItemCfg[slot0.sourceId_]
	slot0.targetCfg_ = ItemCfg[slot0.targetId_]
	slot2 = 0

	if MaterialData:GetMaterial(slot0.sourceId_) then
		slot2 = slot1.num
	end

	slot0.haveNum_ = slot2

	if math.floor(slot2 / slot0.costNum_) < 1 then
		slot3 = 1
	end

	slot0.canUseMaxNum_ = slot3
	slot0.selectNum_ = 1
end

function slot0.UpdateView(slot0)
	slot0.commonItem1_:RefreshData({
		id = slot0.sourceId_,
		number = slot0.costNum_
	})

	slot2 = 0

	if MaterialData:GetMaterial(slot0.sourceId_) then
		slot2 = slot1.num
	end

	slot3 = tostring(slot2)

	if slot2 < slot0.costNum_ then
		slot3 = "<color='#FF0000'>" .. slot3 .. "</color>"
	end

	slot0.commonItem1_:SetBottomText(string.format("%s/%s", slot3, tostring(slot0.costNum_)))

	slot0.nameText1_.text = slot0.sourceCfg_.name

	slot0.commonItem2_:RefreshData({
		number = 1,
		id = slot0.targetId_
	})

	slot0.nameText2_.text = slot0.targetCfg_.name

	slot0:UpdateNum()
	slot0:UpdateSliderPositionBySelectNum()
	slot0:UpdateDelAddBtn()
end

function slot0.UpdateNum(slot0)
	slot0.useNumText_.text = tostring(slot0.selectNum_)
end

function slot0.OnMaterialUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0.sourceId_ then
		if slot3 < slot0.costNum_ then
			slot0:Back()

			return
		end

		slot0:InitData()
		slot0:UpdateView()
	end
end

function slot0.OnEnter(slot0)
	slot0:InitData()
	slot0:UpdateView()
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialUpdate))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	slot0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)

	if slot0.commonItem1_ then
		slot0.commonItem1_:Dispose()

		slot0.commonItem1_ = nil
	end

	if slot0.commonItem2_ then
		slot0.commonItem2_:Dispose()

		slot0.commonItem2_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
