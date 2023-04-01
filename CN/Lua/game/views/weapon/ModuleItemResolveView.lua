slot0 = class("ModuleItemResolveView", ReduxView)
slot1 = GameSetting.weapon_module_break_return

function slot0.UIName(slot0)
	return "UI/PopUp/ModuleResolve"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.rewardItem_ = CommonItem.New(slot0.itemGo_)

	slot0.rewardItem_:ShowFloor("3")

	slot0.selectHandler_ = handler(slot0, slot0.OnItemSelect)
	slot0.cutHandler_ = handler(slot0, slot0.OnItemCut)
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItem)
	slot0.btnController_ = ControllerUtil.GetController(slot0.okBtn_.transform, "enabled")
end

function slot0.OnEnter(slot0)
	slot0.curModulePieceList_ = {}
	slot2 = 1

	for slot6, slot7 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
		if MaterialData:GetMaterial(slot7).num > 0 then
			table.insert(slot0.curModulePieceList_, {
				select = 0,
				id = slot7,
				number = slot8,
				index = slot2
			})

			slot2 = slot2 + 1
		end
	end

	slot0.list_:StartScroll(#slot0.curModulePieceList_)

	if slot0.list_:GetItemList() then
		for slot7, slot8 in pairs(slot3) do
			slot8:ShowSelect(0)
		end
	end

	slot0.rewardItem_:RefreshData({
		number = "",
		id = uv0.value[1]
	})
	slot0.rewardItem_:RegistCallBack(function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0,
			num
		})
	end)
	slot0:RefreshReward()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.getNum_ == 0 then
			ShowTips(GetTips("WEAPON_MODULE_MATERIAL_SELECT"))
		else
			slot0 = {}

			for slot4, slot5 in pairs(uv0.curModulePieceList_) do
				if slot5.select > 0 then
					table.insert(slot0, {
						id = slot5.id,
						num = slot5.select
					})
				end
			end

			HeroAction.ResolveModuleItem(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.returnBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnItemSelect(slot0, slot1)
	if slot1.select < slot1.number then
		slot1.select = slot1.select + 1

		slot0.list_:GetItemByIndex(slot1.index):ShowSelect(slot1.select)
		slot0:RefreshReward()

		return true
	else
		return false
	end
end

function slot0.OnItemCut(slot0, slot1)
	if slot1.select > 0 then
		slot1.select = slot1.select - 1

		slot0.list_:GetItemByIndex(slot1.index):ShowSelect(slot1.select)
		slot0:RefreshReward()

		return true
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.curModulePieceList_[slot1])
	slot2:RegistLongCallBack(slot0.selectHandler_)
	slot2:RegistCutCallBack(slot0.cutHandler_)
end

function slot0.RefreshReward(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.curModulePieceList_) do
		slot1 = slot1 + slot6.select
	end

	slot0.getNum_ = slot1 * uv0.value[2]
	slot0.getText_.text = "+" .. slot0.getNum_

	if slot0.getNum_ == 0 then
		slot0.btnController_:SetSelectedState("false")
	else
		slot0.btnController_:SetSelectedState("true")
	end
end

function slot0.OnResolveModuleItem(slot0, slot1, slot2)
	if slot0.getNum_ == 0 then
		return
	end

	if slot1.result == 0 then
		for slot6 = 1, #slot2 do
			MaterialAction.MaterialModify(slot2[slot6].id, -slot2[slot6].num)
		end

		slot3 = JumpTools

		slot3:Back()
		getReward({
			{
				uv0.value[1],
				slot0.getNum_
			}
		})
	else
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.selectHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
