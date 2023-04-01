slot0 = class("AffixSelectScoreRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AffixSelectScoreRewardItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewardIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnReceivePointReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if table.indexof(slot0.rewardIdList_, slot6) then
			slot0:UpdateList()

			break
		end
	end
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
	manager.windowBar:HideBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:UpdateList()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateList(slot0)
	slot0.scoreLabel_.text = ActivityAffixSelectData:GetTotalScore()
	slot0.rewardIdList_ = deepClone(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT])
	slot0.haveGetLabel_.text = ActivityAffixSelectData:ScoreRewardGetCount() .. "/" .. #slot0.rewardIdList_

	table.sort(slot0.rewardIdList_, function (slot0, slot1)
		if ActivityAffixSelectData:GetRewardStatus(slot0) ~= ActivityAffixSelectData:GetRewardStatus(slot1) then
			return slot3 < slot2
		end

		return slot0 < slot1
	end)
	slot0.uiList_:StartScroll(#slot0.rewardIdList_)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
