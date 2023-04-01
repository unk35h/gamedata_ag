slot0 = class("HeartLinkItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(slot1, slot1.transform.parent.transform)
	slot0.transform_ = slot1.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.canRead_ = false
	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.RegisterRefresh(slot0, slot1)
	slot0.RefreshParentLayout_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.unlockbtnBtn_, nil, function ()
		uv0:SetUnlockState(true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.itemTrs_)
		uv0.RefreshParentLayout_(uv0.ID_)
		SDKTools.SendMessageToSDK("record_unlock", {
			record_id = uv0.archiveID_,
			chain_id = uv0.ID_
		})

		if uv0.canRead_ then
			HeroAction.ReadHeartLink(uv0.archiveID_, uv0.ID_)

			uv0.canRead_ = false
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.archiveID_ = slot1
	slot0.ID_ = slot2.id
	slot3, slot4, slot5 = nil
	slot4 = slot2.current
	slot5 = slot2.all
	slot7 = ConditionCfg[GameSetting.heart_chain_unlock_condition.value[slot0.ID_]]

	if not slot2.isUnlock then
		slot0.controller_:SetSelectedState("lock")

		slot0.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), slot0.ID_)
		slot0.textconditionText_.text = slot7.desc
	else
		slot0:SetUnlockState()

		slot0.locktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), slot0.ID_)
		slot0.unlocktexttitleText_.text = string.format(GetTips("HERO_RECORD_HEART_CHAIN"), slot0.ID_)
		slot0.textinfoText_.text = HeroRecordCfg[slot0.archiveID_]["heart_chain" .. slot0.ID_]
	end

	slot0.canRead_ = not ArchiveData:IsHeartRead(slot0.archiveID_, slot0.ID_) and slot3
end

function slot0.SetUnlockState(slot0, slot1)
	if slot1 or ArchiveData:IsHeartRead(slot0.archiveID_, slot0.ID_) then
		slot0.controller_:SetSelectedState("unlock_open")
	else
		slot0.controller_:SetSelectedState("unlock_close")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.itemTrs_)
	slot0.RefreshParentLayout_()
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
