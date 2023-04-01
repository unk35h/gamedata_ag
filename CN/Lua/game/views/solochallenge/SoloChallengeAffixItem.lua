slot0 = class("SoloChallengeAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockStateController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.equipController_ = ControllerUtil.GetController(slot0.transform_, "equiped")
	slot0.addController_ = ControllerUtil.GetController(slot0.transform_, "add")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.extra_ == false then
			JumpTools.OpenPageByJump("soloChallengeAffix", {
				activityID = uv0.activityID_,
				affixID = uv0.affixID_,
				pos = uv0.pos_,
				stageID = uv0.stageID_
			})

			return
		end

		uv0:SetSelect(true)
	end)

	if slot0.toggle_ ~= nil then
		slot0:AddToggleListener(slot0.toggle_, function (slot0)
			if uv0.selectController_ ~= nil then
				if slot0 then
					uv0.selectController_:SetSelectedState("on")
				else
					uv0.selectController_:SetSelectedState("off")
				end
			end
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.activityID_ = slot1
	slot0.affixID_ = slot2

	if slot3 ~= nil then
		slot0.toggle_.group = slot3
		slot0.extra_ = true
	else
		slot0.extra_ = false
	end
end

function slot0.SetState(slot0, slot1)
	slot0.stageID_ = slot1.stageID
	slot0.pos_ = slot1.pos

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.extra_ then
		slot0:RefreshFightOrder()
	end

	slot0:RefreshLockState()
	slot0:RefreshAffixImage()
	slot0:RefreshEquipState()
end

function slot0.RefreshFightOrder(slot0)
	slot1 = SoloChallengeData:GetSelectedDifficultyIndex(slot0.activityID_)

	if slot0.stageID_ ~= -1 and table.keyof(ActivitySoloChallengeCfg[slot0.activityID_].stage_id[slot1][2], slot0.stageID_) ~= nil then
		slot0.orderText_.text = slot2
	end
end

function slot0.RefreshAffixImage(slot0)
	slot1 = false

	if slot0.affixID_ ~= -1 then
		slot0.icon_.sprite = getAffixSprite(ActivityAffixPoolCfg[slot0.affixID_].affix)
		slot1 = true
	end

	if slot0.addController_ ~= nil then
		slot0.addController_:SetSelectedState(tostring(slot1))
	end
end

function slot0.RefreshEquipState(slot0)
	if slot0.equipController_ ~= nil then
		if slot0.stageID_ ~= -1 then
			slot0.equipController_:SetSelectedState("on")
		else
			slot0.equipController_:SetSelectedState("off")
		end
	end
end

function slot0.RefreshLockState(slot0)
	slot1 = false

	if table.keyof(SoloChallengeData:GetCompletedStageList(slot0.activityID_)[SoloChallengeData:GetSelectedDifficultyIndex(slot0.activityID_)], slot0.stageID_) then
		slot1 = true
	end

	if slot1 then
		slot0.btn_.interactable = false
	else
		slot0.btn_.interactable = true
	end

	if slot0.extra_ and slot0.lockStateController_ ~= nil then
		if slot1 then
			slot0.lockStateController_:SetSelectedState("lock")
		else
			slot0.lockStateController_:SetSelectedState("unlock")
		end
	end
end

function slot0.SetSelect(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot0.toggle_ then
		slot0.toggle_.isOn = slot1
	end

	if slot1 == true and slot0.selectCallBack_ then
		slot0.selectCallBack_(slot0.affixID_, slot0.pos_)
	end
end

function slot0.RegistSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.selectCallBack_ = nil
	slot0.selectController_ = nil
	slot0.lockStateController_ = nil
	slot0.equipController_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
