slot0 = class("AffixSelectMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "reward_btnstate"
	slot0.reward_btnstateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.bonusItem_ = CommonItem.New(slot0.bonusItemGo_)
	slot0.items_ = {}

	for slot4 = 1, 8 do
		table.insert(slot0.items_, AffixSelectItemView.New(slot0["itemGo" .. slot4 .. "_"]))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("affixSelectFirstReward", {})
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		JumpTools.OpenPageByJump("affixSelectScoreReward", {})
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		ActivityAction.ReceivePointReward({
			ActivityAffixSelectData:GetCurrentActivityReward()
		})
	end)

	slot1 = slot0.bonusItem_

	slot1:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("AFFIX_SELECT_HELP")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot2 = ActivityCfg[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT].sub_activity_list

	for slot6, slot7 in ipairs(slot0.items_) do
		slot7:SetData(slot6, slot2[slot6])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(slot0.firstPassNoticeContainer_, RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, {
		x = 0,
		y = 0
	})
	slot0:UpdateView()

	if getData("affixSelect", "mainScrollPos") then
		slot0.itemScrollRect_.horizontalNormalizedPosition = slot3
	end

	slot0:StartTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", slot0.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(slot0.firstPassNoticeContainer_, RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET)
	manager.windowBar:HideBar()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_7_AFFIX_SELECT).stopTime)
end

function slot0.UpdateView(slot0)
	slot1 = ActivityAffixSelectData:GetCurrentActivityReward()
	slot0.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore()
	slot0.totalScoreLabel_.text = "/" .. ActivityPointRewardCfg[slot1].need

	if ActivityAffixSelectData:GetRewardStatus(slot1) == 0 then
		slot0.reward_btnstateController_:SetSelectedState("received")
	elseif slot3 == 1 then
		slot0.reward_btnstateController_:SetSelectedState("normal")
	else
		slot0.reward_btnstateController_:SetSelectedState("receive")
	end

	slot0.bonusItem_:RefreshData({
		id = slot2.reward_item_list[1][1],
		number = slot2.reward_item_list[1][2]
	})
	slot0.bonusItem_:SetBottomText("")

	slot0.bonusNumLabel_.text = slot2.reward_item_list[1][2]

	slot0:UpdateTimer()
end

function slot0.OnReceivePointReward(slot0, slot1)
	slot0:UpdateView()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.bonusItem_ then
		slot0.bonusItem_:Dispose()

		slot0.bonusItem_ = nil
	end

	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
