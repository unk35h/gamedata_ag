slot0 = class("SpringFestivalGreetingLetterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/letter/EDream_letterpop_2"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.portraitImage_.transform)
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.commonItemView_:Dispose()

	slot0.commonItemView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0:GetActivityID()) then
			ShowTips("TIME_OVER")

			return
		end

		slot1 = SpringFestivalGreetingData

		SpringFestivalGreetingAction.GetGreetingReward(slot0, ActivityPointRewardCfg.get_id_list_by_activity_id[slot0][slot1:GetUnlockCnt(slot0)], function (slot0)
			if isSuccess(slot0.result) then
				getReward(ActivityPointRewardCfg[uv0].reward_item_list)
				uv1:RefreshReceiveState()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SPRING_FESTIVAL_GREETING
end

function slot0.RefreshUI(slot0)
	slot1 = slot0:GetActivityID()
	slot2 = SpringFestivalGreetingData:GetUnlockCnt(slot1)
	slot5 = ActivitySpringFestivalGreetingCfg[ActivitySpringFestivalGreetingCfg.get_id_list_by_activity_id[slot1][slot2]]
	slot0.portraitImage_.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/letter_role_title/" .. SkinCfg[slot5.story_name].picture_id)
	slot0.titleText_.text = string.format(GetTips("ACTIVITY_HERO_PRESENT"), HeroCfg[SkinCfg[slot5.story_name].hero].suffix)
	slot0.greetingText_.text = slot5.story_word
	slot9 = ActivityPointRewardCfg[ActivityPointRewardCfg.get_id_list_by_activity_id[slot1][slot2]].reward_item_list[1]

	if slot0.commonItemView_ == nil then
		slot0.commonItemView_ = CommonItem.New(slot0.itemGo_)
	end

	slot0.commonItemView_:RefreshData(formatReward(slot9))
	slot0.commonItemView_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
	slot0:RefreshReceiveState()
end

function slot0.RefreshReceiveState(slot0)
	slot1 = slot0:GetActivityID()

	if SpringFestivalGreetingData:GetReceiveCnt(slot1) == SpringFestivalGreetingData:GetUnlockCnt(slot1) then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
