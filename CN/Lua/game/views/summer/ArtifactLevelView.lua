slot0 = class("ArtifactLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummeDivinepersonalitytwoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Ctor(slot0)
	slot0.itemControllers_ = {}
	slot0.openTimeTextList_ = {}
	slot0.curAwardsList_ = {}
	slot0.isInit_ = false
	slot0.isFirstIn_ = true
	slot0.activityId_ = ActivityConst.SUMMER_ARTIFACT
end

function slot0.Init(slot0)
	slot0.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()
	slot0.levelCount_ = ArtifactLevelData:GetLevelCount()

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot5 = CommonItem
	slot0.awardList_ = LuaList.New(handler(slot0, slot0.AwardIndexItem), slot0.listGo_, slot5)
	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnLevelSelect))
	slot0.tree_:SetRenderer(handler(slot0, slot0.ItemRander))

	UITreeData.New().defaultIndex = ArtifactLevelData:GetCurLevelIndex() - 1

	for slot5 = 1, slot0.levelCount_ do
		slot6 = UITreeGroupData.New()
		slot6.id = slot5
		slot6.text = ArtifactLevelData:GetLevelNameByIndex(slot5)

		slot1.groupDatas:Add(slot6)
	end

	slot0.tree_:SetData(slot1)
end

function slot0.OnEnter(slot0)
	if slot0.isInit_ then
		slot0.curLevelIndex_ = ArtifactLevelData:GetCurLevelIndex()

		slot0:UpdateUI()

		slot0.timer_ = Timer.New(function ()
			slot1 = ArtifactLevelData
			slot3 = slot1

			for slot3 = 1, slot1.GetLevelCount(slot3) do
				if ArtifactLevelData:GetIsOpenByIndex(slot3) then
					if ArtifactLevelData:GetIsAwardedByIndex(slot3) then
						uv0.itemControllers_[slot3]:SetSelectedState("get")
					else
						uv0.itemControllers_[slot3]:SetSelectedState("unlock")
					end
				else
					uv0.itemControllers_[slot3]:SetSelectedState("lock")

					if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot3)).stopTime < manager.time:GetServerTime() then
						uv0.openTimeTextList_[slot3].text = string.format(GetTips("TIME_OVER"))
					else
						uv0.openTimeTextList_[slot3].text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot3)).startTime))
					end
				end
			end
		end, 1, -1)

		slot0.timer_:Start()
		slot0:RegisterRedPoint()
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SUMMER_ARTIFACT_DESCRIPE")
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	manager.windowBar:HideBar()
	slot0:UnRegisterRedPoint()
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.awardList_ then
		slot0.awardList_:Dispose()

		slot0.awardList_ = nil
	end

	slot0.super.Dispose(slot0)
end

function slot0.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
	if ArtifactLevelData:GetIsOpenByIndex(slot1) then
		slot0.curLevelIndex_ = slot1

		ArtifactLevelData:SetCurLevelIndex(slot1)
		ArtifactLevelData:SetSelectedByIndex(slot1)
		slot0:UpdateUI()
		ArtifactLevelData:UpdateRedPoint()
	elseif slot1 ~= slot0.curLevelIndex_ then
		slot0.tree_:SelectGroup(slot0.curLevelIndex_)

		if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot1)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot1)).startTime)))
		end
	end
end

function slot0.ItemRander(slot0, slot1, slot2)
	slot0:BindCfgUI(slot2)

	slot0.itemControllers_[slot1] = ControllerUtil.GetController(slot2.transform, "lock")

	if ArtifactLevelData:GetIsAwardedByIndex(slot1) then
		slot0.itemControllers_[slot1]:SetSelectedState("get")
	elseif ArtifactLevelData:GetIsOpenByIndex(slot1) then
		slot0.itemControllers_[slot1]:SetSelectedState("unlock")
	end

	slot0.openTimeTextList_[slot1] = slot0.openTimeText_

	if ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot1)).stopTime < manager.time:GetServerTime() then
		slot0.openTimeTextList_[slot1].text = string.format(GetTips("TIME_OVER"))
	else
		slot0.openTimeTextList_[slot1].text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(slot1)).startTime))
	end

	slot0.levelNumText_.text = "0" .. slot1
	slot0.isInit_ = true
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnStart_, nil, function ()
		if ArtifactLevelData:GetIsOpenByIndex(uv0.curLevelIndex_) then
			uv0:Go("/sectionSelectHero", {
				section = ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByIndex(uv0.curLevelIndex_)].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.ARTIFACT,
				activityID = ActivityConst.SUMMER_ARTIFACT
			})
		elseif ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(uv0.curLevelIndex_)).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ArtifactLevelData:GetLevelIdByIndex(uv0.curLevelIndex_)).startTime)))
		end
	end)
end

function slot0.UpdateUI(slot0)
	if slot0.isInit_ then
		slot0.levelNameText_.text = ArtifactLevelData:GetLevelNameByIndex(slot0.curLevelIndex_)
		slot0.descText_.text = ArtifactLevelData:GetLevelDesc(slot0.curLevelIndex_)
		slot0.curAwardsList_ = getRewardFromDropCfg(ArtifactLevelData:GetAwardListByIndex(slot0.curLevelIndex_), true)

		slot0.awardList_:StartScroll(#slot0.curAwardsList_)
		ArtifactLevelData:UpdateRedPoint()
	end
end

function slot0.AwardIndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.curAwardsList_[slot1]))

	slot4 = ControllerUtil.GetController(slot2.transform_, "received")

	if ArtifactLevelData:GetIsAwardedByIndex(slot0.curLevelIndex_) then
		slot4:SetSelectedState("true")
	else
		slot4:SetSelectedState("false")
	end

	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.RegisterRedPoint(slot0)
	slot2 = ArtifactLevelData
	slot4 = slot2

	for slot4 = 1, slot2.GetLevelCount(slot4) do
		manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(slot4)))
	end
end

function slot0.UnRegisterRedPoint(slot0)
	slot2 = ArtifactLevelData
	slot4 = slot2

	for slot4 = 1, slot2.GetLevelCount(slot4) do
		manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), string.format("%s_%s", RedPointConst.ARTIFACT, ArtifactLevelData:GetLevelIdByIndex(slot4)))
	end
end

return slot0
