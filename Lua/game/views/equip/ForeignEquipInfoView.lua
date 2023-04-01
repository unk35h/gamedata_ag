slot0 = class("ForeignEquipInfoView", EquipPopInfoView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.stateCon_ = ControllerUtil.GetController(slot0.controlRect_, "state")
end

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.strengthBtn_, nil, function ()
		uv0.info_.id = uv0.info_.prefab_id

		ShowPopItem(POP_OPERATE_ITEM, uv0.info_, {
			page = 2
		})
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		uv0:Go("/heroEquipBag", {
			isClearPos = true,
			isOpenInfo = true,
			heroId = uv0.heroId_,
			suitPos = EquipCfg[uv0.info_.prefab_id].pos
		})
	end)
end

function slot0.RefreshTitle(slot0)
	slot8 = EquipCfg[slot0.info_.prefab_id].starlevel - 2

	slot0.starController:SetSelectedIndex(math.max(0, slot8))

	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.info_.prefab_id)
	slot0.name_.text = EquipCfg[slot0.info_.prefab_id].name
	slot4 = HeroConst.RARE_COLOR[ItemCfg[slot0.info_.prefab_id].rare]

	for slot8 = 1, 5 do
		SetActive(slot0.star_[slot8], slot8 <= slot2.starlevel)
	end

	slot5 = slot0.info_:GetEnchantCount()

	for slot9 = 1, 2 do
		SetActive(slot0.slot_[slot9], slot9 <= slot5)
	end

	slot0.lv_.text = slot0.info_:GetLevel() .. "/" .. slot0.info_:GetMaxLv()

	SetActive(slot0.lockGo_, false)

	slot8 = slot2.pos or 0
	slot0.posBg_.localRotation = Quaternion.Euler(0, 0, slot2.pos * 60 - 60)
end

function slot0.SetState(slot0, slot1)
	slot0.stateCon_:SetSelectedState(slot1)
end

return slot0
