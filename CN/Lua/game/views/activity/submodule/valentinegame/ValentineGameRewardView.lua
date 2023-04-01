slot0 = class("ValentineGameRewardView", ReduxView)

function slot0.UIName(slot0)
	return ValentineGameTools.GetRewardUIName(slot0.params_.activityId)
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ValentineGameRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.list_ = {}
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in ipairs(ActivityCfg[slot0.activityID_].sub_activity_list) do
		if ValentineGameData:GetData(slot9) then
			if slot10.isReward then
				table.insert(slot3, slot9)
			elseif slot10.isClear then
				table.insert(slot1, slot9)
			else
				table.insert(slot2, slot9)
			end
		else
			table.insert(slot2, slot9)
		end
	end

	table.insertto(slot0.list_, slot1)
	table.insertto(slot0.list_, slot2)
	table.insertto(slot0.list_, slot3)
	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnValentineGameReward(slot0)
	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
