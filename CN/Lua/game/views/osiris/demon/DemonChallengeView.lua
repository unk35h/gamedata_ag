slot0 = class("DemonChallengeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisDemonUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.inited = false
	slot0.curLevelIndex_ = slot0.params_.levelIndex
	slot0.levelCount_ = DemonChallengeData:GetLevelCount()
	slot0.levelControllers_ = {}
	slot0.lastOpenStatusList_ = {}

	for slot4 = 1, slot0.levelCount_ do
		slot0.lastOpenStatusList_[slot4] = false
	end

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.inited = true
	slot0.tiemOut_ = false
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.openTimeTextList_ = {}
	slot0.levelNameTextList_ = {}
	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnLevelSelect))
	slot0.tree_:SetRenderer(handler(slot0, slot0.LevelRenderer))

	slot1 = UITreeData.New()

	for slot5 = 1, slot0.levelCount_ do
		slot6 = UITreeGroupData.New()
		slot6.id = slot5
		slot6.text = "group" .. slot5

		slot1.groupDatas:Add(slot6)
	end

	slot0.tree_:SetData(slot1)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_OSIRIS_HEART_DEMON_CHALLENGE_DESCRIPE")

	if slot0.curLevelIndex_ == nil then
		slot0.curLevelIndex_ = DemonChallengeData:GetCacheSelectLevelIndex() or DemonChallengeData:GetAnyOpen()
	end

	slot0:AddUpdateTimer()
	slot0:RefreshTime()
	slot0:RegisterRedPoint()
end

function slot0.OnTop(slot0)
	if slot0.curLevelIndex_ == -1 then
		print("********** 没有一个关卡是开启的 ***************")
		slot0:Back()

		return
	end

	slot0.tree_:SelectGroup(slot0.curLevelIndex_)
end

function slot0.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
	if not slot0.inited then
		return
	end

	if not DemonChallengeData:IsOpened(slot1) then
		slot5, slot6 = GetTips("OPEN_TIME")

		manager.tips:ShowTips(string.format(slot5, manager.time:GetLostTimeStr(DemonChallengeData:GetLevelOpenTimeByIndex(slot1))), slot6)
		slot0.tree_:SelectGroup(slot0.curLevelIndex_)

		return
	end

	slot0:RefreshRewardRedPoint(slot0.curLevelIndex_, slot1)
	DemonChallengeData:SaveSelectLevelIndex(slot1)

	if DemonChallengeData:IsSelected(slot1) == false and not slot0.tiemOut_ then
		DemonChallengeData:SaveSelected(slot1)
	end

	slot0.curLevelIndex_ = slot1

	slot0:RefreshUI()
end

function slot0.LevelRenderer(slot0, slot1, slot2)
	slot0:BindCfgUI(slot2)

	slot0.levelControllers_[slot1] = ControllerUtil.GetController(slot2.transform, "lock")

	slot0.levelControllers_[slot1]:SetSelectedState("false")

	slot0.openTimeTextList_[slot1] = slot0.openTimeText_
	slot0.levelNameTextList_[slot1] = slot0.levelNameText_

	slot0:RefreshLevelName(slot1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeReward", {
			levelIndex = uv0.curLevelIndex_
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if uv0.tiemOut_ then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/demonChallengeSelect", {
			levelIndex = uv0.curLevelIndex_
		})
	end)
end

function slot0.RegisterRedPoint(slot0)
	for slot4 = 1, slot0.levelCount_ do
		manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), RedPointConst[DemonChallengeData:GetRedPointConst(slot4)])
	end
end

function slot0.UnRegisterRedPoint(slot0)
	for slot4 = 1, slot0.levelCount_ do
		manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), RedPointConst[DemonChallengeData:GetRedPointConst(slot4)])
	end

	if slot0.curLevelIndex_ ~= -1 then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst[DemonChallengeData:GetRedPointConst(slot0.curLevelIndex_)])
	end
end

function slot0.RefreshRewardRedPoint(slot0, slot1, slot2)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst[DemonChallengeData:GetRedPointConst(slot1)])
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst[DemonChallengeData:GetRedPointConst(slot2)])

	if not DemonChallengeData:IsCompletedLevel(slot2) then
		manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst[slot3])
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDescText()
	slot0:RefreshRoleImg()
end

function slot0.RefreshRoleImg(slot0)
	slot0.roleImg_.sprite = DemonChallengeData:GetRoleImg(slot0.curLevelIndex_)

	slot0:AdaptImage()
end

function slot0.AdaptImage(slot0)
	if slot0.roleImageAdaptor_ == nil then
		slot0.roleImageAdaptor_ = slot0:FindCom("AdaptImage", nil, slot0.roleImageTrs_)
	end

	slot0.roleImageAdaptor_:AdaptImg()
end

function slot0.RefreshLevelName(slot0, slot1)
	slot0.levelNameTextList_[slot1].text = DemonChallengeData:GetLevelName(slot1)
end

function slot0.RefreshTime(slot0)
	if DemonChallengeData:GetRemainTime() - manager.time:GetServerTime() > 0 then
		slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot1)
	else
		DemonChallengeData:SetAllRedPoint(0)

		slot0.tiemOut_ = true
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		slot0:RemoveUpdatTimer()

		return
	end

	if slot0.levelControllers_ ~= nil then
		for slot5, slot6 in pairs(slot0.levelControllers_) do
			if slot0.lastOpenStatusList_[slot5] == false then
				if DemonChallengeData:GetLevelOpenTimeByIndex(slot5) - manager.time:GetServerTime() <= 0 == true then
					slot6:SetSelectedState("true")
					DemonChallengeData:CalcRedPoint()
				else
					slot0:RefreshOpenTimeText(slot5, slot8)
				end

				slot0.lastOpenStatusList_[slot5] = slot9
			end
		end
	end
end

function slot0.RefreshOpenTimeText(slot0, slot1, slot2)
	slot0.openTimeTextList_[slot1].text = string.format("%s后开启", manager.time:GetLostTimeStr(slot2))
end

function slot0.RefreshDescText(slot0)
	slot0.descText_.text = DemonChallengeData:GetDescText(slot0.curLevelIndex_)
end

function slot0.AddUpdateTimer(slot0)
	slot0:RemoveUpdatTimer()

	slot0.updateTimer_ = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	if slot0.updateTimer_ then
		slot0.updateTimer_:Start()
	end
end

function slot0.RemoveUpdatTimer(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveUpdatTimer()
	slot0:UnRegisterRedPoint()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
