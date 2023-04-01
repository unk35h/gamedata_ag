slot0 = class("StrategyMatrixProcessSelectHeroView", MatrixProcessSelectHeroView)

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	uv0.super.OnEnter(slot0)
end

function slot0.OnRewardAction(slot0)
	slot2 = slot0.selectHeroId

	if not (slot0.id and MatrixItemCfg[slot1] or nil) then
		return
	end

	if MatrixConst.ITEM_TYPE.EQUIP == slot3.matrix_item_type then
		if slot0:GetHeroEquipMaxCount() <= #slot0:GetHeroData(slot2):GetEquipList() then
			JumpTools.OpenPageByJump("strategyMatrixProcessEquipReplace", {
				heroId = slot2,
				equipId = slot1,
				callback = function (slot0)
					StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						slot0,
						uv2:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1,
				0,
				slot5:GetStandardId()
			})
		end

		return
	end

	if MatrixConst.ITEM_TYPE.WEAPON_SERVANT == slot4 then
		if slot0:GetHeroData(slot2):GetWeaponServant() ~= 0 then
			JumpTools.OpenPageByJump("strategyMatrixProcessWeaponReplace", {
				heroId = slot2,
				weaponId = slot1,
				callback = function ()
					StrategyMatrixAction.QueryNextProgress(uv0.matrix_activity_id, {
						uv1,
						uv2,
						uv3:GetStandardId()
					})
				end
			})
		else
			StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
				slot1,
				0,
				slot5:GetStandardId()
			})
		end
	else
		StrategyMatrixAction.QueryNextProgress(slot0.matrix_activity_id, {
			slot1,
			0,
			slot0:GetHeroData(slot2):GetStandardId()
		})
	end
end

function slot0.GetHeroData(slot0, slot1)
	return StrategyMatrixData:GetHeroData(slot0.matrix_activity_id, slot1)
end

function slot0.GetMatrixHeroTeam(slot0)
	return StrategyMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot0.GetHeroEquipMaxCount(slot0)
	return StrategyMatrixData:GetHeroEquipMaxCount(slot0.matrix_activity_id)
end

return slot0
