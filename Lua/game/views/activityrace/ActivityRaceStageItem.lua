slot0 = class("ActivityRaceStageItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.selctController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.indexController_ = ControllerUtil.GetController(slot0.transform_, "index")

	SetActive(slot0.gameObject_, true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.isLock_ then
			slot0 = ActivityRaceCfg[uv0.activityID_].stage_list

			ShowTips(string.format(GetTips("ACTIVITY_RACE_UNLOCK"), BattleActivityRaceStageCfg[slot0[table.keyof(slot0, uv0.stageID_) - 1]].name))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		ActivityRaceData:SetSelectActivityID(uv0.activityID_)

		if uv0.selectCallBack_ ~= nil then
			uv0.selectCallBack_(uv0.index_, uv0.stageID_)
		end

		ActivityRaceData:SetTempActivityID(uv0.activityID_)
		uv0:Go("activityRaceSectionInfo", {
			section = uv0.stageID_,
			stageIndex = uv0.index_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.activityID_ = slot1
	slot0.stageID_ = slot2
	slot0.index_ = slot3
	slot0.isLock_ = slot4
	slot5 = ActivityRaceCfg[slot0.activityID_].stage_list
	slot0.isBossStage_ = slot0.stageID_ == slot5[#slot5]
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	if not slot0.isBossStage_ then
		slot0.indexController_:SetSelectedState(tostring(slot0.index_))
	end

	slot0.lockController_:SetSelectedState(tostring(slot0.isLock_))
	slot0:RefreshTitle()
	slot0:RefreshScore()
	slot0:RefreshCompleted()
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = BattleActivityRaceStageCfg[slot0.stageID_].name
end

function slot0.RefreshCompleted(slot0)
	if slot0.completedImageGo_ ~= nil then
		if ActivityRaceData:GetStateList()[slot0.activityID_].completedStageList[slot0.stageID_] == true then
			SetActive(slot0.completedImageGo_, true)
		else
			SetActive(slot0.completedImageGo_, false)
		end
	end
end

function slot0.RefreshScore(slot0)
	if slot0.isBossStage_ then
		SetActive(slot0.scorePanelGo_, true)

		slot0.scoreText_.text = ActivityRaceData:GetStateList()[slot0.activityID_].score
	else
		SetActive(slot0.scorePanelGo_, false)
	end
end

function slot0.RefreshSelect(slot0, slot1)
	if slot1 == slot0.stageID_ then
		slot0.selctController_:SetSelectedState("true")
	else
		slot0.selctController_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
	slot0.selctController_:SetSelectedState("false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
