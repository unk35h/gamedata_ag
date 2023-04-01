slot0 = class("RecallSystemRecallItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.getController = ControllerUtil.GetController(slot0.gameObject_.transform, "getted")

	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityRecallAction.RequireRecallReward(ActivityRecallData:GetDataByPara("recallActivityID"), uv0.data[1])
	end)
	slot0:AddBtnListener(slot0.item1Btn_, nil, function ()
		ShowPopItem(POP_ITEM, uv0.data[2])
	end)
	slot0:AddBtnListener(slot0.item2Btn_, nil, function ()
		ShowPopItem(POP_ITEM, uv0.data[3])
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.id = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.useNum = ActivityRecallData:GetDataByPara("codeUseNum")
	slot0.recallRewardList = ActivityRecallData:GetDataByPara("recallRewardList")

	if slot0.recallRewardList[slot0.id] == nil and slot0.data[1] <= slot0.useNum then
		slot0.getController:SetSelectedState("canget")
	else
		slot0.getController:SetSelectedState(slot0.recallRewardList[slot0.id] and "true" or "false")
	end

	slot0.inviteTxt_.text = string.format(GetTips("RECALLED_INVITE"), slot0.data[1])
	slot0.item1Img_.sprite = ItemTools.getItemSprite(slot0.data[2][1])
	slot0.item2Img_.sprite = ItemTools.getItemSprite(slot0.data[3][1])
	slot0.item1Txt_.text = "+" .. slot0.data[2][2]
	slot0.item2Txt_.text = "+" .. slot0.data[3][2]
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.getController = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
