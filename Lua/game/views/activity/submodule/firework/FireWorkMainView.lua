slot0 = class("FireWorkMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/Firework/FireworkMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.headList = LuaList.New(handler(slot0, slot0.IndexHeadItem), slot0.m_roleList, FireWorkHeadItem)
	slot0.rewardList = LuaList.New(handler(slot0, slot0.IndexRewardItem), slot0.m_rewardList, CommonItem)
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		FireWorkAction.QueryReceiveReward(uv0.select)
	end)
	slot0:AddBtnListener(slot0.m_reviewBtn, nil, function ()
		JumpTools.OpenPageByJump("/fireWorkShow", {
			fire_activity_id = uv0.select
		})
	end)
	slot0:AddBtnListener(slot0.m_inviteBtn, nil, function ()
		JumpTools.OpenPageByJump("fireWorkMake", {
			start = true,
			fire_activity_id = uv0.select
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = GameSetting.activity_firework_describe and GameSetting.activity_firework_describe.value or {}
		}
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = ActivityConst.FIRE_WORK
	slot0.sub_activity_list = ActivityCfg[slot0.activity_id].sub_activity_list

	if slot0.params_.fire_activity_id then
		slot0.select = slot0.params_.fire_activity_id
		slot0.params_.fire_activity_id = nil
	end

	if slot0.select == nil or not ActivityData:GetActivityIsOpen(slot0.select) then
		for slot4, slot5 in ipairs(slot0.sub_activity_list) do
			if ActivityData:GetActivityIsOpen(slot5) then
				slot0.select = slot5

				break
			end
		end
	end

	slot0.headList:StartScroll(#slot0.sub_activity_list, table.indexof(slot0.sub_activity_list, slot0.select) or 1, true)
	slot0:RefreshUI()
	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()

	if GameSetting.activity_firework_story.value[1] and not manager.story:IsStoryPlayed(slot2) then
		slot3 = manager.story

		slot3:StartStoryById(slot2, function (slot0)
		end)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	for slot5, slot6 in pairs(slot0.headList:GetItemList()) do
		slot6:OnExit()
	end
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end

	for slot6, slot7 in pairs(slot0.headList:GetItemList()) do
		slot7:RefrenTime()
	end
end

function slot0.RefreshUI(slot0)
	if slot0.select and ActivityFireWorkCfg[slot0.select] then
		slot1 = ActivityFireWorkCfg[slot0.select]

		FireWorkAction.SetRead(slot0.select)

		slot0.m_roleDes.text = slot1.desc
		slot0.m_roleIcon.sprite = getSpriteWithoutAtlas("Textures/EmptyDream/letter_role_title/" .. slot1.icon)
		slot0.rewards = slot1.reward_item_list

		slot0.rewardList:StartScroll(#slot0.rewards)

		slot2 = FireWorkData:GetInvited(slot0.select)

		if FireWorkData:GetReward(slot0.select) then
			slot0.stateController:SetSelectedIndex(2)
		elseif slot2 then
			slot0.stateController:SetSelectedIndex(1)
		else
			slot0.stateController:SetSelectedIndex(0)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot0.select), 0)
	else
		slot0.m_roleIcon.sprite = nil
		slot0.m_roleDes.text = ""

		slot0.rewardList:StartScroll(0)
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.HeadClick(slot0, slot1)
	slot0.select = slot1

	slot0:RefreshUI()

	for slot6, slot7 in pairs(slot0.headList:GetItemList()) do
		slot7:UpdateSelect(slot0.select)
	end
end

function slot0.IndexHeadItem(slot0, slot1, slot2)
	slot2:SetData(slot0.sub_activity_list[slot1])
	slot2:UpdateSelect(slot0.select)
	slot2:RegistCallBack(handler(slot0, slot0.HeadClick))
end

function slot0.IndexRewardItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewards[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	slot0.headList:Dispose()
	slot0.rewardList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnFireWordUpdate(slot0)
	slot0:RefreshUI()
end

return slot0
