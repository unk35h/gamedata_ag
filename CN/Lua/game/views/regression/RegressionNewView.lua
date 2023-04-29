slot1 = class("RegressionNewView", import("game.views.regression.RegressionView"))

function slot1.UIName(slot0)
	return "UI/ReturnTwoUI/RT2stBackflowNavigationUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.pageClass = {
		RegressionSignNewPage,
		RegressionTaskNewPage,
		RegressionCapsuleToysPage,
		RegressionSupplyPage,
		RegressionBPTaskPage,
		RegressionNewPage_2_0
	}
	slot0.needEnterAnim_ = {
		[2.0] = true,
		[5.0] = true
	}
	slot0.needExitAnim_ = {
		true,
		nil,
		true,
		true,
		nil,
		true
	}
	slot0.playAnimTypeConst_ = {
		EXIT = 2,
		ENTER = 1
	}
	slot0.animConst_ = {
		[1.0] = "Fx_adron_cx",
		[2.0] = "Fx_adron_xs"
	}
	slot0.animation_ = slot0.animPanelGo_:GetComponent("Animation")
	slot0.lastPlayType_ = -1
end

function slot1.AddUIListener(slot0)
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
end

function slot1.OnTop(slot0)
	slot0.curPage:UpdateBar()
end

function slot1.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.params_.selectIndex then
		slot0.tree:SelectGroup(slot0.params_.selectIndex)

		slot0.params_.selectIndex = nil
		slot0.params_.Inited = true
	elseif slot0.params_.isBack == true then
		slot1 = slot0.params_.lastIndex
		slot0.selectIndex = -1
		slot0.selectItemIndex = -1

		if slot0.params_.lastItemIndex > 0 then
			slot0.tree:SelectItem(slot1, slot2)
		else
			slot0.tree:SelectGroup(slot1)
		end
	elseif not slot0.params_.Inited then
		slot0.params_.Inited = true
		slot0.selectIndex = -1
		slot0.selectItemIndex = -1

		slot0.tree:SelectGroup(1)
	end

	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:bindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:bindUIandKey(slot0.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)
	slot0:RefreshTime()

	slot0.timer = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot1.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.params_.lastIndex = slot0.selectIndex
	slot0.params_.lastItemIndex = slot0.selectItemIndex

	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(1), RedPointConst.REGRESSION_SIGN)
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(2), RedPointConst.REGRESSION_TASK)
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 201), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY))
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 202), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK))
	manager.redPoint:unbindUIandKey(slot0.tree:GetItemRedPointContainerById(2, 203), string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE))
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(4), RedPointConst.REGRESSION_SUPPLY_FREE)
	manager.redPoint:unbindUIandKey(slot0.tree:GetGroupRedPointContainerById(5), RedPointConst.REGRESSION_BP)

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	if slot0.curPage and slot0.curPage.OnExit then
		slot0.curPage:OnExit()
		slot0.curPage:SetActive(false)
	end

	slot0.lastPlayType_ = -1
end

function slot1.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0.selectIndex then
		return
	end

	slot0:SetSelectPage(slot1, nil)
end

function slot1.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.selectItemIndex = slot1

	slot0.curPage:SetData(slot2)
end

function slot1.SetSelectPage(slot0, slot1, slot2)
	slot0.selectIndex = slot1
	slot0.selectItemIndex = -1

	if slot0.curPage then
		slot0.curPage:SetActive(false)
	end

	if not slot0.pages[slot1] then
		slot0.pages[slot1] = slot0.pageClass[slot1].New(slot0.m_content)
	end

	slot0.curPage = slot0.pages[slot1]

	if slot0.params_.isBack == true and slot0.curPage.SetIsBack then
		slot0.curPage:SetIsBack(slot0.params_.isBack)

		slot0.params_.isBack = false
	end

	slot0.curPage:SetData(slot2)
	slot0.curPage:SetActive(true)
	slot0.curPage:UpdateBar()
	slot0:PlayAnim()
end

function slot1.PlayAnim(slot0)
	slot1 = false
	slot2 = -1

	if slot0.params_.isEnter == true then
		if slot0.needExitAnim_[slot0.selectIndex] == true then
			slot1 = false
			slot2 = slot0.playAnimTypeConst_.EXIT
		elseif slot0.needEnterAnim_[slot0.selectIndex] == true then
			slot1 = true
			slot2 = slot0.playAnimTypeConst_.ENTER
			slot0.params_.isEnter = false
		end
	else
		slot1 = true

		if slot0.needEnterAnim_[slot0.selectIndex] == true and slot0.lastPlayType_ ~= slot0.playAnimTypeConst_.ENTER then
			slot2 = slot0.playAnimTypeConst_.ENTER
		elseif slot0.needExitAnim_[slot0.selectIndex] == true and slot0.lastPlayType_ ~= slot0.playAnimTypeConst_.EXIT then
			slot2 = slot0.playAnimTypeConst_.EXIT
		end
	end

	SetActive(slot0.animPanelGo_, slot1)

	if slot1 == true and slot2 ~= -1 then
		slot0.lastPlayType_ = slot2

		slot0.animation_:Play(slot0.animConst_[slot2])
	end
end

return slot1
