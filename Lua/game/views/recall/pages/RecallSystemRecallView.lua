slot1 = class("RecallSystemRecallView", import("game.views.recall.pages.RecallPageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RecallSystemRecallItem)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(ActivityRecallData:GetDataByPara("recallReward")[slot1], slot1)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.CopyBtn_, nil, function ()
		ActivityRecallAction.RequireRecallShareCode(ActivityRecallData:GetDataByPara("recallActivityID"))
	end)
	slot0:AddBtnListener(slot0.recallInfoBtn_, nil, function ()
		ActivityRecallAction.RequireRecallInfo(ActivityRecallData:GetDataByPara("recallActivityID"))
	end)
end

function slot1.OnRecallRewardUpdate(slot0)
	slot0:UpdateView()
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	slot0.list_:StartScroll(#ActivityRecallData:GetDataByPara("recallReward"))

	slot0.recallCodeTxt_.text = ActivityRecallData:GetDataByPara("recallCode")
	slot0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recallTime")
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()
end

function slot1.OnExit(slot0)
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
