slot0 = class("SevenDaySignItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.info_ = slot2

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot1 = slot0.receivedpanelGo_
	slot0.animator_ = slot1:GetComponent(typeof(Animator))
	slot0.commonItem_ = CommonItem.New(slot0.commonitemGo_)
	slot1 = slot0.commonItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_SOURCE_ITEM, {
			slot0.id,
			slot0.number
		})
		OperationRecorder.Record(uv0.class.__cname, "signItem")
	end)
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot4 = SignCfg[slot2]

	slot0.commonItem_:RefreshData(formatReward(slot4.reward))

	slot5 = slot4.reward[1]

	if slot3 == ActivityConst.SIGN_STATE.NONE then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot6 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot6 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(slot0.receivedpanelGo_, true)
	elseif slot6 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(slot0.receivedpanelGo_, false)
	end

	slot0.dayText_.text = "" .. slot1

	SetActive(slot0.speciaBg_, slot1 == 7 or slot1 == 14)

	slot0.index = slot1
end

function slot0.StartPlayAnimator(slot0)
	SetActive(slot0.receivedpanelGo_, true)

	slot0.animator_.enabled = true

	manager.audio:PlayUIAudioByVoice("sign_in")
end

function slot0.GetAnimator(slot0)
	return slot0.animator_
end

function slot0.Dispose(slot0)
	slot0.animator_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
