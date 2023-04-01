slot1 = class("ActivityMatrixOriginView", import("game.views.matrixOver.MatrixOverView"))

function slot1.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityBattleMatrixOverUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4] = ActivityMatrixOverHeroItem.New(slot0[string.format("heroItem%s_", slot4)])
	end

	slot0.affixList_ = LuaList.New(handler(slot0, slot0.AffixIndexItem), slot0.m_affixList, MatrixOverAffixItem)
	slot0.treasureList_ = LuaList.New(handler(slot0, slot0.ArtifactIndexItem), slot0.m_treasureList, MatrixOverArtifactItem)
	slot0.beaconList_ = LuaList.New(handler(slot0, slot0.BeaconIndexItem), slot0.m_beaconList, MatrixOverBeaconItem)
	slot0.resultController_ = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		if uv0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
				main_matrix_activity_id = ActivityMatrixData:GetMainActivityId(uv0.matrix_activity_id),
				matrix_activity_id = uv0.matrix_activity_id
			})
		else
			ActivityMatrixAction.QueryMatrixOver(uv0.matrix_activity_id)
		end
	end)
	slot0:AddBtnListener(slot0.statisticsBtn_, nil, function ()
		JumpTools.OpenPageByJump("battleStatisticsActivityMatrixOver", {
			matrix_activity_id = uv0.matrix_activity_id
		})
	end)
end

function slot1.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id

	for slot4 = 1, 3 do
		slot0.heroItemList_[slot4]:SetMatrixActivityId(slot0.matrix_activity_id)
	end

	slot0:Refresh()

	if slot0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		slot3 = ActivityMatrixCfg[slot0.matrix_activity_id] and slot2.after_story_id or {}
		slot4 = false

		for slot8, slot9 in ipairs(slot3) do
			if slot9 and not manager.story:IsStoryPlayed(slot9) then
				slot4 = true

				break
			end
		end

		if slot4 then
			slot0.storyList = clone(slot3)
			slot5 = manager.story

			slot5:StartStoryById(slot0.storyList[1], function (slot0)
				uv0:CheckStoryPlay()
			end)
		end
	end
end

function slot1.CheckStoryPlay(slot0)
	PlayerAction.ChangeStoryList(slot0.storyList[1])
	table.remove(slot0.storyList, 1)

	if #slot0.storyList > 0 then
		slot1 = manager.story

		slot1:StartStoryById(slot0.storyList[1], function (slot0)
			uv0:CheckStoryPlay()
		end)
	end
end

function slot1.Refresh(slot0)
	uv0.super.Refresh(slot0)

	if ActivityMatrixData:GetMatrixIsFirstClear(slot0.matrix_activity_id) then
		slot0.m_clueText.text = string.format(GetTips("ACTIVITY_VOLUME_MATRIX_CLUE"), ActivityMatrixData:GetMatrixClueCount(ActivityMatrixData:GetMainActivityId(slot0.matrix_activity_id), slot0.matrix_activity_id))
	else
		slot0.m_clueText.text = ""
	end
end

function slot1.OnMatrixUserUpdate(slot0)
	if MatrixConst.STATE_TYPE.NOTSTARTED == MatrixData:GetGameState() then
		-- Nothing
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= slot1 and MatrixConst.STATE_TYPE.FAIL == slot1 then
		-- Nothing
	end
end

function slot1.GetGameState(slot0)
	return ActivityMatrixData:GetGameState(slot0.matrix_activity_id)
end

function slot1.GetCurrentClearTime(slot0)
	return ActivityMatrixData:GetCurrentClearTime(slot0.matrix_activity_id)
end

function slot1.GetMinClearTime(slot0)
	return ActivityMatrixData:GetMinClearTime(slot0.matrix_activity_id)
end

function slot1.GetEvaluateList(slot0)
	return {}
end

function slot1.GetTierDes(slot0)
	slot2 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(slot0.matrix_activity_id)]

	return string.format("%s-%s", slot2.tier, slot2.level)
end

function slot1.GetAffixList(slot0)
	return {}
end

function slot1.GetArtifactList(slot0)
	return ActivityMatrixData:GetArtifactList(slot0.matrix_activity_id)
end

function slot1.GetUseBeaconList(slot0)
	return {}
end

function slot1.GetMatrixCurrencyList(slot0)
	return ActivityMatrixData:GetMatrixCurrencyList(slot0.matrix_activity_id)
end

function slot1.GetMatrixHeroTeam(slot0)
	return ActivityMatrixData:GetMatrixHeroTeam(slot0.matrix_activity_id)
end

function slot1.GetMatrixOverScore(slot0)
	return ActivityMatrixData:GetMatrixOverPoint(slot0.matrix_activity_id)
end

function slot1.GetDifficulty(slot0)
	return 1
end

function slot1.GetRegularAffix(slot0)
	return {}
end

function slot1.GetCustomAffix(slot0)
	return {}
end

return slot1
