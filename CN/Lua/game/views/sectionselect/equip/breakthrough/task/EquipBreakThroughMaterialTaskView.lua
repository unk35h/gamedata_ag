slot0 = class("EquipBreakThroughMaterialTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapScoreExchangeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.receiveAllBtn_.transform, "name")
	slot0.taskList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, EquipBreakThroughMaterialTaskItem)
	slot0.updateHandler_ = handler(slot0, slot0.UpdateBreakThroughData)
	slot0.receiveHandler_ = handler(slot0, slot0.RefreshUI)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)
	manager.notify:RegistListener(EQUIP_BREAK_THROUGH_REWARD, slot0.receiveHandler_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_MATERIAL_UPDATE, slot0.updateHandler_)
	manager.notify:RemoveListener(EQUIP_BREAK_THROUGH_REWARD, slot0.receiveHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.taskList_:Dispose()

	slot0.taskList_ = nil
	slot0.updateHandler_ = nil
	slot0.receiveHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveAllBtn_, nil, function ()
		if #EquipBreakThroughMaterialData:GetCanReceiveList() <= 0 then
			return
		end

		if table.length(EquipBreakThroughMaterialData:GetReceivedList()) <= 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_REWARD_TIPS"),
				OkCallback = function ()
					uv0:ClickItem()
				end
			})
		else
			uv0:ClickItem()
		end
	end)
end

function slot0.ClickItem(slot0)
	slot1 = EquipBreakThroughMaterialData

	EquipBreakThroughMaterialAction.SendReceiveReward(slot1:GetCanReceiveList(), function (slot0)
		uv0:RefreshUI()
	end)
end

function slot0.RefreshUI(slot0)
	if #EquipBreakThroughMaterialData:GetCanReceiveList() > 0 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end

	slot0.taskList_:StartScroll(#EquipBreakThroughMaterialTaskCfg.all)

	slot0.pointText_.text = EquipBreakThroughMaterialData:GetTotalPoint()

	slot0:AddTimer()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(EquipBreakThroughMaterialData:GetSortRewardList()[slot1])
end

function slot0.UpdateBreakThroughData(slot0)
	EquipBreakThroughMaterialAction.EquipBTMaterialBackEntrace()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = manager.time:GetLostTimeStr(EquipBreakThroughMaterialData:GetRefreshTimestamp())
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = manager.time:GetLostTimeStr(uv1)
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
