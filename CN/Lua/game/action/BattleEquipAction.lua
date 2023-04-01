slot1 = manager.net

slot1:Bind(43001, function (slot0)
	BattleEquipData:InitBattleEquipData(slot0)
	manager.notify:CallUpdateFunc(BATTLE_EQUIP_UPDATE)
end)

return {
	RequestBattleEquipInfo = function ()
		manager.net:SendWithLoadingNew(43002, {}, 43003)
	end,
	ChangeUpSuit = function (slot0)
		manager.net:SendWithLoadingNew(43004, {
			equip_suit_id = slot0
		}, 43005, uv0.OnChangeUpSuit)
	end,
	OnChangeUpSuit = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BattleEquipData:ChangeUpSuitId(slot1.equip_suit_id)
		end

		manager.notify:CallUpdateFunc(CHANGE_UP_SUIT, slot0, slot1)
	end,
	CaculateGuaranteeNum = function (slot0, slot1)
		slot2 = BattleEquipStageCfg[slot0]
		slot3 = BattleInstance.GetHardLevel(slot0)

		for slot7, slot8 in ipairs(slot1) do
			slot9 = false

			for slot13, slot14 in ipairs(slot8) do
				if ItemCfg[slot14[1]] and ItemConst.ITEM_TYPE.EQUIP == slot15.type and EquipCfg[slot14[1]].starlevel == 5 then
					slot9 = true
				end
			end

			if slot9 then
				BattleEquipData:SetGuaranteeNum(slot3, 0)
			else
				BattleEquipData:AddGuaranteeNum(slot3, 1)
			end
		end

		return rewards
	end
}
