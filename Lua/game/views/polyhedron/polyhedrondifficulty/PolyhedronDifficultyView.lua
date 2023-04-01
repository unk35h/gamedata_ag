slot0 = class("PolyhedronDifficultyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronDifficultyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.difficultyGroupList = {}
	slot0.lockGoDict = {}
	slot1 = table.keys(PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty)

	table.sort(slot1, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot2 = handler(slot0, slot0.DifficultyClick)

	for slot6, slot7 in ipairs(slot1) do
		if slot7 ~= 0 then
			slot8 = Object.Instantiate(slot0.m_lockTip, slot0.m_content)

			SetActive(slot8, true)

			slot0:FindCom("Text", "text", slot8.transform).text = string.format(GetTips("POLYHEDRON_DIFFICULTY_UNLOCK"), slot7)

			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot8.transform)

			slot0.lockGoDict[slot7] = slot8
		end

		for slot12, slot13 in ipairs(PolyhedronDifficultyCfg.get_id_list_by_unlock_difficulty[slot7]) do
			slot14 = Object.Instantiate(slot0.m_groupItem, slot0.m_content)

			SetActive(slot14, true)

			slot15 = PolyhedronDifficultyGroupItem.New(slot14, slot13)

			slot15:RegistCallBack(slot2)
			table.insert(slot0.difficultyGroupList, slot15)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)

	slot0.overviewList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_difficultybtn, nil, function ()
		slot1 = nil

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = (PolyhedronData:GetCacheSelectHero() == 0 or {
				uv0.leader
			}) and {}
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.maxDifficulty = PolyhedronData:GetClearMaxDifficulty()
	slot0.selectDifficulty = PolyhedronData:GetCacheSelectDifficulty()

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	PolyhedronData:SetCacheSelectDifficulty(slot0.selectDifficulty)
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.difficultyGroupList) do
		slot5:SetData(slot0.maxDifficulty, slot0.selectDifficulty)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot5.gameObject_.transform)
	end

	for slot4, slot5 in pairs(slot0.lockGoDict) do
		if slot0.maxDifficulty < slot4 then
			SetActive(slot5, true)
		else
			SetActive(slot5, false)
		end
	end

	slot0.m_curDifficultyLab.text = slot0.selectDifficulty

	if slot0.selectDifficulty == 0 then
		slot4 = false

		SetActive(slot0.m_difficultybtnGo, slot4)

		for slot4, slot5 in ipairs(slot0.overviewList) do
			slot5:SetActive(false)
		end

		slot0.m_scoreLab.text = "0%"
	else
		SetActive(slot0.m_difficultybtnGo, true)

		slot0.m_scoreLab.text = PolyhedronDifficultyCfg[slot0.selectDifficulty].score / 10 .. "%"
		slot2 = PolyhedronTools.GetPolyhedronDifficultyAffixDir(slot0.selectDifficulty)
		slot3 = {}

		PolyhedronTools.CalPolyhedronDifficultyAttr(slot3, slot0.selectDifficulty)

		slot4 = 1

		for slot8, slot9 in pairs(slot3) do
			if not slot0.overviewList[slot4] then
				slot10 = Object.Instantiate(slot0.m_overviewItem, slot0.m_overviewContent)

				SetActive(slot10, true)

				slot0.overviewList[slot4] = PolyhedronDifficultyOverviewItem.New(slot10)
			end

			slot10 = slot0.overviewList[slot4]

			slot10:SetActive(true)
			slot0.overviewList[slot4]:SetData(2, {
				slot8,
				slot9
			})
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.overviewList[slot4].gameObject_.transform)

			slot4 = slot4 + 1
		end

		for slot8, slot9 in pairs(slot2) do
			if not slot0.overviewList[slot4] then
				slot10 = Object.Instantiate(slot0.m_overviewItem, slot0.m_overviewContent)

				SetActive(slot10, true)

				slot0.overviewList[slot4] = PolyhedronDifficultyOverviewItem.New(slot10)
			end

			slot0.overviewList[slot4]:SetActive(true)
			slot0.overviewList[slot4]:SetData(1, slot9)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.overviewList[slot4].gameObject_.transform)

			slot4 = slot4 + 1
		end

		for slot9 = slot4, #slot0.overviewList do
			slot0.overviewList[slot9]:SetActive(false)
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_overviewContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)
end

function slot0.DifficultyClick(slot0, slot1)
	if slot0.maxDifficulty < PolyhedronDifficultyCfg[slot1].unlock_difficulty then
		return
	end

	slot0.selectDifficulty = slot1

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.difficultyGroupList) do
		slot5:Dispose()
	end

	slot0.difficultyGroupList = {}
	slot0.lockGoDict = {}

	for slot4, slot5 in ipairs(slot0.overviewList) do
		slot5:Dispose()
	end

	slot0.overviewList = {}

	uv0.super.Dispose(slot0)
end

return slot0
