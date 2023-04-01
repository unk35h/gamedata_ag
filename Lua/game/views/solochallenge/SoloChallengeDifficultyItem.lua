slot0 = class("SoloChallengeDifficultyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1.gameObject
	slot0.transform_ = slot1

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.completeController_ = ControllerUtil.GetController(slot0.transform_, "complete")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.Btn_, nil, function ()
		if uv0.selectCallBack_ then
			uv0.selectCallBack_(uv0.difficultyIndex_)
		end
	end)
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.difficultyIndex_ = slot2

	if slot0.completeController_ ~= nil then
		if table.keyof(SoloChallengeData:GetCompletedActivityList()[slot1], slot0.difficultyIndex_) ~= nil then
			slot0.completeController_:SetSelectedState("true")
		else
			slot0.completeController_:SetSelectedState("false")
		end
	end
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetSelect(slot0, slot1)
	if slot0.selectController_ ~= nil then
		if slot0.difficultyIndex_ == slot1 then
			slot0.selectController_:SetSelectedState("true")
		else
			slot0.selectController_:SetSelectedState("false")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.selectCallBack_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
