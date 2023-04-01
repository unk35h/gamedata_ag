slot0 = class("SequentialBattleFactoryView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukContinuousBattleMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectChapterHandler_ = handler(slot0, slot0.Update)
	slot0.difficultItemList_ = {}
	slot4 = slot0:GetActivityID()

	for slot4, slot5 in ipairs(ActivityCfg[slot4].sub_activity_list) do
		slot0.difficultItemList_[slot4] = SequentialBattleChapterItem.New(slot0.difficultItem_, slot0.difficultParent_, slot5)
	end

	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portraitImage_.transform)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SEQUENTIAL_BATTLE_DESC")
	slot0:Update()

	slot4 = SEQUENTIAL_BATTLE_SELECT_CHAPTER
	slot5 = slot0.selectChapterHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.difficultItemList_) do
		slot5:OnEnter()
	end

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_SELECT_CHAPTER, slot0.selectChapterHandler_)

	slot4 = slot0.rewardBtn_.transform
	slot5 = string.format

	manager.redPoint:unbindUIandKey(slot4, slot5("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot0.selectID_))

	for slot4, slot5 in ipairs(slot0.difficultItemList_) do
		slot5:OnExit()
	end

	slot0.selectID_ = nil

	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.difficultItemList_) do
		slot5:Dispose()
	end

	slot0.difficultItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buffBtn_, nil, function ()
		JumpTools.OpenPageByJump("sequentialBattleBuffInfo", {
			activityID = uv0.selectID_
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("sequentialBattleReward", {
			activityID = uv0.selectID_
		})
	end)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if ActivityData:GetActivityData(uv0.selectID_).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/sequentialBattleFactoryTeam", {
			activityID = uv0.selectID_
		})
	end)
end

function slot0.Update(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
	SequentialBattleAction.ClickDayRedPoint(slot0.selectID_)
end

function slot0.RefreshData(slot0)
	if slot0.selectID_ ~= SequentialBattleData:GetSelectChapterID(slot0:GetActivityID()) then
		if slot0.selectID_ then
			manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot0.selectID_))
		end

		manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.SEQUENTIAL_BATTLE_REWARD, slot2))
	end

	slot0.selectID_ = slot2
end

function slot0.RefreshUI(slot0)
	slot0:RefreshSelectChapter()
	slot0:RefreshReward()
	slot0:RefreshRightPanel()
end

function slot0.RefreshRightPanel(slot0)
	slot1 = SequentialBattleChapterCfg[slot0.selectID_]
	slot0.portraitImage_.sprite = getSpriteWithoutAtlas("Textures/MardukUI/boss/Portrait/" .. slot1.portrait)

	slot0.adaptImg_:AdaptImg()

	slot0.nameText_.text = slot1.stage_name
	slot0.descText_.text = slot1.stage_desc
end

function slot0.RefreshSelectChapter(slot0)
	for slot4, slot5 in ipairs(slot0.difficultItemList_) do
		slot5:RefreshSelect(slot0.selectID_)
	end
end

function slot0.RefreshReward(slot0)
end

function slot0.GetActivityID(slot0)
	return ActivityConst.FACTORY_SEQUENTIAL_BATTLE
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	if ActivityData:GetActivityData(slot0:GetActivityID()).stopTime <= manager.time:GetServerTime() then
		slot0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.timeText_.text = manager.time:GetLostTimeStr(slot3)
	slot0.timer_ = Timer.New(function ()
		if uv0 <= manager.time:GetServerTime() then
			uv1:StopTimer()

			uv1.timeText_.text = GetTips("TIME_OVER")

			return
		end

		uv1.timeText_.text = manager.time:GetLostTimeStr(uv0)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
