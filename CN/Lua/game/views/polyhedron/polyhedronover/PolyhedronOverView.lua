slot0 = class("polyhedronOverView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronOverUI"
end

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.heroList = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.m_heroList, PolyhedronOverHeroItem)
	slot0.difficultyList = LuaList.New(handler(slot0, slot0.IndexDifficultyItem), slot0.m_affixList, PolyhedronOverDifficultyItem)
	slot0.beaconList = LuaList.New(handler(slot0, slot0.IndexBeaconItem), slot0.m_beaconList, PolyhedronOverBeaconItem)
	slot0.artifactGroupList = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.clickhandler = handler(slot0, slot0.PopInfo)
	slot0.clickLefthandler = handler(slot0, slot0.PopInfoLeft)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_closeBtn, nil, function ()
		PolyhedronAction.QueryPolyhedronReset()
	end)
	slot0:AddBtnListener(slot0.m_statisticsBtn, nil, function ()
		JumpTools.OpenPageByJump("battleStatisticsPolyhdronOver")
	end)
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		SetActive(uv0.m_infoGo, false)
	end)
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	SetActive(slot0.m_infoGo, false)

	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.polyhedronSettlement = PolyhedronData:GetPolyhedronSettlement()
	slot0.m_policyExpLab.text = slot0.polyhedronSettlement and slot0.polyhedronSettlement.decision_exp or -1
	slot0.m_terminalExpLab.text = slot0.polyhedronSettlement and slot0.polyhedronSettlement.terminal_exp or -1
	slot0.m_rankScoreText.text = slot0.polyhedronSettlement and slot0.polyhedronSettlement.point or -1
	slot0.m_difficultyLab.text = slot0.polyhedronInfo:GetDifficulty()
	slot2 = PolyhedronTierCfg[slot0.polyhedronInfo:GetTierId()]
	slot0.m_tierLab.text = slot2.tier .. "-" .. slot2.level
	slot0.fight_hero_id_list = slot0.polyhedronInfo:GetFightHeroList()

	slot0.heroList:StartScroll(#slot0.fight_hero_id_list)

	slot0.beacon_id_list = slot0.polyhedronInfo:GetBeaconList()

	slot0.beaconList:StartScroll(#slot0.beacon_id_list)

	if #slot0.beacon_id_list == 0 then
		SetActive(slot0.m_beaconText_, false)
	else
		SetActive(slot0.m_beaconText_, true)
	end

	slot0.difficulty = slot0.polyhedronInfo:GetDifficulty()
	slot8 = slot0.difficulty

	PolyhedronTools.CalPolyhedronDifficultyAttr({}, slot8)

	slot0.difficultyEffectList = {}

	for slot8, slot9 in pairs(PolyhedronTools.GetPolyhedronDifficultyAffixDir(slot0.difficulty)) do
		table.insert(slot0.difficultyEffectList, {
			up_type = 1,
			data = slot9
		})
	end

	for slot8, slot9 in pairs(slot4) do
		table.insert(slot0.difficultyEffectList, {
			up_type = 2,
			data = {
				slot8,
				slot9
			}
		})
	end

	slot8 = #slot0.difficultyEffectList

	slot0.difficultyList:StartScroll(slot8)

	slot0.artifact_list = slot0.polyhedronInfo:GetArtifactList()
	slot0.artifact_group_data = {}
	slot0.sub_type_list = {}

	for slot8, slot9 in ipairs(slot0.artifact_list) do
		if not slot0.artifact_group_data[PolyhedronArtifactCfg[slot9.id].sub_type] then
			slot0.artifact_group_data[slot11.sub_type] = {}
		end

		if not table.indexof(slot0.sub_type_list, slot11.sub_type) then
			table.insert(slot0.sub_type_list, slot11.sub_type)
		end

		table.insert(slot0.artifact_group_data[slot11.sub_type], slot9)
	end

	table.sort(slot0.sub_type_list, function (slot0, slot1)
		return slot1 < slot0
	end)

	slot5 = 1

	for slot9, slot10 in ipairs(slot0.sub_type_list) do
		slot11 = slot0.artifact_group_data[slot10]

		if not slot0.artifactGroupList[slot5] then
			slot0.artifactGroupList[slot5] = PolyhedronOverArtifactGroup.New(Object.Instantiate(slot0.m_artifactGroup, slot0.m_artifactContent))
		end

		slot0.artifactGroupList[slot5]:SetActive(true)
		slot0.artifactGroupList[slot5]:SetData(slot10, slot11)
		slot0.artifactGroupList[slot5]:RegistCallBack(slot0.clickhandler)

		slot5 = slot5 + 1
	end

	for slot10 = slot5, #slot0.artifactGroupList do
		slot0.artifactGroupList[slot10]:SetActive(false)
	end

	TimeTools.StartAfterSeconds(0.1, function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.m_artifactContent)
	end, {})
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.heroList:Dispose()
	slot0.difficultyList:Dispose()
	slot0.beaconList:Dispose()

	for slot4, slot5 in ipairs(slot0.artifactGroupList) do
		slot5:Dispose()
	end

	slot0.artifactGroupList = nil

	uv0.super.Dispose(slot0)
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot2:SetData(slot0.polyhedronInfo, slot0.fight_hero_id_list[slot1])
	slot2:RegistCallBack(slot0.clickLefthandler)
end

function slot0.IndexDifficultyItem(slot0, slot1, slot2)
	slot3 = slot0.difficultyEffectList[slot1]

	slot2:SetData(slot3.up_type, slot3.data)
	slot2:RegistCallBack(slot0.clickhandler)
end

function slot0.IndexBeaconItem(slot0, slot1, slot2)
	slot2:SetData(slot0.beacon_id_list[slot1])
	slot2:RegistCallBack(slot0.clickhandler)
end

function slot0.PopInfo(slot0, slot1, slot2, slot3, slot4)
	SetActive(slot0.m_infoGo, true)

	slot0.m_name.text = GetI18NText(slot1)
	slot0.m_desc.text = GetI18NText(slot2)

	if slot4 then
		slot0.m_levelText.text = "Lv" .. slot4
	else
		slot0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)

	slot9 = slot0.m_infoParent:InverseTransformPoint(slot0.m_rightAdaptTrans_:TransformPoint(Vector3(-slot0.m_rightAdaptTrans_.rect.width, slot0.m_rightAdaptTrans_:InverseTransformPoint(slot3).y, 0)))
	slot13 = 0

	if slot0.m_infoParent.rect.height / 2 < -slot0.m_infoParent:InverseTransformPoint(slot0.m_bottom:TransformPoint(Vector3(0, 0, 0))).y then
		slot13 = -slot11.y - slot12
	end

	slot0.m_infoTrans.localPosition = Vector3(slot9.x, slot9.y + slot13, slot9.z)
end

function slot0.PopInfoLeft(slot0, slot1, slot2, slot3, slot4)
	SetActive(slot0.m_infoGo, true)

	slot0.m_name.text = GetI18NText(slot1)
	slot0.m_desc.text = GetI18NText(slot2)

	if slot4 then
		slot0.m_levelText.text = "Lv" .. slot4
	else
		slot0.m_levelText.text = ""
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_textTrs)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_contentTrs)

	slot0.m_infoTrans.localPosition = slot0.m_infoParent:InverseTransformPoint(slot0.m_leftTrans:TransformPoint(Vector3(slot0.m_leftTrans.rect.width + slot0.m_infoTrans.rect.width, slot0.m_leftTrans:InverseTransformPoint(slot3).y, 0)))
	slot14 = 0

	if slot0.m_infoParent.rect.height / 2 < -slot0.m_infoParent:InverseTransformPoint(slot0.m_bottom:TransformPoint(Vector3(0, 0, 0))).y then
		slot14 = -slot12.y - slot13
	end

	slot0.m_infoTrans.localPosition = Vector3(slot10.x, slot10.y + slot14, slot10.z)
end

return slot0
