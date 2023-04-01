slot0 = class("ActivityInfinityPoolCfg", ReduxView)

function slot0.GetAssetName(slot0)
	return "UI/VersionUI/OsirisUI/OsirisUIInfinitypoolUI"
end

function slot0.GetInfinityPoolItem(slot0)
	return ActivityInfinityPoolBaseItem
end

function slot0.ClickRewardPreview(slot0)
	JumpTools.OpenPageByJump("osirisRewardPreview", {
		poolID = slot0.poolID_
	})
end

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetAssetName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.activityID_ = slot2
	slot0.lotteryItemList_ = {}
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.rewardController_ = ControllerUtil.GetController(slot0.goMainReward_.transform, "name")
	slot0.openCoreItemHandler_ = handler(slot0, slot0.OpenCoreItem)

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, slot0.openCoreItemHandler_)

	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(OSIRIS_INFINITY_OPEN_CORE_ITEM, slot0.openCoreItemHandler_)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.openCoreItemHandler_ = nil

	for slot4, slot5 in pairs(slot0.lotteryItemList_) do
		slot5:Dispose()
	end

	slot0.lotteryItemList_ = nil

	if slot0.mainRewardItem_ then
		slot0.mainRewardItem_:Dispose()

		slot0.mainRewardItem_ = nil
	end

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnRewardView_, nil, function ()
		uv0:ClickRewardPreview()
	end)
	slot0:AddBtnListener(slot0.btnReset_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("RESET_INFINITY"),
			OkCallback = function ()
				OsirisAction.ResetPool(uv0.poolID_, function (slot0)
					if isSuccess(slot0.result) then
						uv0:RefreshUI()
					else
						ShowTips(slot0.result)
					end
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.unresetBtn_, nil, function ()
		ShowTips("UNLOCK_INFINITY_RESET_TIPS")
	end)
end

function slot0.SetPhase(slot0, slot1)
	if slot0.phase_ == slot1 then
		return
	end

	slot0.phase_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID_][slot0.phase_]
	slot0.poolID_ = slot2
	slot3 = OsirisInfinityPoolData:GetPoolData(slot2)
	slot4 = #slot3.itemList

	if slot3.coreItem then
		slot4 = slot4 + 1
	end

	for slot8 = 1, slot4 do
		if slot0.lotteryItemList_[slot8] == nil then
			slot0.lotteryItemList_[slot8] = slot0:GetInfinityPoolItem().New(slot0.goItem_, slot0.goItemParent_)
		end

		slot0.lotteryItemList_[slot8]:SetData(slot2, slot8)
	end

	for slot8 = #slot0.lotteryItemList_, slot4 + 1, -1 do
		slot0.lotteryItemList_[slot8]:Show(false)
	end

	slot0.phase_ = slot1

	slot0:RefreshCoreItem()
end

function slot0.RefreshCoreItem(slot0)
	slot1 = slot0.phase_
	slot3 = OsirisInfinityPoolData:GetPoolData(ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID_][slot1])

	if slot1 == #ActivityInfinityPoolCfg.get_id_list_by_activity_id[slot0.activityID_] == false then
		slot0.controller_:SetSelectedState("false")

		slot0.canReset_ = false
	elseif table.length(slot3.openBoxList) < #slot3.itemList then
		slot0.controller_:SetSelectedState("noreset")

		slot0.canReset_ = false
	else
		slot0.controller_:SetSelectedState("true")

		slot0.canReset_ = true
	end

	if slot3.isOpenCoreItem then
		slot0.rewardController_:SetSelectedState("get")
	else
		slot0.rewardController_:SetSelectedState("normal")
	end

	slot0:RefreshMainReward(slot3.coreItem)
end

function slot0.RefreshMainReward(slot0, slot1)
	if slot1 == nil then
		return
	end

	if slot1[1] == 0 then
		return
	end

	if slot0.mainRewardItem_ == nil then
		slot0.mainRewardItem_ = slot0:GetRewardItem(slot1)
	else
		slot0.mainRewardItem_:SetData(slot1)
	end
end

function slot0.GetRewardItem(slot0, slot1)
	return RewardPoolItem.New(slot0.goMainReward_, slot1)
end

function slot0.Show(slot0, slot1)
	if slot1 == false then
		slot0.phase_ = nil
	end

	if slot0.gameObject_.activeSelf == slot1 then
		return
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot0.OpenCoreItem(slot0)
	slot0:RefreshCoreItem()
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
