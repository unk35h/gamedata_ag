slot0 = class("OptionalItemSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/OptionalItemSelectUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.selectInex_ = 0
	slot0.lastSelectItem_ = nil

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.okBtnController_ = ControllerUtil.GetController(slot0.okBtnTrs_, "enabled")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemList_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.dataList_[slot1][1]
	slot4 = slot0.dataList_[slot1][2]

	slot2:RefreshData({
		id = slot3,
		number = slot4 * slot0.useNum_,
		level = slot4 * slot0.useNum_,
		type = ItemCfg[slot3].type
	})
	slot2:SetSelectType("equip")
	slot2:ShowSelect(slot1 == slot0.selectInex_ and 1 or 0)
	slot2:RegistCallBack(function (slot0)
		uv0:SelectItem(uv1, uv2)
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnOk_, nil, function ()
		if ItemCfg[uv0.itemInfo_[1]].param[uv0.indexMap_[uv0.selectInex_]] then
			if ItemCfg[slot1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(slot2) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				if MaterialData:GetMaterialListById(getTicketIDBySkinID(slot2)) then
					for slot9, slot10 in pairs(slot5) do
						if slot10 and slot10.num > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			CommonAction.TryToUseItem({
				{
					item_id = uv0.itemInfo_[1],
					use_list = {
						uv0.selectInex_
					},
					num = uv0.useNum_
				}
			})
		end
	end)
	slot0:AddBtnListener(slot0.btnCancel_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.SelectItem(slot0, slot1, slot2)
	if slot0.selectInex_ == slot2 then
		return
	end

	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:ShowSelect(0)
	end

	slot0.selectInex_ = slot2
	slot0.lastSelectItem_ = slot1

	slot1:ShowSelect(1)
	slot0:RefreshSelect()
end

function slot0.RefreshUI(slot0)
	slot0.itemInfo_ = slot0.params_.popItemInfo
	slot0.useNum_ = slot0.params_.selectNum
	slot0.dataList_ = {}
	slot0.indexMap_ = {}
	slot2 = 1

	for slot6 = 1, #ItemCfg[slot0.itemInfo_[1]].param do
		if not HeroTools.GetIsHide(slot1.param[slot6][1]) then
			if not HeroTools.GetIsSkinHide(slot7) then
				table.insert(slot0.dataList_, slot1.param[slot6])

				slot0.indexMap_[slot2] = slot6
				slot2 = slot2 + 1
			end
		end
	end

	slot0.scrollHelper:StartScroll(#slot0.dataList_)
	slot0:RefreshSelect()
end

function slot0.RefreshSelect(slot0)
	if slot0.dataList_[slot0.selectInex_] then
		slot0.tipText_.text = string.format(GetTips("TIP_SELECT"), GetI18NText(ItemCfg[slot1[1]].name))

		slot0.okBtnController_:SetSelectedIndex(1)
	else
		slot0.tipText_.text = GetTips("SELECT_CURRENT")

		slot0.okBtnController_:SetSelectedIndex(0)
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if #slot2.use_item_list > 0 then
			MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1 * slot2.use_item_list[1].num, slot2.use_item_list[1].time_valid)
		end

		slot3 = slot0.dataList_[slot0.selectInex_]
		slot4 = JumpTools

		slot4:Back()
		getReward({
			{
				slot3[1],
				slot3[2] * slot0.useNum_
			}
		}, {
			ItemConst.ITEM_TYPE.HERO,
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnExit(slot0)
	slot0.selectInex_ = 0
	slot0.lastSelectItem_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
