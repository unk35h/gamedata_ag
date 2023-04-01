slot0 = class("ChapterChallengeItemView", import("..ChapterBaseItemView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddCountdown()
	slot0:AddRedPoint()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveCountdown()
	slot0:RemoveRedPoint()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.openGo_ = nil
	slot0.openText_ = nil
end

function slot0.RefreshCustomItem(slot0, slot1)
	if slot0.oldCfgID_ ~= slot1.id then
		SetSpriteWithoutAtlasAsync(slot0.chapterPaint_, SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.AddCountdown(slot0)
	if slot0:GetLockState() then
		slot0.openText_.text = ""

		return
	end

	slot0.openText_.text = string.format(GetTips("REFRESH_LOST_TIME"), manager.time:GetLostTimeStr(slot0:GetLostTime(), nil, true))
	slot0.timer_ = Timer.New(function ()
		uv0.openText_.text = string.format(GetTips("TIME_DISPLAY_1"), manager.time:GetLostTimeStr(uv0:GetLostTime(), nil, true))
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RemoveCountdown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetLostTime(slot0)
	return 0
end

function slot0.ClickItem(slot0, slot1)
	slot0:Go("/challenge", {
		chapterID = ChapterClientCfg[slot1].chapter_list[1]
	})
end

function slot0.AddRedPoint(slot0)
end

function slot0.RemoveRedPoint(slot0)
end

return slot0
