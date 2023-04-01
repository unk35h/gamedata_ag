slot0 = class("GuildBossChallengeRewardItemView", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.gameObject_

	slot0:AddBtnListener(slot4:GetComponent(typeof(Button)), nil, function ()
		if not GuildData:HaveGetGuildBossPersonalReward(uv0.needScore_) and uv0.needScore_ <= uv0.score_ then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 1, uv0.needScore_)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = uv0.bonusDataList_
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.score_ = slot2
	slot0.needScore_ = slot0.data_[1]
	slot0.bonusDataList_ = slot0.data_[2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.scoreLabel_.text = slot0.needScore_

	if GuildData:HaveGetGuildBossPersonalReward(slot0.needScore_) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif slot0.needScore_ <= slot0.score_ then
		slot0.statusController_:SetSelectedState("canGet")
	else
		slot0.statusController_:SetSelectedState("cannotGet")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
