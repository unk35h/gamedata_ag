slot0 = class("SpringFestivalRiddleRewardItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1

	slot0:BindCfgUI()

	slot0.rewardUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, CommonItem)
	slot0.controller_ = ControllerUtil.GetController(slot0.btnTf_, "switchBtn")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot2
	slot0.descText_.text = string.format(GetTips("ACTIVITY_SPRING_FESTIVAL_RIDDLE_FINISH_CNT"), ActivityPointRewardCfg[slot2].need)

	if table.keyof(SpringFestivalRiddleData:GetReceiveList(slot1), slot2) then
		slot0.controller_:SetSelectedState("complete")
	else
		slot0.controller_:SetSelectedState("not")
	end

	slot0.rewardUIList_:StartScroll(#slot3.reward_item_list)
end

function slot0.Dispose(slot0)
	if slot0.rewardUIList_ then
		slot0.rewardUIList_:Dispose()

		slot0.rewardUIList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
	slot2:RefreshData(formatReward(ActivityPointRewardCfg[slot0.id_].reward_item_list[slot1]))
end

return slot0
