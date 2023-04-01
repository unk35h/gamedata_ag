return {
	GetConditionProgress = function (slot0, slot1)
		if ConditionCfg[slot0].type == 8010 then
			return DormData:GetDormSceneData(DormData:GetCurrectSceneID()).accruing_earnings, slot2.params[1]
		elseif slot2.type == 8011 then
			return DormData:GetSceneAttractiveValue(DormData:GetCurrectSceneID()), slot2.params[1]
		elseif slot2.type == 8012 then
			if DormData:GetDormSceneData(slot2.params[1]) == nil then
				return 0, slot2.params[2]
			end

			return slot3.level, slot2.params[2]
		elseif slot2.type == 8013 then
			return 0, 1
		elseif slot2.type == 8014 then
			return DormData:GetFurnitureNum(slot2.params[1]), 1
		end

		return 0, 1
	end,
	IsConditionOK = function (slot0, slot1)
		slot2, slot3 = uv0.GetConditionProgress(slot0, slot1)

		return slot3 <= slot2
	end
}
