slot0 = class("DemonChallengeMainView", ReduxView)

function slot0.UIName(slot0)
	return nil
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitGo(slot0, slot1)
	if slot0.gameObject_ then
		slot0:Dispose()
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot1), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnLevelSelect))
	slot0.tree_:SetRenderer(handler(slot0, slot0.LevelRenderer))

	slot0.levelControllerS_ = {}
	slot0.lockTextS_ = {}
	slot0.iconS_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = uv0.curSelectId_
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		JumpTools.OpenPageByJump("demonChallengeDifficultySelect", {
			selectId = uv0.curSelectId_
		})
	end)

	if slot0.talentBtn_ then
		slot0:AddBtnListener(slot0.talentBtn_, nil, function ()
			if TalentTreeTools.GetActivityIdByTheme(ActivityTools.GetActivityTheme(uv0.activityId_)) then
				JumpTools.OpenPageByJump("/talentTree", {
					activityId = slot1
				})
			end
		end)
	end
end

function slot0.InitTree(slot0)
	slot1 = UITreeData.New()

	for slot6 = 1, #ActivityData:GetActivityData(slot0.activityId_).subActivityIdList do
		UITreeGroupData.New().id = slot2[slot6]

		if BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(slot2[slot6], 1)] then
			slot7.text = slot9.name
		end

		slot1.groupDatas:Add(slot7)
	end

	slot0.tree_:SetData(slot1)
end

function slot0.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
	if not ActivityData:GetActivityData(slot2):IsActivitying() then
		if slot0.curLevelIndex_ and slot0.curLevelIndex_ ~= slot1 then
			if slot5.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot5.startTime)))
			end

			slot0.tree_:SelectGroup(slot0.curLevelIndex_)
		else
			slot0.isNeedExit_ = true
		end

		return
	end

	slot0:RefreshRewardRedPoint(slot0.curSelectId_, slot2)

	slot0.curLevelIndex_ = slot1
	slot0.curSelectId_ = slot2

	print("childId", childId)

	if getSpriteWithoutAtlas("Textures/VersionUI/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(slot0.curSelectId_, 1)].icon) then
		slot0.roleImg_.sprite = slot7
	end

	slot0:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(slot2)
end

function slot0.LevelRenderer(slot0, slot1, slot2)
	if slot0.levelControllerS_[slot1] == nil then
		slot0.levelControllerS_[slot1] = ControllerUtil.GetController(slot2.transform, "lock")
	end

	slot0.levelControllerS_[slot1]:SetSelectedState("false")

	slot0.lockTextS_[slot1] = slot0:FindCom(typeof(Text), "title/lock/text", slot2.transform)

	if slot0:FindTrs("title/icon", slot2.transform) then
		slot0.iconS_[slot1] = slot3:GetComponent(typeof(Image))
	end

	if slot0.iconS_[slot1] then
		slot0.iconS_[slot1].sprite = getSpriteWithoutAtlas("Textures/VersionUI/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(slot1, 1)].icon)
	end
end

function slot0.RefreshDescText(slot0)
	if BattleHeartDemonStageCfg[DemonChallengeTools.GetStageId(slot0.curSelectId_, 1)] then
		slot0.descText_.text = slot2.tips

		if slot0.titleText_ then
			slot0.titleText_.text = slot2.name
		end
	end
end

function slot0.RefreshTime(slot0)
	if ActivityData:GetActivityData(slot0.activityId_):GetRemainTime() >= 0 then
		slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot1.stopTime)
	end

	for slot6, slot7 in pairs(slot0.lockTextS_) do
		if ActivityData:GetActivityData(slot6):GetTimeBeforeStart() > 0 then
			slot0.levelControllerS_[slot6]:SetSelectedState("false")

			slot0.lockTextS_[slot6].text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot8.startTime))

			if slot0.iconS_[slot6] then
				slot0.iconS_[slot6].color = Color.gray
			end
		else
			slot0.levelControllerS_[slot6]:SetSelectedState("true")

			if slot0.iconS_[slot6] then
				slot0.iconS_[slot6].color = Color.white
			end
		end
	end
end

function slot0.RegisterRedPoint(slot0)
	for slot5 = 1, #ActivityData:GetActivityData(slot0.activityId_).subActivityIdList do
		manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot1[slot5]), RedPointConst.DEMON_CHALLENGE .. slot1[slot5])
	end
end

function slot0.UnRegisterRedPoint(slot0)
	for slot5 = 1, #ActivityData:GetActivityData(slot0.activityId_).subActivityIdList do
		manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot1[slot5]), RedPointConst.DEMON_CHALLENGE .. slot1[slot5])
	end

	if slot0.curSelectId_ then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. slot0.curSelectId_)
	end
end

function slot0.RefreshRewardRedPoint(slot0, slot1, slot2)
	if slot1 then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. slot1)
	end

	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.DEMON_CHALLENGE_REWARD .. slot2)
end

function slot0.StartUpdateTimer(slot0)
	slot0:StopUpdatTimer()
	slot0:RefreshTime()

	slot0.updateTimer_ = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.updateTimer_:Start()
end

function slot0.StopUpdatTimer(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.OnEnter(slot0)
	if not slot0.activityId_ or slot0.params_.activityId ~= slot0.activityId_ then
		slot0.activityId_ = slot0.params_.activityId

		slot0:InitGo(DemonChallengeTools.GetMainUIName(slot0.params_.activityId))
		slot0:InitTree()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_" .. slot0.activityId_)
	slot0:StartUpdateTimer()
	slot0:RegisterRedPoint()

	if slot0.params_.childId then
		if table.indexof(ActivityData:GetActivityData(slot0.activityId_).subActivityIdList, slot0.params_.childId) then
			slot0.tree_:SelectGroup(slot2)
		end

		slot0.params_.childId = nil
	elseif slot0.curLevelIndex_ then
		slot0.tree_:SelectGroup(slot0.curLevelIndex_)
	else
		slot0.tree_:SelectGroup(1)
	end

	if slot0.isNeedExit_ then
		ShowTips("TIME_OVER")

		slot0.timer_ = Timer.New(function ()
			JumpTools.Back()
		end, 0.2, 1)

		slot0.timer_:Start()
	end
end

function slot0.OnExit(slot0)
	slot0:StopUpdatTimer()
	slot0:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.tree_:Dispose()

	slot0.activityId_ = nil
end

return slot0
