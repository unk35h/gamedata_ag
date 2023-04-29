slot0 = class("RegressionView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ReturnUI/RegressionUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.pageClass = {
		RegressionSignPage,
		RegressionTaskPage,
		RegressionShopPage,
		RegressionNewPage
	}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree = LuaTree.New(slot0.m_uitree)

	slot0.tree:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.pages = {}
	slot0.selectIndex = -1
end

function slot0.AddUIListener(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		uv0:ShopRefresh()
	end)
	slot0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function (slot0)
		if uv0.curPage then
			uv0.curPage:SetData()
		end
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:ShopRefresh()
	end)
	slot0:AddBtnListener(slot0.m_questionBtn, nil, function ()
		JumpTools.OpenPageByJump("survey", {
			type = OperationConst.SURVEY_TYPE.REGRESSION
		})
	end)
end

function slot0.OnTop(slot0)
	if slot0.selectIndex == 3 and slot0.curPage and slot0.curPage.UpdateBarByShopId then
		slot0.curPage:UpdateBarByShopId()

		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.params_.selectIndex then
		slot0.tree:SelectGroup(slot0.params_.selectIndex)

		slot0.params_.selectIndex = nil
		slot0.params_.Inited = true
	elseif not slot0.params_.Inited then
		slot0.params_.Inited = true

		slot0.tree:SelectGroup(1)
	elseif slot0.curPage and slot0.curPage.Refresh then
		slot0.curPage:Refresh()
	end

	slot1 = OperationData:GetOperationOpenList()

	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(slot0.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)
	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.selectIndex = -1

	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(slot0.m_questionBtn.transform, RedPointConst.REGRESSION_SURVEY)

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0:SetSelectPage(slot1, nil)
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.curPage:SetData(slot2)
end

function slot0.SetSelectPage(slot0, slot1, slot2)
	if slot1 == slot0.selectIndex then
		return
	end

	slot0.selectIndex = slot1

	if slot0.curPage then
		slot0.curPage:SetActive(false)
	end

	if not slot0.pages[slot1] then
		slot0.pages[slot1] = slot0.pageClass[slot1].New(slot0.m_content)
	end

	slot0.curPage = slot0.pages[slot1]

	slot0.curPage:SetData(slot2)
	slot0.curPage:SetActive(true)

	if slot1 ~= 3 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.RefreshTime(slot0)
	slot0.m_timerLab.text = manager.time:GetLostTimeStr(RegressionData:GetRegressionLoginTime() + 86400 * GameSetting.return_duration_time.value[1])

	if slot0.curPage and slot0.curPage.RefreshTime then
		slot0.curPage:RefreshTime()
	end
end

function slot0.Dispose(slot0)
	slot0.params_.Inited = nil

	if slot0.curPage then
		slot0.curPage:SetActive(false)

		slot0.curPage = nil
	end

	slot0.tree:Dispose()

	for slot4, slot5 in pairs(slot0.pages) do
		slot5:Dispose()
	end

	slot0.pages = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnTaskListChange(slot0)
	if slot0.curPage and slot0.curPage.OnTaskListChange then
		slot0.curPage:OnTaskListChange()
	end
end

function slot0.ShopRefresh(slot0)
	if slot0.curPage and slot0.curPage.RefreshList then
		slot0.curPage:RefreshList(true)
	end
end

function slot0.OnRegressionSign(slot0)
	if slot0.curPage and slot0.curPage.OnRegressionSign then
		slot0.curPage:OnRegressionSign(true)
	end
end

function slot0.OnShopBuyResult(slot0)
	slot0:ShopRefresh()
end

return slot0
