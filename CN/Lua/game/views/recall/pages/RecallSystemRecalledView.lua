slot1 = class("RecallSystemRecalledView", import("game.views.recall.pages.RecallPageBase"))

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.getController_ = ControllerUtil.GetController(slot0.rewardGo_.transform, "get")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, RecallSystemSignItem)
	slot0.recallRewardList_ = LuaList.New(handler(slot0, slot0.RecallRewardIndexItem), slot0.recallRewardListGo_, CommonItem)
end

function slot1.OnReceivedCodeReward(slot0)
	slot0:UpdateView()
	slot0.getController_:SetSelectedState("true")
end

function slot1.OnRecallSignUpdate(slot0)
	slot0:UpdateView()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.inputRecalledCodeBtn_, nil, function ()
		JumpTools.GoToSystem("RecallCodeInput")
	end)
	slot0:AddBtnListener(slot0.copyBtn_, nil, function ()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = ActivityRecallData:GetDataByPara("recallUserInfo").user_id
	end)
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:SetData(ActivityRecallData:GetDataByPara("signData")[slot1], slot1)
end

function slot1.RecallRewardIndexItem(slot0, slot1, slot2)
	if ActivityRecallData:GetDataByPara("recalledReward")[slot1] then
		slot2:RefreshData(formatReward(slot3[slot1]))
		slot2:RegistCallBack(function ()
			ShowPopItem(POP_ITEM, uv0[uv1])
		end)
		slot2:Show(true)
	else
		slot2:Show(false)
	end
end

function slot1.OnTop(slot0)
end

function slot1.UpdateView(slot0)
	ActivityRecallData:UpdateSignState()
	slot0.list_:StartScroll(#ActivityRecallData:GetDataByPara("signData"))
	slot0.recallRewardList_:StartScroll(#ActivityRecallData:GetDataByPara("recalledReward"))

	slot4 = ActivityRecallData:GetDataByPara("recallUserInfo")

	slot0.getController_:SetSelectedState(ActivityRecallData:GetDataByPara("isSubmit") and "true" or "false")

	if slot3 == true then
		slot0.recallNameTxt_.text = slot4.nick
		slot0.recallUIDTxt_.text = slot4.user_id
		slot0.recallHeadshotImg_.sprite = ItemTools.getItemSprite(slot4.icon)

		slot0.recallHeadshotImg_:SetNativeSize()
	end

	slot0.activityTimeTxt_.text = ActivityRecallData:GetDataByPara("recalledTime")
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

	if slot0.recallRewardList_ then
		slot0.recallRewardList_:Dispose()

		slot0.recallRewardList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
