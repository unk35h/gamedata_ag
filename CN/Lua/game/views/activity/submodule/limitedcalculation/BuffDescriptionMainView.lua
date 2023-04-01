slot0 = class("BuffDescriptionMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SummerUI/SummerPlayerAffixesPop"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, BuffDescriptionView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1], slot0.params_.type)
end

function slot0.AddUIListeners(slot0)
	slot1 = slot0.scrollHelper_

	slot1:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if uv0.pageIndex_ > 1 then
			uv0.pageIndex_ = uv0.pageIndex_ - 1

			uv0.scrollHelper_:SwitchToPage(uv0.pageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if uv0.pageIndex_ < uv0.maxLv_ then
			uv0.pageIndex_ = uv0.pageIndex_ + 1

			uv0.scrollHelper_:SwitchToPage(uv0.pageIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	slot0:RefreshBtn()
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId
	slot0.curdifficulty_ = LimitedCalculationData:GetCurDifficulty(slot0.activityID_)

	if slot0.params_.type == "buff" then
		slot0.list_ = LimitedCalculationTools.GetBuffList(slot0.activityID_)
	elseif slot0.params_.type == "debuff" then
		slot0.list_ = LimitedCalculationTools.GetDebuffList(slot0.activityID_)
	end

	if table.indexof(slot0.list_, slot0.curdifficulty_) then
		slot0.pageIndex_ = slot1
	else
		slot0.pageIndex_ = 1
	end

	slot0.maxLv_ = #slot0.list_

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.scrollHelper_:StartScroll(#slot0.list_, slot0.pageIndex_, true, false)
	slot0.scrollHelper_:SwitchToPage(slot0.pageIndex_)
	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.leftBtn_.gameObject, slot0.pageIndex_ > 1)
	SetActive(slot0.rightBtn_.gameObject, slot0.pageIndex_ < slot0.maxLv_)
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
