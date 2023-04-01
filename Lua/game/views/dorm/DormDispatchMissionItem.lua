slot0 = class("DormDispatchMissionItem", ReduxView)

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

	slot0.timeController = ControllerUtil.GetController(slot0.transform_, "task")
	slot0.workController = ControllerUtil.GetController(slot0.transform_, "workbtn")
	slot0.refreshController = ControllerUtil.GetController(slot0.transform_, "refresh")
	slot0.coolController = ControllerUtil.GetController(slot0.transform_, "cooling")
	slot0.levelController = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.roleuilistScroll_ = LuaList.New(handler(slot0, slot0.indexRecommendRoleItem), slot0.roleuilistUilist_, DormRecommendRoleItem)
	slot0.awarduilistScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awarduilistUilist_, CommonItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.dispatchbtnBtn_, nil, function ()
		if #uv0.heroList == 0 then
			if uv0.confirmCallBack then
				uv0.confirmCallBack(uv0.ID, uv0.pos)
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_TAKS_CANCEL"),
				OkCallback = function ()
					if uv0.cancelCallBack then
						uv0.cancelCallBack(uv0.ID, uv0.pos)
					end
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.refreshbtnBtn_, nil, function ()
		if uv0.refreshTime > 0 then
			ShowTips(string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())))

			return
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_REFRESH_CONFIRM"),
				OkCallback = function ()
					if uv0.refreshCallBack then
						uv0.refreshCallBack(uv0.pos)
					end
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.unLockBtn_, nil, function ()
		if GameSetting.dorm_canteen_task_unlock.value[uv0.pos][2] ~= 0 then
			if CanteenTools:CheckConditionAccord(slot0) then
				CanteenAction:UnLockEntrust(uv0.pos)
			else
				ShowTips("未达到解锁条件")
			end
		else
			CanteenAction:UnLockEntrust(uv0.pos)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.pos = slot1.pos

	if slot1.id < 0 then
		slot0.lockController:SetSelectedState("lock")

		if GameSetting.dorm_canteen_task_unlock.value[slot0.pos][2] ~= 0 then
			slot3 = ConditionCfg[slot2].desc
			slot0.conditionText_.text = string.format(GetTips("DORM_CANTEEN_TASK_UNLOCK_TIPS"), DormitoryData:GetUnlockRoomNum(), ConditionCfg[slot2].params[1])
		end

		return
	end

	slot0.lockController:SetSelectedState("unlock")

	slot0.type = 1
	slot0.refreshTime = CanteenData:GetEntrustList()[slot0.pos].refresh_times
	slot2 = BackHomeCanteenTaskCfg[slot1.id]
	slot0.ID = slot1.id
	slot0.tasknameText_.text = slot2.name
	slot0.characternumText_.text = slot2.need[2]
	slot0.destextText_.text = slot2.desc
	slot0.tasktimeText_.text = slot0:MinSwitchTime(slot2.time)
	slot0.heroList = slot1.hero_list

	if #slot0.heroList > 0 then
		slot0.type = 2

		slot0.timeController:SetSelectedState("on")

		slot0.timeText_.text = CanteenData:GetEntrustLastTime(slot0.pos)
		slot0.statsDecText_.text = GetTips("CANTEEN_DISPATCHED_HERO")
		slot0.hastasknameText_.text = slot2.name

		slot0.workController:SetSelectedState("off")
	else
		slot0.statsDecText_.text = GetTips("CANREEN_RECOMEND_HERO")

		slot0.timeController:SetSelectedState("off")
		slot0.workController:SetSelectedState("on")
	end

	slot0.totalReText.text = "/" .. GameDisplayCfg.dorm_canteen_refresh_max.value[1]
	slot0.curReText.text = 1 - slot0.refreshTime

	if slot0.refreshTime > 0 then
		slot0.coolController:SetSelectedState("on")
	end

	slot0:RefreshRecommendAward(slot1.id, slot1.pos)
	slot0.levelController:SetSelectedState(slot2.task_level)
end

function slot0.MinSwitchTime(slot0, slot1)
	slot2, slot3 = math.modf(slot1 / 60)

	return string.format("%02d:%02d:%02d", slot2, slot3, 0)
end

function slot0.RefreshTimeMessage(slot0)
	if slot0.type == 2 then
		slot0.timeText_.text = CanteenData:GetEntrustLastTime(slot0.pos)

		if CanteenData:GetEntrustLastTime(slot0.pos) == 0 then
			manager.notify:Invoke(CANTEEN_DISPATCH_TIME_OVER)
		end
	end
end

function slot0.RefreshRecommendAward(slot0, slot1, slot2)
	if slot0.type == 1 then
		slot0.recommendRoleList_ = {}

		for slot7 = 1, #CanteenData:GetEntrustList()[slot2].tags do
			table.insert(slot0.recommendRoleList_, slot3.tags[slot7])
		end

		slot0.roleuilistScroll_:StartScroll(#slot0.recommendRoleList_)
	elseif slot0.type == 2 then
		slot0.recommendRoleList_ = slot0.heroList

		slot0.roleuilistScroll_:StartScroll(#slot0.recommendRoleList_)
	end

	slot6 = "ScrollRectEx"
	slot0.roleuilistUilist_:GetComponent(slot6).horizontal = false
	slot0.award_list = {}

	for slot6 = 1, #BackHomeCanteenTaskCfg[slot1].reward_list do
		table.insert(slot0.award_list, {
			id = BackHomeCanteenTaskCfg[slot1].reward_list[slot6][1],
			number = BackHomeCanteenTaskCfg[slot1].reward_list[slot6][2]
		})
	end

	slot0.awarduilistScroll_:StartScroll(#slot0.award_list)

	slot0.awarduilistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function slot0.RegisterConfirmCallBack(slot0, slot1)
	if slot1 then
		slot0.confirmCallBack = slot1
	end
end

function slot0.RegisterCancelCallBack(slot0, slot1)
	if slot1 then
		slot0.cancelCallBack = slot1
	end
end

function slot0.RegisterRefreshCallBack(slot0, slot1)
	if slot1 then
		slot0.refreshCallBack = slot1
	end
end

function slot0.indexRecommendRoleItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.recommendRoleList_[slot1], slot0.type)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.award_list[slot1], slot0.type)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.roleuilistScroll_ then
		slot0.roleuilistScroll_:Dispose()
	end

	if slot0.awarduilistScroll_ then
		slot0.awarduilistScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
