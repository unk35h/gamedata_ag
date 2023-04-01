slot0 = class("NiewWorldBossRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.width = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.state == 1 then
			ActivityWorldBossAction.QueryHealthRward(uv0.activity_id, {
				uv0.index
			})
		elseif uv0.state == 2 then
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = true,
				rewardList = uv0.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = uv0.rewardList
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activity_id = slot1
	slot0.index = slot2
	slot4 = ActivityWorldBossCfg[slot1].health_reward_list[slot2]
	slot5 = slot4[1] / 10
	slot0.rewardList = getRewardFromDropCfg(slot4[2], true)
	slot0.m_lab.text = slot5 .. "%"
	slot0.transform_.localPosition = Vector3.New(slot0.width - slot0.width * slot5 / 100, 0, 0)
	slot0.state = ActivityWorldBossData:GetHealthRewardState(slot1, slot2)

	slot0.stateController:SetSelectedIndex(slot0.state)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
