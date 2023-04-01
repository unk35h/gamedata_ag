slot0 = class("BagExpiredView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Bag/BagExpiredUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveBonusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveBonus")
	slot0.expiredItemList_ = LuaList.New(handler(slot0, slot0.indexExpiredItem), slot0.expiredListGo_, CommonItem)
	slot0.getItemList_ = LuaList.New(handler(slot0, slot0.indexGetItem), slot0.getListGo_, CommonItem)
end

function slot0.indexGetItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.getItemDataList_[slot1].id,
		number = slot0.getItemDataList_[slot1].num
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.indexExpiredItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.params_.materialList[slot1].id,
		number = slot0.params_.materialList[slot1].num,
		time_valid = slot0.params_.materialList[slot1].time_valid
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_OTHER_ITEM, {
			slot0.id,
			slot0.number,
			0,
			slot0.time_valid
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot1 = {}
	slot0.getItemDataList_ = {}

	for slot5, slot6 in ipairs(slot0.params_.materialList) do
		slot8 = slot6.num

		if ItemTimeLimitExchangeCfg[slot6.id] then
			if not slot1[slot9.exchange_item[1]] then
				slot1[slot9.exchange_item[1]] = slot9.exchange_item[2] * slot8
			else
				slot1[slot9.exchange_item[1]] = slot1[slot9.exchange_item[1]] + slot9.exchange_item[2] * slot8
			end
		end
	end

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.getItemDataList_, {
			id = slot5,
			num = slot6
		})
	end

	slot0.expiredItemList_:StartScroll(#slot0.params_.materialList)

	if #slot0.getItemDataList_ > 0 then
		slot0.haveBonusController_:SetSelectedState("true")
		slot0.getItemList_:StartScroll(#slot0.getItemDataList_)
	else
		slot0.haveBonusController_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.expiredItemList_ ~= nil then
		slot0.expiredItemList_:Dispose()

		slot0.expiredItemList_ = nil
	end

	if slot0.getItemList_ then
		slot0.getItemList_:Dispose()

		slot0.getItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
