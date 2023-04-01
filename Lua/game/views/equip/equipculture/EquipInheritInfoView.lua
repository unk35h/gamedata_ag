slot1 = class("EquipInheritInfoView", import("game.views.equip.EquipPopInfoView"))

function slot1.RefreshState(slot0)
	slot3 = slot0.selectType_

	if #slot0.info_:GetTotalSkill() > 0 then
		SetActive(slot0.switchGo_, true)
		SetActive(slot0.suitTipGo_, false)

		if EquipCfg[slot0.info_.prefab_id].starlevel >= 5 and slot0.info_.race ~= 0 and not table.keyof(RaceEffectCfg.all, slot0.info_.race) and EquipCfg[slot0.info_.prefab_id].hero_slot_open_level[1] <= slot0.info_:GetLevel() then
			SetActive(slot0.skillGo_, true)
		else
			SetActive(slot0.skillGo_, false)

			if slot3 == "hero_skill" then
				slot3 = "suit"
			end
		end
	else
		SetActive(slot0.switchGo_, false)
		SetActive(slot0.suitTipGo_, true)

		slot3 = "suit"
	end

	slot0:ChangeShowView(slot3)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		if uv0.selectType_ ~= "skill" then
			uv0:ChangeShowView("skill")

			if uv0.data_.ChildToggleSelect then
				uv0.data_:ChildToggleSelect("skill", uv0.message_)
			end
		end
	end)
	slot0:AddBtnListener(slot0.suitBtn_, nil, function ()
		if uv0.selectType_ ~= "suit" then
			uv0:ChangeShowView("suit")

			if uv0.data_.ChildToggleSelect then
				uv0.data_:ChildToggleSelect("suit", uv0.message_)
			end
		end
	end)
end

function slot1.RefreshTitle(slot0)
	uv0.super.RefreshTitle(slot0)
	slot0.lockController:SetSelectedState("close")
end

return slot1
