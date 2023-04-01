slot0 = class("CommonItemTip", ReduxView)
slot1 = import("game.const.ItemConst")
slot2 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:AddUIListener()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	if slot0.info_ and (slot2.type ~= slot0.info_.type or slot2.id ~= slot0.info_.id) then
		slot0.selectUse_ = 1
	end

	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.name_ = slot0:FindCom(typeof(Text), "message/name")
	slot0.icon_ = slot0:FindCom(typeof(Image), "message/icon")
	slot0.rare_ = slot0:FindCom(typeof(Image), "message/bg/image")
	slot0.des_ = slot0:FindCom(typeof(Text), "message/Panel/des")
	slot0.suitDes_ = slot0:FindCom(typeof(Text), "equipinfo/suit/des")
	slot0.suitGo_ = slot0:FindGo("equipinfo/suit")
	slot0.numGo_ = slot0:FindGo("message/numbg")
	slot0.numImg_ = slot0:FindCom(typeof(Image), "message/numbg/image")
	slot0.num_ = slot0:FindCom(typeof(Text), "message/numbg/num")
	slot0.getway_ = slot0:FindGo("getway")
	slot0.equipinfo_ = slot0:FindGo("equipinfo")
	slot0.useNum_ = slot0:FindGo("bottom/usenumbg")
	slot0.useNumText_ = slot0:FindCom(typeof(Text), "bottom/usenumbg/usenum")
	slot0.btnStrength_ = slot0:FindGo("bottom/btn_strength")
	slot0.sourceNull_ = slot0:FindGo("getway/null")
	slot0.sourceHave_ = slot0:FindGo("getway/have")
	slot0.sourceList_ = slot0:FindTrs("getway/have/list/Grid")
	slot0.listGo_ = slot0:FindGo("getway/have/list")
	slot0.item_ = slot0:FindGo("getway/have/item")
	slot0.itemPool_ = Pool.New(slot0.item_, slot0.sourceList_, 0)
	slot0.scrollHelper = GridScrollHelper.New(handler(slot0, slot0.indexItem), slot0.listGo_, slot0.sourceList_)
	slot0.equipAttrList_ = slot0:FindTrs("equipinfo/list/Grid")
	slot0.attrListGo_ = slot0:FindGo("equipinfo/list")
	slot0.attrItem_ = slot0:FindGo("equipinfo/item")
	slot0.attrItemPool_ = Pool.New(slot0.attrItem_, slot0.equipAttrList_, 0)
	slot0.attrScrollHelper = GridScrollHelper.New(handler(slot0, slot0.indexAttrItem), slot0.attrListGo_, slot0.equipAttrList_)
	slot0.equipShowS_ = {
		"equip",
		"suit"
	}
end

function slot0.AddUIListener(slot0)
	slot0.toggle_ = {}

	for slot4, slot5 in pairs(slot0.equipShowS_) do
		slot0.toggle_[slot5] = slot0:FindCom(typeof(Toggle), "equipinfo/switch/" .. slot5)

		slot0:AddToggleListener(slot0.toggle_[slot5], function (slot0)
			if slot0 then
				if uv0 == "equip" then
					SetActive(uv1.attrListGo_, true)
					SetActive(uv1.suitGo_, false)
				elseif uv0 == "suit" then
					SetActive(uv1.attrListGo_, false)
					SetActive(uv1.suitGo_, true)
				end
			end
		end)
	end

	slot0:AddPressingByTimeListener(slot0:FindGo("bottom/usenumbg/btn_cut"), 3, 0.5, 0.2, function ()
		if uv0.selectUse_ > 1 then
			uv0.selectUse_ = uv0.selectUse_ - 1
			uv0.useNumText_.text = uv0.selectUse_

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0:FindGo("bottom/usenumbg/btn_add"), 3, 0.5, 0.2, function ()
		if uv0.selectUse_ < uv0.info_.number then
			uv0.selectUse_ = uv0.selectUse_ + 1
			uv0.useNumText_.text = uv0.selectUse_

			return true
		end

		return false
	end)
	slot0:AddBtnListenerScale("bottom/usenumbg/btn_use", nil, function ()
		slot0 = ItemTools.getItemCfg(uv0.info_.type, uv0.info_.id)
		slot1 = ActionCreators.TryToUseItem({
			{
				item_id = uv0.info_.id,
				select_index_list = {},
				num = uv0.selectUse_
			}
		})

		slot1:next(function (slot0)
			if isSuccess(slot0.result) then
				MaterialAction.MaterialModify(uv0.info_.id, -1 * uv0.selectUse_)

				uv0.selectUse_ = 1
				uv0.useNumText_.text = uv0.selectUse_
				slot1 = {}

				for slot5, slot6 in ipairs(slot0.drop_list) do
					table.insert(slot1, {
						id = slot6.id,
						number = slot6.num
					})
				end

				if #slot1 > 0 then
					uv0:Go("reward", {
						list = slot1
					})
				end
			end
		end)
	end)
	slot0:AddBtnListenerScale("bottom/btn_strength", nil, function ()
		uv0:Go("equipStrength", {
			equipID = uv0.info_.equip_info.equip_id
		})
	end)
end

function slot0.indexItem(slot0, slot1)
	if slot1 < 0 or slot1 > #slot0.source_ then
		return nil
	end

	slot2, slot4.recycleIndex = slot0.itemPool_:GetCanUsingObj()

	SetActive(slot2, true)

	slot4 = SourceItem.New(slot0, slot2, slot0.source_[slot1])
	slot4.pools = slot0.itemPool_

	return slot4
end

function slot0.indexAttrItem(slot0, slot1)
	if slot1 < 0 or slot1 > #slot0.equipAttrs_ then
		return nil
	end

	slot2, slot4.recycleIndex = slot0.attrItemPool_:GetCanUsingObj()

	SetActive(slot2, true)

	slot4 = EquipAttrItem.New(slot0, slot2, slot0.equipAttrs_[slot1])
	slot4.pools = slot0.attrItemPool_

	return slot4
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)

	slot0.selectUse_ = 1
end

function slot0.OnUpdate(slot0)
	slot0.selectUse_ = 1
	slot0.useNumText_.text = slot0.selectUse_
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0:UpdateRareBg()
		slot0:UpdateIcon()
		slot0:UpdateNameAndDes()
		slot0:UpdateType(slot1.type)
		slot0:UpdateExMessage(slot1.type)
	end
end

function slot0.UpdateRareBg(slot0)
	slot0.rare_.color = uv0.ITEM_RARE_COLOR[ItemTools.getItemInfo(slot0.info_.type, slot0.info_.id, "rare")]
end

function slot0.UpdateIcon(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.type, slot0.info_.id)
end

function slot0.UpdateNameAndDes(slot0)
	slot0.name_.text = ItemTools.getItemInfo(slot0.info_.type, slot0.info_.id, "name")
	slot0.des_.text = ItemTools.getItemInfo(slot0.info_.type, slot0.info_.id, "describe")
end

function slot0.UpdateType(slot0, slot1)
	if uv0.ITEM_TYPE.CURRENCY == slot1 or uv0.ITEM_TYPE.MATERIAL == slot1 then
		SetActive(slot0.numGo_, true)

		slot0.numImg_.sprite = getSprite("Atlas/Common", "icon_depot_01")
		slot0.num_.text = slot0.info_.number
	elseif uv0.ITEM_TYPE.HERO_PIECE == slot1 or uv0.ITEM_TYPE.EQUIP_PIECE == slot1 then
		SetActive(slot0.numGo_, true)

		slot0.numImg_.sprite = getSprite("Atlas/Common", "icon_chip_01")
		slot0.num_.text = slot0.info_.number
	elseif uv0.ITEM_TYPE.EQUIP == slot1 then
		SetActive(slot0.numGo_, false)
	else
		SetActive(slot0.numGo_, false)
	end
end

function slot0.UpdateExMessage(slot0, slot1)
	if uv0.ITEM_TYPE.EQUIP == slot1 then
		SetActive(slot0.getway_, false)
		SetActive(slot0.equipinfo_, true)
		SetActive(slot0.useNum_, false)
		SetActive(slot0.btnStrength_, true)
		slot0:UpdateEquipInfo()
		slot0:UpdateSuitEffect()
	else
		SetActive(slot0.getway_, true)
		SetActive(slot0.equipinfo_, false)

		slot3 = ItemTools.getItemCfg(slot0.info_.type, slot0.info_.id).use and slot2.use == 1

		SetActive(slot0.useNum_, slot3)

		slot0.useNumText_.text = slot0.selectUse_

		SetActive(slot0.btnStrength_, false)
		slot0:UpdateSource()
	end
end

function slot0.UpdateSource(slot0)
	slot1 = ItemTools.getItemInfo(slot0.info_.type, slot0.info_.id, "source") or {}
	slot0.source_ = slot1

	SetActive(slot0.sourceNull_, #slot1 == 0)
	SetActive(slot0.sourceHave_, slot2 ~= 0)
	slot0.scrollHelper:StartScroll(slot2)
end

function slot0.UpdateEquipInfo(slot0)
	if slot0.info_.equip_info then
		slot0.equipAttrs_ = {}
		slot2 = 1

		for slot6, slot7 in pairs(uv0.CountEquipAttribute(slot0.info_.equip_info)) do
			table.insert(slot0.equipAttrs_, {
				key = slot6,
				value = slot7,
				index = slot2
			})

			slot2 = slot2 + 1
		end

		slot0.attrScrollHelper:StartScroll(#slot0.equipAttrs_)
	end
end

function slot0.UpdateSuitEffect(slot0)
	if slot0.info_.equip_info then
		slot2 = ""

		for slot7 = 1, #uv0.GetEquipSuitEffect(slot0.info_.equip_info) do
			slot8 = EquipSuitCfg[slot1[slot7]]
			slot2 = string.format("%s【<color=#c3c3c3>%s</color>】<color=#35aaff>%d</color><color=#c3c3c3>件：</color><color=#e5eae8>%s</color>%s", slot2, slot8.name, slot8.need, uv0.GetEffectDesc(slot8.suit_effect[1]), slot7 == slot3 and "" or "\n")
		end

		slot0.suitDes_.text = slot2
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.equipShowS_) do
		slot0.toggle_[slot5] = slot0:FindCom(typeof(Toggle), "equipinfo/switch/" .. slot5)

		slot0.toggle_[slot5].onValueChanged:RemoveAllListeners()
	end

	slot0.scrollHelper:Dispose()
	slot0.itemPool_:Dispose()
	slot0.attrScrollHelper:Dispose()
	slot0.attrItemPool_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
