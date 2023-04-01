slot0 = class("MailBoxRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
	slot0.haveGetController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveGet")
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
		OperationRecorder.Record("MailBoxRewardItem", "popItem")
	end)
end

function slot0.SetRewardData(slot0, slot1, slot2)
	slot0.rewardData_ = slot1
	slot0.haveGet_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData(formatReward(slot0.rewardData_))
	slot0.haveGetController_:SetSelectedState(slot0.haveGet_ and "true" or "false")
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
