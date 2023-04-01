slot0 = class("DailySignItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.Dispose(slot0)
	slot0.animator_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
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

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1)
	slot0.info_ = slot1

	slot0:RefreshItem()
	slot0:RefreshReceiveState()
	SetActive(slot0.gameObject_, true)
end

function slot0.RefreshItem(slot0)
	slot1 = 0

	slot0.commonItem_:RefreshData(formatReward(SignCfg[(not slot0.info_.month or SignCfg.get_id_list_by_month[slot0.info_.month][slot0.info_.day]) and slot0.info_.day].reward))
end

function slot0.RefreshReceiveState(slot0)
	if slot0.info_.state == ActivityConst.SIGN_STATE.NONE then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot1 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot1 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(slot0.receivedpanelGo_, true)
	elseif slot1 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(slot0.receivedpanelGo_, false)
	end
end

function slot0.StartPlayAnimator(slot0)
	SetActive(slot0.receivedpanelGo_, true)

	slot0.animator_.enabled = true

	manager.audio:PlayUIAudioByVoice("sign_in")
end

function slot0.GetAnimator(slot0)
	return slot0.animator_
end

return slot0
