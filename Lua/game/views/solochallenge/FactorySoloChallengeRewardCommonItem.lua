slot1 = class("FactorySoloChallengeRewardCommonItem", import("game.views.skinTrialActivity.Factory.FactorySkinTrialRewardItem"))

function slot1.OnCtor(slot0, slot1)
	uv0.super.OnCtor(slot0, slot1)
	SetActive(slot0.gameObject_, true)
end

function slot1.SetData(slot0, slot1, slot2)
	SetActive(slot0.gameObject_, true)

	slot0.data_ = slot1
	slot0.popType_ = slot2

	slot0.commonItem_:RefreshData(formatReward(slot1))
	slot0.commonItem_:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)
	slot0.commonItem_:Show(true)
	slot0:RefreshText()
end

return slot1
