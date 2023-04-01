slot0 = class("ChapterEquipBreakThroughMaterialItemView", import(".ChapterEquipItemView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL, {
		x = 195.4,
		y = 296
	})

	if slot0.isLock_ then
		SetActive(slot0.timeGo_, false)
	else
		SetActive(slot0.timeGo_, true)
	end

	slot0:AddRefreshTimer()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.EQUIP_BREAK_THROUGH_MATERIAL)
	slot0:StopRefreshTimer()
end

function slot0.IsLock(slot0)
	slot0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL) and true or false
end

function slot0.GetIconPath(slot0, slot1)
	return SpritePathCfg.ItemIcon.path
end

function slot0.ClickItemListener(slot0)
	slot1 = slot0.chapterClientID_

	if slot0.isLock_ then
		ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL, JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL)))

		return
	end

	slot0:ClickItem(slot1)
end

function slot0.AddRefreshTimer(slot0)
	slot0:StopRefreshTimer()

	slot0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(EquipBreakThroughMaterialData:GetRefreshTimestamp(), nil, true))
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(EquipBreakThroughMaterialData:GetRefreshTimestamp(), nil, true))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopRefreshTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
