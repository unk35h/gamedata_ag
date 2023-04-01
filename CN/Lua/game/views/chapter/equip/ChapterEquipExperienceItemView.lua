slot0 = class("ChapterEquipExperienceItemView", import(".ChapterEquipItemView"))

function slot0.IsLock(slot0)
	slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.EQUIP_EXPERIENCE) and true or false

	if slot0.isLock_ then
		return
	end

	slot0.isLock_ = PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[slot0.chapterClientID_].level
end

function slot0.GetIconPath(slot0, slot1)
	return SpritePathCfg.ItemIcon.path
end

function slot0.ClickItemListener(slot0)
	slot1 = slot0.chapterClientID_

	if slot0.isLock_ then
		ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.EQUIP_EXPERIENCE, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.EQUIP_EXPERIENCE)))

		return
	end

	slot0:ClickItem(slot1)
end

return slot0
