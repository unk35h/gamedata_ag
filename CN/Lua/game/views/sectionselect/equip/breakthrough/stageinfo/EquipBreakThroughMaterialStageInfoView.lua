slot1 = class("EquipBreakThroughMaterialStageInfoView", import("game.views.sectionInfo.SectionInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	slot0.controller_:SetSelectedState("equipBTMaterial")

	slot0.infoController_ = ControllerUtil.GetController(slot0.equipBTPanel_.transform, "name")

	SetActive(slot0.resourcePanel_, false)
end

function slot1.OnClickBtn(slot0)
	slot1 = slot0.stageID_

	if EquipBreakThroughMaterialMapCfg[EquipBreakThroughMaterialData:GetChooseMapStageID()].stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		EquipBreakThroughMaterialAction.ChooseHeal(slot2, function (slot0)
			if isSuccess(slot0.result) then
				JumpTools.Back()
				manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_STAGE_UPDATE)
				ShowTips(string.format(GetTips("EQUIP_BREAK_THROUGH_TEAM_HEAL"), GameSetting.equip_crossroads_healing.value[1]))
			end
		end)
	elseif slot3.stage_type == EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF then
		JumpTools.Back()
		JumpTools.OpenPageByJump("equipBreakThroughMaterialBuffStage", {
			mapStageID = slot2
		})
	else
		slot0:Go("/sectionSelectHeroEquipBreakThrough", {
			section = slot1,
			sectionType = BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
		})
	end
end

function slot1.RefreshStageInfo(slot0)
	if slot0.oldCfgID_ ~= BattleEquipBreakThroughMaterialStageCfg[slot0.stageID_].id then
		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL, slot0.stageID_)
		slot0.sectionText_.text = string.format("%s-%s", slot2, slot3)
		slot0.sectionName_.text = slot1.name
		slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
		slot0.tipsText_.text = slot1.tips
		slot0.oldCfgID_ = slot1.id
	end

	if EquipBreakThroughMaterialMapCfg[EquipBreakThroughMaterialData:GetChooseMapStageID()].stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.BUFF and slot3.stage_type ~= EquipBreakThroughMaterialConst.EQUIP_BREAK_THROUGH_TYPE.HEAL then
		slot0.pointText_.text = EquipBreakThroughMaterialPointCfg[slot3.stage_type].stage_point[slot3.col]

		slot0.infoController_:SetSelectedState("true")
	else
		slot0.infoController_:SetSelectedState("false")
	end
end

function slot1.RefreshRewardPanel(slot0, slot1)
end

return slot1
