slot0 = manager.net

slot0:Bind(25009, function (slot0)
	BattleStageData:InitResourceData(slot0.daily_battle_list)
end)

return {}
