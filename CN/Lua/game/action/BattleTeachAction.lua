slot1 = manager.net

slot1:Bind(47001, function (slot0)
	BattleTeachData:ModifyBaseTeach(slot0)
	uv0.UpdateBaseTeachRedPoint()
end)

slot1 = manager.net

slot1:Bind(47003, function (slot0)
	BattleTeachData:ModifyHeroTeach(slot0)
end)

slot1 = manager.notify

slot1:RegistListener(HERO_DATA_INIT, function ()
	uv0.UpdateHeroTeachRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(HERO_UNLOCK_SUCCESS, function ()
	uv0.UpdateHeroTeachRedPoint()
end)

return {
	UpdateBaseTeachRedPoint = function ()
		if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[402].level then
			return
		end

		slot2 = false

		for slot6, slot7 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
			if BattleStageData:GetStageData()[slot7[2]] and slot8.clear_times > 0 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot7[1]) == nil then
				slot2 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.TEACH_BASE, slot2 and 1 or 0)
	end,
	CancelBaseTeachRedPoint = function ()
		for slot3, slot4 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
			if BattleStageData:GetStageData()[slot4[2]] and slot5.clear_times > 0 and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot4[1]) == nil then
				RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6)
			end
		end

		manager.redPoint:setTip(RedPointConst.TEACH_BASE, 0)
	end,
	UpdateHeroTeachRedPoint = function ()
		if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[402].level then
			return
		end

		slot3 = false

		for slot7, slot8 in pairs(HeroData.GetUnlockHeros()) do
			if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot8) == nil then
				slot3 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, slot3 and 1 or 0)
	end,
	CancelHeroTeachRedPoint = function ()
		for slot4, slot5 in pairs(HeroData.GetUnlockHeros()) do
			if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot5) == nil then
				RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot5)
			end
		end

		manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, 0)
	end
}
