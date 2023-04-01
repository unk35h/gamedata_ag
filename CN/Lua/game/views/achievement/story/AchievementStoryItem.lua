slot0 = class("AchievementStoryItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:SetData(slot2)
	slot0:Refresh()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonStory_, nil, function ()
		if AchievementData:GetStoryReadFlag(uv0.id_) ~= true then
			AchievementAction.ReadAchievementStory(uv0.id_, function (slot0)
				if isSuccess(slot0.result) then
					uv0:Refresh()
				else
					ShowTips(slot0.result)
				end
			end)
		end

		JumpTools.OpenPageByJump("/achievementStoryInfo", {
			storyID = uv0.id_
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1
	slot2 = AchievementStoryCfg[slot0.id_]
	slot0.textTitle_.text = slot2.name
	slot0.textTitle2_.text = slot2.name
end

function slot0.Refresh(slot0)
	if AchievementStoryCfg[slot0.id_].unlock_point <= AchievementData:GetAchievementPoint() then
		slot0.stateController_:SetSelectedState("unlock")
	else
		slot0.stateController_:SetSelectedState("lock")
	end

	if AchievementData:GetStoryReadFlag(slot0.id_) == true then
		SetActive(slot0.goRedPoint_, false)
	else
		SetActive(slot0.goRedPoint_, true)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
