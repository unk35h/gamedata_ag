slot0 = class("AchievementInfoButton", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.achievementType_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		AchievementData:SetScrollRecord(false)
		uv0:Go("/achievementInfo", {
			achievementType = uv0.achievementType_
		})
	end)
end

function slot0.RefreshSelectType(slot0, slot1)
	slot2 = slot0.achievementType_ == slot1

	SetActive(slot0.selectMission_, slot2)
	SetActive(slot0.unselectMission_, not slot2)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
