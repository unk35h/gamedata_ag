slot0 = {
	LoadingShow = function (slot0, slot1)
		if LoadingUIType.Battle == slot1 then
			slot2 = false

			if not BattleController.GetInstance():GetBattleStageData() then
				LoadingUIManager.inst:UpdateLoadingInfo("", "", "")
			end

			slot4 = slot3:GetStageId()

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot3:GetType() then
				slot2 = MythicData:GetIsFirstClear(slot3:GetDest())
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot5 then
				slot2 = true
			elseif BattleStageData:GetStageData()[slot4] then
				slot2 = slot6.clear_times <= 0
			end

			if slot2 and LoadingTipsStage[slot4] then
				LoadingUIManager.inst:UpdateLoadingInfo(LoadingTipsStage[slot4].title, LoadingTipsStage[slot4].tips, LoadingTipsStage[slot4].loading_picture)
			else
				uv0:ChooseRandom()
			end
		elseif LoadingUIType.Main == slot1 then
			uv0:ChooseRandom()
		elseif LoadingUIType.GameStart == slot1 then
			LoadingUIManager.inst:UpdateLoadingInfo("", "", nil)
		else
			uv0:ChooseRandom()
		end
	end,
	ChooseRandom = function (slot0)
		slot1, slot2, slot3, slot4 = IllustratedData:GetRandomTips()

		if slot4 then
			LoadingUIManager.inst:UpdateLoadingInfo(slot1, slot2, slot3)
		else
			LoadingUIManager.inst:UpdateLoadingInfo2(slot1, slot2, slot3)
		end
	end,
	GetRandomTips = function (slot0)
		if not LoadingTipsPoolCfg[LoadingTipsPoolCfg.all[math.random(1, #LoadingTipsPoolCfg.all)]].loading_picture or slot4 == "" then
			slot4 = LoadingTipsPicturePoolCfg[LoadingTipsPicturePoolCfg.all[math.random(1, #LoadingTipsPicturePoolCfg.all)]].loading_picture
		end

		return slot3.title, slot3.tips, slot4
	end,
	GetRandomTips2 = function (slot0)
		slot1 = IllustratedData:GetAllLoadingSet()
		slot3 = CollectPictureCfg[slot1[math.random(1, #slot1)]]

		return slot3.name, slot3.desc, slot3.picture
	end
}

LoadingUIManager.inst:SetLoadingShowAction(handler(slot0, slot0.LoadingShow))

return slot0
