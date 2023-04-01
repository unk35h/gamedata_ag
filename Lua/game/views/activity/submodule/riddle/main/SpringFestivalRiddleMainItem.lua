slot0 = class("SpringFestivalRiddleMainItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityID_ = slot2
	slot0.questionID_ = slot3

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "riddlesBtn")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("springFestivalRiddleQuestion", {
			activityID = uv0.activityID_,
			questionID = uv0.questionID_
		})
	end)
end

function slot0.RefreshState(slot0, slot1)
	if table.keyof(SpringFestivalRiddleData:GetQuestionAnswerList(slot0.activityID_, slot0.questionID_), ActivitySpringFestivalRiddleCfg[slot0.questionID_].correct_answer) then
		slot0.controller_:SetSelectedState("finish")
	elseif slot1 == false then
		slot0.controller_:SetSelectedState("normal")
	else
		slot0.controller_:SetSelectedState("receive")
	end
end

return slot0
