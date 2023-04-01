slot0 = class("ActivityNewbieView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Activity/ActivityNewbieUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.pageClass_ = {
		ActivityNewbieSignView,
		ActivityNewbieTaskView,
		ActivityNewbieUpgradeView,
		ActivityNewbieDailyView,
		ActivityNoobFirstRechargeView,
		NoobMonthlyCardRechargeView,
		ActivityNoobBpRechargeView
	}

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.uiTreeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.pages_ = {}
	slot0.selectIndex_ = -1
	slot0.selectItemIndex_ = -1
	slot0.rechargeGroupGoList_ = {
		slot0.tree_:GetGroupGameObjectById(5),
		slot0.tree_:GetGroupGameObjectById(6),
		slot0.tree_:GetGroupGameObjectById(7)
	}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:RefreshRecharge()

	if slot0.params_.selectIndex then
		slot0.tree_:SelectGroup(slot0.params_.selectIndex)

		slot0.params_.selectIndex = nil
		slot0.params_.Inited = true
	elseif slot0.params_.isBack == true then
		slot1 = slot0.params_.lastIndex
		slot0.selectIndex_ = -1
		slot0.selectItemIndex_ = -1

		if slot0.params_.lastItemIndex > 0 then
			slot0.tree_:SelectItem(slot1, slot2)
		else
			slot0.tree_:SelectGroup(slot1)
		end
	elseif not slot0.params_.Inited then
		slot0.params_.Inited = true
		slot0.selectIndex_ = -1
		slot0.selectItemIndex_ = -1

		slot0.tree_:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.curPage_ then
		slot0.curPage_:SetActive(false)
	end

	slot0.params_.lastIndex = slot0.selectIndex_
	slot0.params_.lastItemIndex = slot0.selectItemIndex_

	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), RedPointConst.NEWBIE_SIGN)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(2), RedPointConst.NEWBIE_TASK)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(3), RedPointConst.NEWBIE_UPGRADE)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(4), RedPointConst.NEWBIE_DAILY_TASK)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(5), RedPointConst.NOOB_FIRST_RECHARGE)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(5, 1), RedPointConst.NOOB_FIRST_RECHARGE_1)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(5, 2), RedPointConst.NOOB_FIRST_RECHARGE_2)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(6), RedPointConst.NOOB_MONTHLY_RECHARGE)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(7), RedPointConst.NOOB_BP_RECHARGE)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0.selectIndex_ then
		return
	end

	slot0:SetSelectPage(slot1)
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.selectItemIndex_ == slot1 then
		return
	end

	slot0.selectItemIndex_ = slot1

	slot0.curPage_:SetData(slot1)
end

function slot0.SetSelectPage(slot0, slot1)
	slot0.selectIndex_ = slot1
	slot0.selectItemIndex_ = -1

	if slot0.curPage_ then
		slot0.curPage_:SetActive(false)
	end

	if not slot0.pages_[slot1] then
		slot0.pages_[slot1] = slot0.pageClass_[slot1].New(slot0.contentTrans_, 2)
	end

	slot0.curPage_ = slot0.pages_[slot1]

	if slot0.params_.isBack == true and slot0.curPage_.SetIsBack then
		slot0.curPage_:SetIsBack(slot0.params_.isBack)

		slot0.params_.isBack = false
	end

	slot0.curPage_:SetData()
	slot0.curPage_:SetActive(true)
end

function slot0.Dispose(slot0)
	slot0.params_.Inited = nil

	if slot0.curPage_ then
		slot0.curPage_:SetActive(false)

		slot0.curPage_ = nil
	end

	slot0.tree_:Dispose()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:Dispose()
	end

	slot0.pages_ = nil
	slot0.rechargeGroupGoList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshRecharge(slot0)
	for slot4 = 1, 3 do
		SetActive(slot0.rechargeGroupGoList_[slot4], ActivityNewbieTools.GetRechargeIsOpen(slot4))
	end

	if ActivityNewbieTools.GetFirstRechargeStatus() and slot1.firstGearStatus == 2 then
		slot0.tree_:GetData().groupDatas[4].defaultIndex = 1
	end
end

return slot0
