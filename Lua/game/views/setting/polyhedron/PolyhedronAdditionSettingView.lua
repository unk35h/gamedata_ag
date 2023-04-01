slot0 = class("PolyhedronAdditionSettingView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.clickTerminalHandler_ = handler(slot0, slot0.PopInfo)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_beaconTrs, function ()
		uv0:Select(1)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(nil, slot0.m_artifaceTrs, function ()
		uv0:Select(2)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(nil, slot0.m_talentTrs, function ()
		uv0:Select(3)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		SetActive(uv0.m_terminalDescGo, false)
	end)
end

function slot0.PopInfo(slot0, slot1, slot2, slot3)
	SetActive(slot0.m_terminalDescGo, true)

	slot0.m_terminalDescTrans.position = slot3
	slot0.m_terminalDescTitle.text = GetI18NText(slot1)
	slot0.m_terminalDesc.text = GetI18NText(slot2)
end

function slot0.Select(slot0, slot1)
	slot0.toggleController_1:SetSelectedIndex(slot1 == 1 and 1 or 0)
	slot0.toggleController_2:SetSelectedIndex(slot1 == 2 and 1 or 0)
	slot0.toggleController_3:SetSelectedIndex(slot1 == 3 and 1 or 0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot5 = PolyhedronSetBeaconItem
	slot0.beaconList = LuaList.New(handler(slot0, slot0.IndexBeaconItem), slot0.m_beaconList, slot5)
	slot0.toggleController_1 = ControllerUtil.GetController(slot0.m_beaconTrs, "toggle")
	slot0.toggleController_2 = ControllerUtil.GetController(slot0.m_artifaceTrs, "toggle")
	slot0.toggleController_3 = ControllerUtil.GetController(slot0.m_talentTrs, "toggle")
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.beacon_id_list = slot0.polyhedronInfo:GetBeaconList()
	slot4 = #slot0.beacon_id_list

	slot0.beaconList:StartScroll(slot4)

	slot0.artifactGroupList = {}

	slot0:RefreshArtifact()

	slot0.terminalGroupList = {}
	slot0.terminal_id_list = slot0.polyhedronInfo:GetTerminalIdList()
	slot0.terminal_group_data = {}

	for slot4, slot5 in ipairs(slot0.terminal_id_list) do
		if not slot0.terminal_group_data[PolyhedronTerminalCfg[slot5].classify] then
			slot0.terminal_group_data[slot6.classify] = {}
		end

		table.insert(slot0.terminal_group_data[slot6.classify], slot5)
	end

	slot1 = 1

	for slot5, slot6 in pairs(slot0.terminal_group_data) do
		if not slot0.terminalGroupList[slot1] then
			slot0.terminalGroupList[slot1] = PolyhedronSetTerminalGroup.New(Object.Instantiate(slot0.m_termianlGroup, slot0.m_termianlContent))
		end

		slot0.terminalGroupList[slot1]:SetActive(true)
		slot0.terminalGroupList[slot1]:SetData(slot5, slot6)
		slot0.terminalGroupList[slot1]:RegistCallBack(slot0.clickTerminalHandler_)

		slot1 = slot1 + 1
	end

	for slot6 = slot1, #slot0.terminalGroupList do
		slot0.terminalGroupList[slot6]:SetActive(false)
	end

	if table.length(slot0.terminal_group_data) > 0 then
		SetActive(slot0.m_terminalEmpty, false)
	else
		SetActive(slot0.m_terminalEmpty, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)

	slot0.data = clone(PolyhedronData:GetTerminalGift())
	slot0.allPoint = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point
	slot4 = PolyhedronData:GetTerminalLevel()
	slot5 = PolyhedronData:GetTerminalExp()
	slot0.m_levelLab.text = "" .. slot4

	if slot4 == #PolyhedronTerminalLevelCfg.all then
		slot0.m_expSlider.fillAmount = 1
		slot6 = PolyhedronTerminalLevelCfg[slot4].exp - PolyhedronTerminalLevelCfg[slot4 - 1].exp
		slot0.m_expLab.text = slot6 .. "/" .. slot6
	else
		slot6 = PolyhedronTerminalLevelCfg[slot4 + 1].exp - PolyhedronTerminalLevelCfg[slot4].exp
		slot0.m_expSlider.fillAmount = slot5 / slot6
		slot0.m_expLab.text = slot5 .. "/" .. slot6
	end

	slot0.m_pointLab.text = slot0.allPoint - slot0:GetUsePoint()
	slot0.clickhandler = handler(slot0, slot0.PopInfo)

	slot0:Select(1)
end

function slot0.OnEnter(slot0)
	SetActive(slot0.m_terminalDescGo, false)

	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	slot0:RefreshArtifact()
end

function slot0.RefreshArtifact(slot0)
	slot0.artifact_list = slot0.polyhedronInfo:GetArtifactList()
	slot0.artifact_group_data = {}

	for slot4, slot5 in ipairs(slot0.artifact_list) do
		if not slot0.artifact_group_data[PolyhedronArtifactCfg[slot5.id].sub_type] then
			slot0.artifact_group_data[slot7.sub_type] = {}
		end

		table.insert(slot0.artifact_group_data[slot7.sub_type], slot5)
	end

	slot1 = 1

	for slot5, slot6 in pairs(slot0.artifact_group_data) do
		if not slot0.artifactGroupList[slot1] then
			slot0.artifactGroupList[slot1] = PolyhedronSetArtifactGroup.New(Object.Instantiate(slot0.m_artifactGroup, slot0.m_artifactContent))
		end

		slot0.artifactGroupList[slot1]:SetActive(true)
		slot0.artifactGroupList[slot1]:SetData(slot5, slot6)
		slot0.artifactGroupList[slot1]:RegistCallBack(slot0.clickhandler)

		slot1 = slot1 + 1
	end

	for slot6 = slot1, #slot0.artifactGroupList do
		slot0.artifactGroupList[slot6]:SetActive(false)
	end

	if table.length(slot0.artifact_group_data) > 0 then
		SetActive(slot0.m_artifactEmpty, false)
	else
		SetActive(slot0.m_artifactEmpty, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_artifactContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_artifactContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_artifactContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.GetUsePoint(slot0)
	slot1 = 0

	for slot5, slot6 in pairs(slot0.data) do
		slot1 = slot1 + PolyhedronTerminalCfg[slot6].cost
	end

	return slot1
end

function slot0.IndexBeaconItem(slot0, slot1, slot2)
	slot2:SetData(slot0.beacon_id_list[slot1])
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.artifactGroupList) do
		slot5:Dispose()
	end

	slot0.artifactGroupList = nil

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
