slot0 = class("RewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Common/RewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rowCountController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rowCount")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.itemList_[slot1]

	slot2:RefreshData(slot3)
	slot2:ShowName(true)
	slot2:ShowBlackBack(true)

	if ItemCfg[slot3.id].type == ItemConst.ITEM_TYPE.EQUIP and slot3.number then
		slot2:SetBottomText(slot3.number)
	end

	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number,
			0,
			slot0.time_valid
		})
	end)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.itemList_ = slot1
		slot0.itemPool_ = slot0.itemPool1_

		if #slot1 > 5 then
			slot0.rowCountController_:SetSelectedState("2")
			slot0.scrollHelper:SetAlignment(UIListAlignment.Center)
		else
			slot0.rowCountController_:SetSelectedState("1")
			slot0.scrollHelper:SetAlignment(UIListAlignment.Center2)
		end

		slot0.scrollHelper:StartScroll(slot2)
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI(slot0.params_.list)
end

function slot0.OnExit(slot0)
	slot0:ShowVitalityBox(function ()
		slot0 = uv0

		slot0:ShowEquipBox(function ()
		end)
	end)
end

function slot0.ShowVitalityBox(slot0, slot1)
	if slot0.params_.needShowVitalityBox then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.ShowEquipBox(slot0, slot1)
	if slot0.params_.needShowEquipBox then
		showEquipSendMail(slot1)
	else
		slot1()
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper ~= nil then
		slot0.scrollHelper:Dispose()

		slot0.scrollHelper = nil
	end

	if slot0.itemPool1_ ~= nil then
		slot0.itemPool1_:Dispose()

		slot0.itemPool1_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.DisablebgBtn(slot0)
	slot0.bgBtn_.enabled = false
end

return slot0
