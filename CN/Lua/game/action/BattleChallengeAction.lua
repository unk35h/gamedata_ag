slot1 = manager.net

slot1:Bind(26009, function (slot0)
	BattleStageData:InitChallengeData(slot0.challenge_battle_list)
end)

slot1 = manager.net

slot1:Bind(26017, function (slot0)
	BattleStageData:InitChapterStarReward(slot0.gain_list)
end)

return {}
