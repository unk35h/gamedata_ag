slot0 = class("PaperCutSelectItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.isLock_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		PaperCutData:SetSelectActivityID(uv0.activityID_)

		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.activityID_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot0.activityID_ == nil then
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, slot1, slot2))
	elseif slot0.activityID_ ~= slot2 then
		manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, slot1, slot0.activityID_))
		manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, slot1, slot2))
	end

	slot0.activityID_ = slot2
	slot0.mainActivityID_ = slot1
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	slot0:UnRegisterRedPoint()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshLock(slot0)
	if slot0.isLock_ == false then
		return
	end

	slot0.isLock_ = manager.time:GetServerTime() < slot0.startTime_

	if slot0.isLock_ == true then
		slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
	else
		slot0.statusController_:SetSelectedState("uncomplete")
	end
end

function slot0.RefreshUI(slot0)
	slot0.isLock_ = manager.time:GetServerTime() < slot0.startTime_

	if slot0.isLock_ == true then
		slot0.statusController_:SetSelectedState("lock")

		slot0.textTime_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime_))
	elseif PaperCutData:GetPlayedList(slot0.activityID_) == true then
		slot0.statusController_:SetSelectedState("completed")

		slot0.icon_.color = Color(1, 0.8117647058823529, 0.5294117647058824, 1)
		slot0.scoreText_.text = PaperCutData:GetScore(slot0.activityID_) or 0
	else
		slot0.statusController_:SetSelectedState("uncomplete")

		slot0.icon_.color = Color(0.7019607843137254, 0.5215686274509804, 0.4588235294117647, 1)
	end

	slot0:RefreshImage()
	slot0:RefreshTitle()
end

function slot0.RefreshImage(slot0)
	slot0.icon_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/paperCut/" .. PaperCutCfg[slot0.activityID_].picture)
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = PaperCutCfg[slot0.activityID_].name
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, slot0.mainActivityID_, slot0.activityID_))
end

return slot0
