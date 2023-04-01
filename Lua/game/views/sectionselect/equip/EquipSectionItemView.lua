slot0 = class("EquipSectionItemView", import("game.views.sectionSelect.SectionBaseItem"))

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("equipSectionInfo")
end

function slot0.InitCustom(slot0)
	SetActive(slot0.collectGo_, false)
	SetActive(slot0.storyIconGo_, false)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		uv0:Go("equipSectionInfo", {
			section = uv0.stageID_
		})
	end)
end

function slot0.RefreshData(slot0)
	slot0.level_ = BattleInstance.GetHardLevel(slot0.stageID_)
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetPosition()
	slot0.transform_.localPosition = Vector3(slot1[1], slot1[2], 0)

	SetActive(slot0.bgGo_, false)

	slot0.buttonImage_.sprite = getSprite("Atlas/BattleStage", "but_bg_a")
	slot0.isLock_ = JumpTools.IsConditionLocked({
		ViewConst.SYSTEM_LOCK_TYPE.LEVEL,
		GameSetting.equip_stage_unlock.value[slot0.level_]
	})

	if slot0.isLock_ then
		SetActive(slot0.lockGo_, true)
		SetActive(slot0.difficultGo_, false)
	else
		SetActive(slot0.lockGo_, false)
		SetActive(slot0.difficultGo_, false)
	end

	slot0:RefreshText()
end

function slot0.GetPosition(slot0)
	return BattleEquipStageCfg[slot0.stageID_] and slot1.position or {
		0,
		0
	}
end

function slot0.RefreshText(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP, slot0.stageID_)
	slot0.text_.text = string.format("%s%s", GetI18NText(slot1), slot2)
end

return slot0
