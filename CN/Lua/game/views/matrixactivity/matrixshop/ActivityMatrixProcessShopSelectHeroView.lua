slot0 = class("ActivityMatrixProcessShopSelectHeroView", MatrixProcessSelectHeroView)

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.OnRewardAction(slot0)
	slot0.shopIndex = slot0.params_.index
	slot2 = slot0.selectHeroId

	if not (slot0.id and MatrixItemCfg[slot1] or nil) then
		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3.matrix_item_type then
		if slot0:GetHeroEquipMaxCount() <= #slot0:GetHeroData(slot2):GetEquipList() then
			JumpTools.OpenPageByJump("activityMatrixProcessEquipReplace", {
				matrix_activity_id = slot0.matrix_activity_id,
				heroId = slot2,
				equipId = slot1,
				callback = function (slot0)
					ActivityMatrixAction.BuyShopItem(uv0.matrix_activity_id, uv0.shopIndex, uv1:GetStandardId(), slot0)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, slot5:GetStandardId(), 0)
		end

		return
	end

	if MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot4 then
		if slot0:GetHeroData(slot2):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("activityMatrixProcessWeaponReplace", {
				matrix_activity_id = slot0.matrix_activity_id,
				heroId = slot2,
				weaponId = slot1,
				callback = function ()
					ActivityMatrixAction.BuyShopItem(uv0.matrix_activity_id, uv0.shopIndex, uv1:GetStandardId(), uv2)
				end
			})
		else
			ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, slot5:GetStandardId(), 0)
		end
	else
		ActivityMatrixAction.BuyShopItem(slot0.matrix_activity_id, slot0.shopIndex, slot0:GetHeroData(slot2):GetStandardId(), 0)
	end
end

function slot0.GetHeroData(slot0, slot1)
	return ActivityMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetHeroEquipMaxCount(slot0)
	return ActivityMatrixData:GetHeroEquipMaxCount(slot0.matrix_activity_id)
end

function slot0.GetMatrixHeroTeam(slot0)
	return ActivityMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

return slot0
