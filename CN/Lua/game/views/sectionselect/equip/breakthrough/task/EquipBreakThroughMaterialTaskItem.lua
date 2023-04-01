slot0 = class("EquipBreakThroughMaterialTaskItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.RefreshRewardItem), slot0.uiList_, CommonItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
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
	EquipBreakThroughMaterialAction.SendReceiveReward({
		slot0.taskID_
	}, function (slot0)
		if isSuccess(slot0.result) then
			manager.notify:Invoke(EQUIP_BREAK_THROUGH_REWARD)
		end
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.SetData(slot0, slot1)
	slot3 = EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialData:GetSelectModeID()].reward_list[slot1]
	slot0.rewardList_ = slot3

	slot0.uiList_:StartScroll(#slot3)

	slot0.descText_.text = EquipBreakThroughMaterialTaskCfg[slot1].des
	slot0.taskID_ = slot1

	slot0:RefreshBtn()
end

function slot0.RefreshRewardItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.rewardList_[slot1][1],
		number = slot0.rewardList_[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.RefreshBtn(slot0)
	slot1 = EquipBreakThroughMaterialData:GetTaskList()[slot0.taskID_]

	if table.keyof(EquipBreakThroughMaterialData:GetReceivedList(), slot0.taskID_) then
		slot0.controller_:SetSelectedState("haveGet")
	elseif slot1.targetValue <= slot1.currentValue then
		slot0.controller_:SetSelectedState("canGet")
	else
		slot0.controller_:SetSelectedState("cannotGet")
	end
end

return slot0
