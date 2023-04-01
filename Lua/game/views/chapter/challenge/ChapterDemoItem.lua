slot0 = class("ChapterDemoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:ClickItemListener()
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.chapterClientID_ = slot1

	if not ChapterClientCfg[slot0.chapterClientID_] then
		return
	end

	slot0.chapterName_.text = slot2.name

	SetSpriteWithoutAtlasAsync(slot0.chapterPaint_, SpritePathCfg.ChapterPaint.path .. slot2.chapter_paint)

	if slot0.chapterClientID_ == 601 then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.COOPERATION_DEMO)
	end

	if slot0:IsLock() then
		SetActive(slot0.lockGo_, true)
	else
		SetActive(slot0.lockGo_, false)
	end

	if slot0:GetLostTimeStr() == nil then
		SetActive(slot0.openGo_, false)
	else
		slot0:RefrenTime()
		SetActive(slot0.openGo_, true)
	end
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.ClickItemListener(slot0)
	if slot0:IsLock(true) then
		return
	end

	if slot0.chapterClientID_ == 601 and ActivityTools.GetActivityIsOpenWithTip(ActivityConst.COOPERATION_DEMO, true) then
		JumpTools.GoToSystem("/cooperationBlank/demoCooperationEntry")
	end
end

function slot0.RefrenTime(slot0)
	if slot0:GetLostTimeStr() then
		slot0.openText_.text = slot1
	else
		slot0.openText_.text = ""
	end
end

function slot0.GetLostTimeStr(slot0)
	if slot0.chapterClientID_ == 601 then
		if ActivityData:GetActivityData(ActivityConst.COOPERATION_DEMO) and slot1:IsActivitying() then
			return manager.time:GetLostTimeStr(slot1.stopTime)
		else
			return GetTips("TIME_OVER")
		end
	end

	return nil
end

function slot0.IsLock(slot0, slot1)
	if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[slot0.chapterClientID_].level and slot1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2.level))
	end

	return slot3
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
