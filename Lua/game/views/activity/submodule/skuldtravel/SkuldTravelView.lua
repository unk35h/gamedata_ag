slot0 = class("SkuldTravelView", ReduxView)
slot1 = {
	{
		x = 368,
		y = -420
	},
	{
		x = -183,
		y = -352
	}
}
slot2 = {
	55,
	33
}

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelmain"
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

	slot0.cacheOpenPlotView_ = false
	slot0.skuldcontroller_ = ControllerUtil.GetController(slot0.mytrans_, "Skuld")
	slot0.btncontroller_ = ControllerUtil.GetController(slot0.btntrans_, "btnstatu")
	slot1 = slot0.skuldGo_
	slot0.skuldSpine_ = slot1:GetComponent("Spine.Unity.SkeletonGraphic")
	slot0.curState_ = "idle"
	slot0.statusAndNextStatus_ = {
		camera = {
			"idle",
			"sit"
		},
		idle = {
			"camera",
			"sit"
		},
		sit = {
			"camera",
			"idle",
			"sleep",
			"sleep"
		},
		sleep = {
			"sit"
		}
	}
	slot0.statusWaitCount_ = {
		sleep = 5,
		sit = 3,
		idle = 3,
		camera = 1
	}
	slot0.statusAndNextStatusAudio_ = {
		camera = {
			sit = "minigame_activity_1_6_up"
		},
		idle = {
			sit = "minigame_activity_1_6_up",
			camera = "minigame_activity_1_6_camera"
		},
		sit = {
			sleep = "minigame_activity_1_6_up",
			idle = "minigame_activity_1_6_down",
			camera = "minigame_activity_1_6_camera"
		},
		sleep = {
			sit = "minigame_activity_1_6_down"
		}
	}
	slot0.aniwait_ = slot0.statusWaitCount_[slot0.curState_]
end

function slot0.CreatTiemrAndStart(slot0)
	if slot0.skuldtimer_ == nil then
		slot0.skuldtimer_ = Timer.New(function ()
			if uv0.aniwait_ > 1 then
				uv0.aniwait_ = uv0.aniwait_ - 1
			else
				slot0 = uv0.statusAndNextStatus_[uv0.curState_]
				slot1 = math.random(#slot0)

				uv0:CheckSkuldPosition(uv0.curState_, slot0[slot1])
				uv0:PlaySkuldAudio(uv0.curState_, slot0[slot1])

				uv0.curState_ = slot0[slot1]

				uv0.skuldSpine_.AnimationState:SetAnimation(0, uv0.curState_, true)

				uv0.aniwait_ = uv0.statusWaitCount_[uv0.curState_]
			end
		end, 4, -1)
	end

	slot0.skuldtimer_:Start()
	slot0.skuldSpine_.AnimationState:SetAnimation(0, slot0.curState_, true)
	slot0:FixSkuldPosition()

	if slot0.curState_ == "camera" then
		manager.audio:PlayEffect("minigame_activity_1_6", "minigame_activity_1_6_camera", "")
	end
end

function slot0.CheckSkuldPosition(slot0, slot1, slot2)
	slot3 = slot0.skuldGo_.transform.localPosition
	slot4 = 0

	if (slot1 == "idle" or slot1 == "camera") and slot2 == "sit" then
		slot4 = uv0[slot0.curSkuldStatu_]
	end

	if slot1 == "sit" and (slot2 == "idle" or slot2 == "camera") then
		slot4 = -uv0[slot0.curSkuldStatu_]
	end

	slot0.skuldGo_.transform.localPosition = Vector3.New(slot3.x, slot3.y + slot4, slot3.z)
end

function slot0.FixSkuldPosition(slot0)
	if slot0.curState_ == "sit" or slot0.curState_ == "sleep" then
		slot1 = slot0.skuldGo_.transform.localPosition
		slot2 = 0
		slot0.skuldGo_.transform.localPosition = Vector3.New(slot1.x, slot1.y + uv0[slot0.curSkuldStatu_], slot1.z)
	end
end

function slot0.PlaySkuldAudio(slot0, slot1, slot2)
	manager.audio:PlayEffect("minigame_activity_1_6", slot0.statusAndNextStatusAudio_[slot1][slot2], "")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.gototravelbtn_, nil, function ()
		if SkuldTravelData:GetSkuldIsCanTravel() then
			uv0:Go("/skuldTravelMapView")
		end
	end)
	slot0:AddBtnListener(slot0.plotbtn_, nil, function ()
		uv0:Go("/skuldTravelShowPlotView")
	end)
	slot0:AddBtnListener(slot0.finalresultbtn_, nil, function ()
		uv0:Go("/skuldTravelFinalResultView")
	end)
	slot0:AddBtnListener(slot0.rewardbtn_, nil, function ()
		JumpTools.OpenPageByJump("skuldTravelRewardView")
	end)
end

function slot0.OnEnter(slot0)
	slot0:BindUIAndRedPoint()
end

function slot0.RandomSkuldPosition(slot0)
	slot1 = math.random(2)
	slot0.curSkuldStatu_ = slot1
	slot0.position_ = uv0[slot1]
	slot0.skuldGo_.transform.localPosition = Vector3.New(slot0.position_.x, slot0.position_.y, 0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("TRAVEL_SKULD_DESCRIPE")

	if slot0.cacheOpenPlotView_ then
		slot0.cacheOpenPlotView_ = false

		JumpTools.OpenPageByJump("skuldTravelResultView")
	end

	slot0:RandomSkuldPosition()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = SkuldTravelData:GetAttrib()

	for slot5 = 1, 4 do
		slot0["attribtext_" .. slot5].text = slot1[slot5]
	end

	slot0:RefreshStatu()
end

function slot0.RefreshStatu(slot0)
	if SkuldTravelData:GetSkuldBtnIsBreach() then
		slot0.skuldcontroller_:SetSelectedState("breach")
		SetActive(slot0.gototravelbtn_.gameObject, false)
		slot0:RemoveTiemr()

		return
	else
		SetActive(slot0.gototravelbtn_.gameObject, true)
	end

	if SkuldTravelData:GetSkuldStatu() == 0 then
		slot0.skuldcontroller_:SetSelectedState("home")
		slot0.btncontroller_:SetSelectedState("home")
		slot0:CreatTiemrAndStart()
	elseif SkuldTravelData:GetSkuldStatu() == 1 then
		slot0.skuldcontroller_:SetSelectedState("travel")
		slot0.btncontroller_:SetSelectedState("travel")
		slot0:RemoveTiemr()
	elseif SkuldTravelData:GetSkuldStatu() == 2 then
		slot0.skuldcontroller_:SetSelectedState("travel")
		slot0.btncontroller_:SetSelectedState("travel")
		slot0:RemoveTiemr()

		if slot0:IsOpenSkuldTravelingView() then
			slot0.cacheOpenPlotView_ = true
		else
			JumpTools.OpenPageByJump("skuldTravelResultView")
		end
	end
end

function slot0.OnSkuldStateChange(slot0)
	slot0:RandomSkuldPosition()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	slot0:RemoveTiemr()
	slot0:UnBindUIAndRedPoint()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
	manager.audio:StopEffect()
	slot0:RemoveTiemr()
end

function slot0.RemoveTiemr(slot0)
	if slot0.skuldtimer_ then
		slot0.skuldtimer_:Stop()

		slot0.skuldtimer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveTiemr()
	slot0.super.Dispose(slot0)
end

function slot0.BindUIAndRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.gototravelbtn_.transform, RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:bindUIandKey(slot0.finalresultbtn_.transform, RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:bindUIandKey(slot0.rewardbtn_.transform, RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.UnBindUIAndRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.gototravelbtn_.transform, RedPointConst.TRAVEL_SKULD_GOTOTRAVEL .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:unbindUIandKey(slot0.finalresultbtn_.transform, RedPointConst.TRAVEL_SKULD_ENDING .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	manager.redPoint:unbindUIandKey(slot0.rewardbtn_.transform, RedPointConst.TRAVEL_SKULD_REWARD .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.IsOpenSkuldTravelingView(slot0)
	return slot0:IsOpenRoute("skuldTravelTipsView")
end

return slot0
