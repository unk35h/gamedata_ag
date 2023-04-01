slot0 = class("CommonItemSmallTip", ReduxView)
slot1 = import("game.const.ItemConst")
slot2 = import("game.tools.MailTools")
slot3 = import("game.tools.EquipTools")
slot4 = import("game.const.EquipConst")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:AddUIListener()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemPool_ = Pool.New(slot0.item_, slot0.list_, 0)
	slot0.scrollHelper = GridScrollHelper.New(handler(slot0, slot0.indexItem), slot0.listGo_, slot0.list_)
end

function slot0.AddUIListener(slot0)
	slot0.toggle_ = {
		"attr",
		"skill",
		"suit"
	}

	for slot4, slot5 in ipairs(slot0.toggle_) do
		slot0:AddToggleListener(slot0[slot5 .. "Toggle_"], function (slot0)
			SetActive(uv0[uv1 .. "Go_"], slot0)
			SetActive(uv0[uv1 .. "Bg_"], not slot0)
		end)
	end

	slot0:AddBtnListener(slot0.strength_, nil, function ()
		uv0:Go("equipStrength", {
			equipID = uv0.info_.equip_id
		})
	end)
	slot0:AddBtnListener(slot0.change_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.indexItem(slot0, slot1)
	if slot1 < 0 or slot1 > #slot0.attrList_ then
		return nil
	end

	slot2, slot5.recycleIndex = slot0.itemPool_:GetCanUsingObj()

	SetActive(slot2, true)

	slot5 = EquipAttrItem.New(slot0, slot2, slot0.attrList_[slot1])
	slot5.pools = slot0.itemPool_

	return slot5
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0:UpdateRareBg()
		slot0:UpdateIcon()
		slot0:UpdateNameAndDes()

		slot0.lv_.text = GetTips("LEVEL") .. string.format("%d", uv0.CountEquipLevel(slot1))

		slot0:UpdateSkillS()
		slot0:UpdateSuitEffectS()
		slot0:UpdateAttr()
	end
end

function slot0.UpdateRareBg(slot0)
	slot1 = EquipCfg[slot0.info_.prefab_id]
	slot0.color1_.color = uv0.ITEM_RARE_COLOR[uv1.STAR_TO_RARE[slot1.starlevel]]
	slot0.color2_.color = uv0.ITEM_RARE_COLOR[uv1.STAR_TO_RARE[slot1.starlevel]]
end

function slot0.UpdateIcon(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id)
end

function slot0.UpdateNameAndDes(slot0)
	slot1 = EquipCfg[slot0.info_.prefab_id]
	slot0.name_.text = slot1.name
	slot0.des_.text = slot1.describe
	slot0.posText_.text = slot1.pos
end

function slot0.UpdateSkillS(slot0)
	slot2 = ""

	if EquipCfg[slot0.info_.prefab_id].effect then
		for slot7 = 1, #slot1.effect do
			slot2 = slot2 .. uv0.GetEffectDesc(slot1.effect[slot7])

			if slot7 < slot3 then
				slot2 = slot2 .. "\n"
			end
		end
	end

	slot0.skillDes_.text = slot2
end

function slot0.UpdateSuitEffectS(slot0)
	slot2 = ""
	slot3 = {}

	for slot7, slot8 in ipairs(uv0.GetEquipSuitEffect(slot0.info_)) do
		for slot13, slot14 in ipairs(EquipSuitCfg[slot8].suit_effect) do
			table.insert(slot3, slot14)
		end
	end

	for slot8 = 1, #slot3 do
		slot2 = slot2 .. uv0.GetEffectDesc(slot3[slot8])

		if slot8 < slot4 then
			slot2 = slot2 .. "\n"
		end
	end

	slot0.suitDes_.text = slot2
end

function slot0.UpdateAttr(slot0)
	slot1 = uv0.CountEquipAttribute(slot0.info_)
	slot0.attrList_ = {}
	slot2 = 1

	for slot6, slot7 in ipairs(PublicAttrCfg.all) do
		if slot1[slot7] then
			if slot2 < 3 then
				slot9 = slot1[slot7]

				if PublicAttrCfg[slot7].percent and slot8.percent == 1 then
					slot9 = slot9 / 10 .. "%"
				end

				slot0["attrName" .. slot2 .. "_"].text = slot8.name
				slot0["attrNum" .. slot2 .. "_"].text = slot9
			else
				table.insert(slot0.attrList_, {
					key = slot7,
					value = slot1[slot7]
				})
			end

			slot2 = slot2 + 1
		end
	end

	slot0.scrollHelper:StartScroll(#slot0.attrList_)
end

function slot0.ShowEquiping(slot0, slot1)
	SetActive(slot0.equiping_, slot1)
end

function slot0.ShowButtonS(slot0, slot1)
	SetActive(slot0.buttons_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.toggle_) do
		slot0[slot5 .. "Toggle_"].onValueChanged:RemoveAllListeners()
	end

	slot0.scrollHelper:Dispose()
	slot0.itemPool_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
