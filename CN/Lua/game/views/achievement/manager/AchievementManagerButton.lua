slot0 = class("AchievementManagerButton", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.achievementType_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		AchievementData:SetScrollRecord(false)
		uv0:Go("/achievementInfo", {
			achievementType = uv0.achievementType_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.imageProcess_.fillAmount = AchievementData:GetFinishAchievementCnt(slot0.achievementType_) / AchievementData:GetAchievementCnt(slot0.achievementType_)

	SetActive(slot0.goTips_, manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot0.achievementType_)) > 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
