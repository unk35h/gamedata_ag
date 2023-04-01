slot0 = class("EquipBreakThroughResultInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.stageData_ = slot1

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.timeText_.text = manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
	slot0.titleText_.text = BattleEquipBreakThroughMaterialStageCfg[slot0.stageData_:GetStageId()].name
	slot3 = EquipBreakThroughMaterialMapCfg[slot0.stageData_:GetServerExtant()]
	slot0.pointText_.text = EquipBreakThroughMaterialPointCfg[slot3.stage_type].stage_point[slot3.col]

	if BattleFieldData:GetBattleResultData().buffID == 0 then
		slot0.buffText_.text = ""
	else
		slot6, slot7 = nil

		if (EquipBreakThroughMaterialData:GetAttributeList()[slot4] or 1) == 1 then
			slot6 = 0
			slot7 = getAttributeAffixValue(slot4, 1)
		else
			slot6 = getAttributeAffixValue(slot4, slot5 - 1)
			slot7 = getAttributeAffixValue(slot4, slot5)
		end

		slot0.buffText_.text = string.format(EquipBreakThroughMaterialItemCfg[slot4].desc, (slot7 - slot6) / 10)
	end
end

return slot0
