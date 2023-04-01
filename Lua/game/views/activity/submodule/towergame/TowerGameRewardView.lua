slot0 = class("TowerGameRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/snakeactive/MarduksnakeRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.listgo_, TowerGameRewardBlock)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:Refresh(TowerGameCfg.all[slot1])
end

function slot0.RefreshUI(slot0)
	slot0.list_:StartScroll(#TowerGameCfg.all, TowerGameData:GetFirstCanGetRewardIndex())

	slot0.gettext_.text = TowerGameData:GetRewardsNum()
	slot0.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()
end

function slot0.OnTowerGameGetReward(slot0)
	slot0.gettext_.text = TowerGameData:GetRewardsNum()
	slot0.alltext_.text = "/" .. TowerGameData:GetAllRewardNum()

	slot0.list_:Refresh()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end
end

return slot0
