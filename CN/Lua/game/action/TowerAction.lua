slot1 = manager.net

slot1:Bind(41001, function (slot0)
	TowerData:InitTowerData(slot0.info_list)
	uv0.UpdateTowerRedPoint()
end)

slot1 = manager.notify

slot1:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateTowerRedPoint()
end)

return {
	UpdateTowerRedPoint = function ()
		slot0 = PlayerData:GetPlayerInfo().userLevel
		slot2 = false

		for slot6, slot7 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
			if slot0 >= (ChapterCfg[slot7].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot7) == nil then
				slot2 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.TOWER, slot2 and 1 or 0)
	end,
	CancelTowerRedPoint = function ()
		slot0 = PlayerData:GetPlayerInfo().userLevel

		for slot5, slot6 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
			if slot0 >= (ChapterCfg[slot6].level or 0) and RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6) == nil then
				RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + slot6)
			end
		end

		manager.redPoint:setTip(RedPointConst.TOWER, 0)
	end
}
