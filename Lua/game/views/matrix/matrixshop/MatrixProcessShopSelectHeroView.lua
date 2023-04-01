slot0 = class("MatrixProcessSelectHeroView", MatrixProcessSelectHeroView)

function slot0.OnRewardAction(slot0)
	slot0.shopIndex = slot0.params_.index
	slot2 = slot0.selectHeroId

	if not (slot0.id and MatrixItemCfg[slot1] or nil) then
		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3.matrix_item_type then
		if MatrixData:GetHeroEquipMaxCount() <= #MatrixData:GetHeroData(slot2):GetEquipList() then
			JumpTools.OpenPageByJump("matrixProcessEquipReplace", {
				heroId = slot2,
				equipId = slot1,
				callback = function (slot0)
					MatrixAction.BuyShopItem(uv0.shopIndex, uv1:GetStandardId(), slot0)
				end
			})
		else
			MatrixAction.BuyShopItem(slot0.shopIndex, slot5:GetStandardId(), 0)
		end

		return
	end

	if MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot4 then
		if MatrixData:GetHeroData(slot2):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("matrixProcessWeaponReplace", {
				heroId = slot2,
				weaponId = slot1,
				callback = function ()
					MatrixAction.BuyShopItem(uv0.shopIndex, uv1:GetStandardId(), uv2)
				end
			})
		else
			MatrixAction.BuyShopItem(slot0.shopIndex, slot5:GetStandardId(), 0)
		end
	else
		MatrixAction.BuyShopItem(slot0.shopIndex, MatrixData:GetHeroData(slot2):GetStandardId(), 0)
	end
end

return slot0
