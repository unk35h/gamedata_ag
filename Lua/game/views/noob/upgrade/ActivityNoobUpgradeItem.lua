slot0 = class("ActivityNoobUpgradeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "stage")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot1 = GameSetting.levelup_reward.value[uv0.index_][1]

		if uv0.isFinish_ and not table.keyof(ActivityNoobData:GetUpgradeFinishList(), slot1) then
			ActivityNoobAction.ReceiveUpgradeReward(slot1, function (slot0)
				if isSuccess(slot0.result) then
					getReward({
						uv0[2]
					})
					ActivityNoobData:SetUpgradeFinish(uv1)
					ActivityNoobAction.PlayerUpgradeRedPoint()
					uv2:ReceiveReward()
				else
					ShowTips(slot0.result)
				end
			end)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				rewardList = {
					slot0[2]
				}
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.disposed_ = true

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.isFinish_ = GameSetting.levelup_reward.value[slot0.index_][1] <= PlayerData:GetPlayerInfo().userLevel

	if slot0.isFinish_ then
		if table.keyof(ActivityNoobData:GetUpgradeFinishList(), slot2) then
			slot0:ReceiveReward()
		else
			slot0.controller_:SetSelectedState("1")
		end
	else
		slot0.controller_:SetSelectedState("0")
	end

	ItemTools.GetItemSpriteAsync(GameSetting.levelup_reward.value[slot0.index_][2][1], function (slot0, slot1)
		if uv0.disposed_ then
			return
		end

		if slot0 == uv1[2][1] then
			uv0.imageImg_.sprite = slot1
		end
	end)
end

function slot0.ReceiveReward(slot0)
	slot0.controller_:SetSelectedState("2")
end

return slot0
