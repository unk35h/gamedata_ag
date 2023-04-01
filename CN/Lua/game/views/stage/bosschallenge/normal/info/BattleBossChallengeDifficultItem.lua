slot0 = class("BattleBossChallengeDifficultItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.lightGo_ = Object.Instantiate(slot3, slot4.transform)

	SetActive(slot0.lightGo_, true)

	slot0.difficult_ = slot5

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lightController_ = ControllerUtil.GetController(slot0.lightGo_.transform, "conName")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot6 = GetTips("BOSS_LEVEL_" .. slot5)
	slot0.textName_.text = slot6
	slot0.textName2_.text = slot6
	slot0.textName3_.text = slot6

	SetActive(slot0.gameObject_, true)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonSelect_, nil, function ()
		BattleBossChallengeNormalData:SetSelectDifficult(uv0.bossIndex_, uv0.difficult_)
		manager.notify:Invoke(BOSS_CHALLENGE_SWITCH_DIFFICULT, uv0.difficult_)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.bossIndex_ = slot1

	if BattleBossChallengeNormalData:GetFinishIndex(slot0.bossIndex_) < slot0.difficult_ then
		slot0.lightController_:SetSelectedState("1")
		slot0.lockController_:SetSelectedState("1")
	else
		slot0.lightController_:SetSelectedState("0")
		slot0.lockController_:SetSelectedState("0")
	end

	slot0.isLock_ = slot2
end

function slot0.SwitchDifficult(slot0, slot1)
	if slot0.difficult_ == slot1 then
		slot0.selectController_:SetSelectedState("0")
	else
		slot0.selectController_:SetSelectedState("1")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.lightGo_)
	Object.Destroy(slot0.gameObject_)

	slot0.lightGo_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
