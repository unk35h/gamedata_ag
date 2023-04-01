slot0 = class("ChapterEquipItemView", import("..ChapterBaseItemView"))

function slot0.IsLock(slot0)
	slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION) and true or false

	if slot0.isLock_ then
		return
	end

	lvLimit = PlayerData:GetPlayerInfo().userLevel < GameSetting.equip_stage_unlock.value[1]
	slot0.isLock_ = lvLimit
end

function slot0.ClickItemListener(slot0)
	slot1 = slot0.chapterClientID_

	if slot0.isLock_ then
		ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)))

		return
	end

	slot0:ClickItem(slot1)
end

function slot0.Dispose(slot0)
	slot0.rewardIcon_.sprite = nil

	uv0.super.Dispose(slot0)

	slot0.rewardIcon_ = nil
	slot0.rewardName_ = nil
	slot0.lockImage_ = nil
end

function slot0.RefreshCustomItem(slot0, slot1)
	if slot0.oldCfgID_ ~= slot1.id then
		slot0.rewardName_.text = slot1.desc

		SetSpriteWithoutAtlasAsync(slot0.chapterPaint_, SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint)
		SetSpriteWithoutAtlasAsync(slot0.lockImage_, SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint)
		getSpriteWithoutAtlasAsync(slot0:GetIconPath() .. slot1.drop_icon, function (slot0)
			if uv0.rewardIcon_ == nil then
				return
			end

			uv0.rewardIcon_.sprite = slot0
		end)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.GetIconPath(slot0, slot1)
	return SpritePathCfg.EquipIcon.path
end

function slot0.ClickItem(slot0, slot1)
	if ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		JumpTools.OpenPageByJump("/equipSection", {
			chapterID = slot2
		}, ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		JumpTools.OpenPageByJump("/enchantment")

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
		JumpTools.OpenPageByJump("/daily", {
			chapterID = slot2
		})

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL then
		EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

		return
	end
end

return slot0
