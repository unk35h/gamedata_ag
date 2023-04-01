slot0 = class("RecallMainView", ReduxView)
slot1 = {
	"recalled",
	"recall",
	"mission",
	"treasure"
}

function slot0.UIName(slot0)
	return "UI/RecallUI/RC1stMenuUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.curPageIndex_ = -1
	slot0.params_ = {}
	slot0.prefabList_ = {
		"UI/RecallUI/RC1stReturnUI",
		"UI/RecallUI/RC1stInitiateUI",
		"UI/RecallUI/RC1stMissionUI",
		"UI/RecallUI/RC1stTreasureUI"
	}
	slot0.ClassList_ = {
		RecallSystemRecalledView,
		RecallSystemRecallView,
		RecallSystemTaskView,
		RecallSystemShopView
	}

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.needExitAnim = {
		[2.0] = true,
		[4.0] = true
	}
	slot0.needEnterAnim = {
		[1.0] = true,
		[3.0] = true
	}
	slot0.playAnimTypeConst = {
		EXIT = 2,
		ENTER = 1
	}
	slot0.animConst = {
		[1.0] = "Fx_adron_cx",
		[2.0] = "Fx_adron_xs"
	}
	slot0.animation = slot0.animPanelGo_:GetComponent("Animation")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(uv0) do
		slot0:AddToggleListener(slot0[slot5 .. "Btn_"], function (slot0)
			if slot0 then
				uv0:SwitchPage(uv1)
				ControllerUtil.GetController(uv0[uv2 .. "Btn_"].transform, "toggle"):SetSelectedState("on")
			end
		end)
	end

	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		if slot0 == uv0.id then
			manager.windowBar:SwitchBar(uv0.barList)
		end
	end)
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.pages_[slot0.curPageIndex_] then
		slot2:Hide()
	end

	slot0.curPageIndex_ = slot1
	slot0.params_.page = slot1

	if not slot0.pages_[slot1] and slot0.prefabList_[slot1] and slot0.ClassList_[slot1] then
		slot0.pages_[slot1] = slot0.ClassList_[slot1].New(Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.container_))
	end

	slot0.pages_[slot0.curPageIndex_]:Show()
	slot0.pages_[slot1]:OnEnter()
	slot0:PlayAnim()
end

function slot0.PlayAnim(slot0)
	slot1 = false
	slot2 = -1

	if slot0.params_.isEnter == true then
		if slot0.needExitAnim[slot0.curPageIndex_] == true then
			slot1 = false
			slot2 = slot0.playAnimTypeConst.EXIT
		elseif slot0.needEnterAnim[slot0.curPageIndex_] == true then
			slot1 = true
			slot2 = slot0.playAnimTypeConst.ENTER
			slot0.params_.isEnter = false
		end
	else
		slot1 = true

		if slot0.needEnterAnim[slot0.curPageIndex_] == true and slot0.lastPlayType ~= slot0.playAnimTypeConst.ENTER then
			slot2 = slot0.playAnimTypeConst.ENTER
		elseif slot0.needExitAnim[slot0.curPageIndex_] == true and slot0.lastPlayType ~= slot0.playAnimTypeConst.EXIT then
			slot2 = slot0.playAnimTypeConst.EXIT
		end
	end

	SetActive(slot0.animPanelGo_, slot1)

	if slot1 == true and slot2 ~= -1 then
		slot0.lastPlayType = slot2

		slot0.animation:Play(slot0.animConst[slot2])
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.SetFirstPage(slot0)
	SetActive(slot0.recalledBtn_.gameObject, ActivityRecallData:GetDataByPara("firstPage"))

	if slot0.curPageIndex_ == -1 then
		slot0.curPageIndex_ = slot1 and 1 or 2
	end

	slot0:SwitchPage(slot0.curPageIndex_)
end

function slot0.OnTop(slot0)
	slot0.barList = {}

	table.insert(slot0.barList, INFO_BAR)
	table.insert(slot0.barList, BACK_BAR)
	table.insert(slot0.barList, HOME_BAR)
	table.insert(slot0.barList, NAVI_BAR)

	slot2 = {}

	for slot7 = 1, #ShopListCfg[ActivityRecallData:GetDataByPara("shopID")].cost_id do
		slot0.id = nil

		if CurrencyIdMapCfg[slot3.cost_id[slot7]] then
			slot0.id = CurrencyIdMapCfg[slot3.cost_id[slot7]].item_id
		else
			slot0.id = slot3.cost_id[slot7]
		end

		table.insert(slot0.barList, slot0.id)
		table.insert(slot2, slot0.id)
	end

	slot7 = slot0.barList

	manager.windowBar:SwitchBar(slot7)

	for slot7 = 1, #slot2 do
		manager.windowBar:SetBarCanAdd(slot2[slot7], true)
	end

	manager.windowBar:SetGameHelpKey("RECALLED_DESC")
end

function slot0.OnSign(slot0, slot1, slot2)
	if slot0.pages_[slot0.curPageIndex_] and slot0.pages_[slot0.curPageIndex_].OnSign then
		slot0.pages_[slot0.curPageIndex_]:OnSign(slot1, slot2)
	end
end

function slot0.OnReceivedCodeReward(slot0)
	if slot0.pages_[slot0.curPageIndex_] and slot0.pages_[slot0.curPageIndex_].OnReceivedCodeReward then
		slot0.pages_[slot0.curPageIndex_]:OnReceivedCodeReward()
	end
end

function slot0.OnRecallRewardUpdate(slot0)
	if slot0.pages_[slot0.curPageIndex_] and slot0.pages_[slot0.curPageIndex_].OnRecallRewardUpdate then
		slot0.pages_[slot0.curPageIndex_]:OnRecallRewardUpdate()
	end
end

function slot0.OnRecallSignUpdate(slot0)
	if slot0.pages_[slot0.curPageIndex_] and slot0.pages_[slot0.curPageIndex_].OnRecallSignUpdate then
		slot0.pages_[slot0.curPageIndex_]:OnRecallSignUpdate()
	end
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	for slot4, slot5 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot4)
	end

	slot0:SetFirstPage()
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.pages_) do
		if slot5 ~= nil then
			slot5:OnExit()
		end
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.recalledBtn_.transform, RedPointConst.RECALL_SIGN, {
		x = 130,
		y = 20
	})
	manager.redPoint:bindUIandKey(slot0.recallBtn_.transform, RedPointConst.RECALL_REWARD, {
		x = 130,
		y = 20
	})
	manager.redPoint:bindUIandKey(slot0.missionBtn_.transform, RedPointConst.RECALL_TASK, {
		x = 130,
		y = 20
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.recalledBtn_.transform, RedPointConst.RECALL_SIGN)
	manager.redPoint:unbindUIandKey(slot0.recallBtn_.transform, RedPointConst.RECALL_REWARD)
	manager.redPoint:unbindUIandKey(slot0.missionBtn_.transform, RedPointConst.RECALL_TASK)
end

function slot0.Dispose(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
