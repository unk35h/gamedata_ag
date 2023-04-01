slot0 = class("ValentineGameView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetGameUIName(slot0.params_.mainActivityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot1 = 0

	for slot6, slot7 in ipairs(ActivityCfg[slot0.params_.mainActivityID].sub_activity_list) do
		for slot12, slot13 in ipairs(ActivityValentineCfg[slot7].qa_id) do
			if slot1 < #ActivityValentineWordCfg[slot13].answer_desc then
				slot1 = #ActivityValentineWordCfg[slot13].answer_desc or slot1
			end
		end
	end

	slot0.choose_ = {}
	slot0.chooseText_ = {}
	slot0.chooseName_ = {}
	slot0.chooseCanvasGroup_ = {}
	slot0.selfCon_ = {}
	slot0.otherCon_ = {}
	slot0.chooseCon_ = {}

	for slot6 = 1, slot1 do
		slot0.choose_[slot6] = slot0["choose_" .. slot6]
		slot0.chooseText_[slot6] = slot0["chooseText_" .. slot6]
		slot0.chooseName_[slot6] = slot0["chooseName_" .. slot6]
		slot0.chooseCanvasGroup_[slot6] = slot0["chooseCanvasGroup_" .. slot6]
		slot0.selfCon_[slot6] = ControllerUtil.GetController(slot0.choose_[slot6].transform, "self")
		slot0.otherCon_[slot6] = ControllerUtil.GetController(slot0.choose_[slot6].transform, "other")
		slot0.chooseCon_[slot6] = ControllerUtil.GetController(slot0.choose_[slot6].transform, "choosing")
	end

	slot0.indexCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "index")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.btnstateCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "btn")
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.choose_) do
		slot0:AddBtnListener(slot0.choose_[slot4], nil, function ()
			if uv0.curChoose_ ~= 0 then
				return
			end

			slot0 = ActivityValentineCfg[uv0.activityID_].qa_id[uv0.curIndex_]

			SDKTools.SendMessageToSDK("activity_valentine_opt", {
				question_id = slot0,
				answer_id = uv1
			})

			if ActivityValentineWordCfg[slot0].correct_answer == uv1 then
				uv0.correctCount_ = uv0.correctCount_ + 1
			end

			if uv0.curIndex_ >= #uv0.list_ then
				SDKTools.SendMessageToSDK("activity_valentine_over", {
					activity_id = uv0.correctCount_
				})
			end

			uv0.curChoose_ = uv1

			uv0.selfCon_[uv1]:SetSelectedState("true")
			uv0:StopTimer()
			uv0:Update()
		end)
	end

	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		uv0.curIndex_ = uv0.curIndex_ + 1

		uv0:Refresh()
	end)
	slot0:AddBtnListener(slot0.resultBtn_, nil, function ()
		if ActivityData:GetActivityData(uv0.mainActivityID_).startTime > manager.time:GetServerTime() or slot0 >= slot1.stopTime then
			ShowTips("TIME_OVER")
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityId = uv0.mainActivityID_
			})

			return
		end

		ValentineGameAction:SetPoint(uv0.activityID_, uv0.count_)
	end)
end

function slot0.OnEnter(slot0)
	slot0.count_ = 0
	slot0.curIndex_ = 1
	slot0.activityID_ = slot0.params_.activityID
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.correctCount_ = 0

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.cfg_ = ActivityValentineCfg[slot0.activityID_]
	slot4 = table.indexof

	slot0.indexCon_:SetSelectedState(slot4(ActivityCfg[slot0.params_.mainActivityID].sub_activity_list, slot0.activityID_))

	slot0.name_.text = slot0.cfg_.name
	slot0.list_ = slot0.cfg_.qa_id

	for slot4 = 1, #slot0.chooseName_ do
		slot0.chooseName_[slot4].text = slot0.cfg_.name
	end

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot0:Reset()
	slot0:RefreshTimer()
end

function slot0.Reset(slot0)
	slot0.curChoose_ = 0
	slot0.curAnsCfg_ = ActivityValentineWordCfg[slot0.list_[slot0.curIndex_]]

	for slot5 = 1, #slot0.curAnsCfg_.answer_desc do
		slot0.selfCon_[slot5]:SetSelectedState("false")
		slot0.otherCon_[slot5]:SetSelectedState("false")
		slot0.chooseCon_[slot5]:SetSelectedState("false")

		slot0.chooseCanvasGroup_[slot5].alpha = 1

		if slot0.curAnsCfg_.answer_desc[slot5] == "<nickname>" then
			slot0.chooseText_[slot5].text = PlayerData:GetPlayerInfo().nick
		else
			slot0.chooseText_[slot5].text = slot0.curAnsCfg_.answer_desc[slot5]
		end

		SetActive(slot0.choose_[slot5].gameObject, true)
	end

	for slot5 = #slot0.curAnsCfg_.answer_desc + 1, #slot0.choose_ do
		SetActive(slot0.choose_[slot5].gameObject, false)
	end

	slot0.title_.text = GetTips("TIP_QUESTION") .. GetTips("NUM_" .. slot0.curIndex_)
	slot0.desc_.text = slot0.curAnsCfg_.question_desc

	slot0.btnstateCon_:SetSelectedState("wait")
end

function slot0.RefreshTimer(slot0)
	slot0.think_.text = GetTips("TIP_SELECTING") .. "..."

	slot0.stateCon_:SetSelectedState("choosing")

	slot1 = math.random(3, 6)
	slot2 = 0
	slot0.timer_ = Timer.New(function ()
		if uv0 < uv1 then
			uv0 = uv0 + 1

			if uv0 % 3 == 1 then
				uv2.think_.text = GetTips("TIP_SELECTING") .. "."
			elseif slot0 == 2 then
				uv2.think_.text = GetTips("TIP_SELECTING") .. ".."
			else
				uv2.think_.text = GetTips("TIP_SELECTING") .. "..."
			end
		else
			uv2.think_.text = GetTips("TIP_SELECT_OVER")

			uv2:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.Update(slot0)
	slot0.otherCon_[slot0.curAnsCfg_.correct_answer]:SetSelectedState("true")

	slot0.ans_.text = slot0.curAnsCfg_.hero_comment[slot0.curChoose_]
	slot5 = "result"

	slot0.stateCon_:SetSelectedState(slot5)

	for slot5 = 1, #slot0.curAnsCfg_.answer_desc do
		if slot5 ~= slot1 and slot5 ~= slot0.curChoose_ then
			slot0.chooseCanvasGroup_[slot5].alpha = 0.4
		end
	end

	if slot0.curChoose_ == slot1 then
		slot0.count_ = slot0.count_ + 1
	end

	if slot0.curIndex_ < #slot0.list_ then
		slot0.btnstateCon_:SetSelectedState("next")
	else
		slot0.btnstateCon_:SetSelectedState("result")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnValentineResult(slot0)
	JumpTools.OpenPageByJump("/valentineResult", {
		mainActivityID = slot0.params_.mainActivityID,
		activityID = slot0.params_.activityID,
		point = slot0.count_
	})
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
