slot0 = class("CowboyMainView", ReduxView)

function slot0.UIName(slot0)
	return CowboyTools.GetMainUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CowboyItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.activityID_, slot0.list_[slot1])
	slot2:RefreshLevelText(slot1)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("cowBoyReward", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("cowBoyInfo", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.audio:PlayEffect("minigame_activity_1_3", "minigame_entrance_animation", "")
	slot0:GetActivityData()
	slot0:RefreshUI()
	slot0:BindUIRedPoint()
end

function slot0.GetActivityData(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshUI(slot0)
	slot0:RefreshList()
	slot0:RefreshTime()
end

function slot0.RefreshList(slot0)
	slot0.list_ = ActivityCfg[slot0.activityID_].sub_activity_list
	slot0.lastLevel_ = CowboyData:GetLastLevel(slot0.activityID_)

	if not slot0.lastLevel_ or not table.indexof(slot0.list_, slot0.lastLevel_) then
		slot0.scrollHelper_:StartScroll(#slot0.list_)
	else
		slot0.scrollHelper_:StartScroll(#slot0.list_, table.indexof(slot0.list_, slot0.lastLevel_))
	end
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ and slot0.activityData_:IsActivitying() == false then
		slot0.timeTxt_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeTxt_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.stopTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end

			uv1.timeTxt_.text = manager.time:GetLostTimeStr(uv1.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeTxt_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindUIRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. slot0.activityID_)
end

function slot0.UnBindUIRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.COWBOY_REWARD .. "_" .. slot0.activityID_)
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnBindUIRedPoint()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
