slot0 = class("PolyhedronPolicyRewardItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	if slot0.btn_ then
		slot0:AddBtnListener(slot0.btn_, nil, function ()
			PolyhedronAction.QueryPolicyReward(2, uv0.level_)
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.ID_ = slot1
	slot0.rewardCfg_ = PolyhedronPolicyCfg[slot0.ID_].rewards[1]
	slot0.level_ = PolyhedronPolicyCfg[slot0.ID_].level
	slot0.curLevel_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.levelText_.text = slot0.level_

	if slot0.commonItem_ == nil then
		slot0.commonItem_ = RewardPoolItem.New(slot0.rewardPanelGo_, slot0.rewardCfg_)
	else
		slot0.commonItem_:SetData(slot0.rewardCfg_)
	end

	slot1 = PolyhedronData:GetPolicyApplyList()

	if slot0.stateController_ then
		if slot1[slot0.level_] == true then
			slot0.stateController_:SetSelectedState("received")
		elseif slot0.level_ <= slot0.curLevel_ then
			slot0.stateController_:SetSelectedState("unreceive")
		else
			slot0.stateController_:SetSelectedState("uncomplete")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
