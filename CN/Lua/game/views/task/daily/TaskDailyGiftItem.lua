slot0 = class("TaskDailyGiftItem", ReduxView)
slot1 = import("game.const.ActivityPtConst")

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.parent_ = slot2

	SetActive(slot0.gameObject_, true)

	slot0.index_ = slot3
	slot0.pointType_ = slot4

	slot0:Init()
end

function slot0.SetIndex(slot0, slot1)
	slot0.index_ = slot1

	slot0:RefrshUI()
	slot0:RefreshGift()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefrshUI()
	slot0:RefreshGift()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.valueText_ = slot0:FindCom(typeof(Text), "value")
	slot0.giftBtn_ = slot0:FindCom(typeof(Button), "giftBtn")
	slot0.canReceiveGo_ = slot0:FindGo("giftBtn/unlock")
	slot0.alreadyReceiveGo_ = slot0:FindGo("giftBtn/unuse")
	slot0.lockReceiveGo_ = slot0:FindGo("giftBtn/lock")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.giftBtn_, nil, function ()
		slot0 = ActivityPtCfg[uv0.pointType_].reward[uv0.index_]

		if uv0:GetIsReceived() then
			-- Nothing
		elseif uv0:GetCanReceive() then
			ActivityPtAction:TaskDailyGetReward(uv0.index_, uv0.pointType_)

			return
		end

		OperationRecorder.Record(uv0.class.__cname, "rewardPreview")
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = slot0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.giftBtn_.onClick:RemoveAllListeners()
end

function slot0.GetCanReceive(slot0)
	return ActivityPtCfg[slot0.pointType_].target[slot0.index_] <= ActivityPtData:GetCurrentActivityPt(slot0.pointType_)
end

function slot0.GetIsReceived(slot0)
	if ActivityPtData:GetDailyGetRewardList()[slot0.pointType_][ActivityPtCfg[slot0.pointType_].target[slot0.index_]] then
		return true
	end

	return false
end

function slot0.RefrshUI(slot0)
	slot2 = slot0.transform_.parent.transform.rect.width
	slot3 = ActivityPtData:GetGiftPt(slot0.pointType_, slot0.index_)
	slot4 = ActivityPtData:GetTotalPt(slot0.pointType_)
	slot0.transform_.anchorMin = Vector2(slot3 / slot4, 0.5)
	slot0.transform_.anchorMax = Vector2(slot3 / slot4, 0.5)
	slot0.valueText_.text = slot3
end

function slot0.RefreshGift(slot0)
	SetActive(slot0.canReceiveGo_, false)
	SetActive(slot0.alreadyReceiveGo_, false)
	SetActive(slot0.lockReceiveGo_, false)

	if slot0:GetIsReceived() then
		SetActive(slot0.alreadyReceiveGo_, true)
	elseif slot0:GetCanReceive() then
		SetActive(slot0.canReceiveGo_, true)
	else
		SetActive(slot0.lockReceiveGo_, true)
	end
end

return slot0
