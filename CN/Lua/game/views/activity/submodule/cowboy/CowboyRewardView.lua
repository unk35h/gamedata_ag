slot0 = class("CowboyRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeIntegralPopnew"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CowboyRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.activityID_, slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshText()
	slot0:RefreshList()
end

function slot0.RefreshText(slot0)
	slot1, slot2 = CowboyData:GetRewardCount(slot0.activityID_)
	slot0.text_.text = slot1 .. "/" .. slot2
end

function slot0.RefreshList(slot0)
	slot0.list_ = CowboyData:GetList(slot0.activityID_)
	slot1, slot2, slot3, slot4 = nil
	slot5 = 1

	for slot9 = #slot0.list_, 1, -1 do
		slot4 = slot0.list_[slot9]
		slot13 = slot4
		slot3 = CowboyData:GetHistoryScore(slot13)

		for slot13, slot14 in ipairs(CowboyData:GetData(slot4).reward) do
			slot1 = ActivityPointRewardCfg[slot14.point_id]

			if ActivityPointRewardCfg[slot14.point_id].need <= slot3 and slot14.point_reward_state == 1 then
				slot5 = slot9

				break
			end
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.list_, slot5)
end

function slot0.OnCowboyReward(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
