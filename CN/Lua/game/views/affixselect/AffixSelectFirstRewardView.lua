slot0 = class("AffixSelectFirstRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillFirstRewardUI"
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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AffixSelectFirstRewardItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.idList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(AFFIX_SELECT_FIRST_BONUS_UPDATE, function ()
		uv0:UpdateList()
	end)
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
	slot0.idList_ = deepClone(ActivityCfg[ActivityConst.ACTIVITY_1_7_AFFIX_SELECT].sub_activity_list)

	table.sort(slot0.idList_, function (slot0, slot1)
		if (ActivityAffixSelectData:GetSubActivityData(slot0) or {
			clearState = 1
		}).clearState ~= (ActivityAffixSelectData:GetSubActivityData(slot1) or {
			clearState = 1
		}).clearState then
			return slot2.clearState % 3 > slot3.clearState % 3
		end

		return slot0 < slot1
	end)
	slot0.uiList_:StartScroll(#slot0.idList_)
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
