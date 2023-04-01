slot0 = class("AbyssRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AbyssUI/AbyssRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.ispassController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "ispass")
	slot0.empty1Controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty1")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.list_, AbyssRewardItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.idList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveallBtn_, nil, function ()
		if #AbyssData:GetCanGetLayers() > 0 then
			AbyssAction.GetLayerBonus(slot0)
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_LAYER_BONUS_GET, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:UpdateView()
	slot0:StartTimer()
	slot0:OnTimer()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:OnTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.OnTimer(slot0)
	slot0.timeLabel_.text = manager.time:GetLostTimeStr(AbyssData:GetRefreshTimestamp(), nil, true)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateView(slot0)
	slot0:UpdateList()

	slot0.passLabel_.text = AbyssData:GetMaxLayer()

	if #AbyssData:GetCanGetLayers() > 0 then
		slot0.ispassController_:SetSelectedState("true")
	else
		slot0.ispassController_:SetSelectedState("noreward")
	end
end

function slot0.UpdateList(slot0)
	slot0.idList_ = {}

	table.insertto(slot0.idList_, AbyssCfg.all, 1)
	table.sort(slot0.idList_, function (slot0, slot1)
		if uv0:GetBonusStatus(slot0) ~= uv0:GetBonusStatus(slot1) then
			return slot2 < slot3
		end

		return slot0 < slot1
	end)

	if AbyssData:GetMaxLayer() > 0 then
		slot0.empty1Controller_:SetSelectedState("normal")
	else
		slot0.empty1Controller_:SetSelectedState("empty")
	end

	slot0.uiList_:StartScroll(#slot0.idList_)
end

function slot0.GetBonusStatus(slot0, slot1)
	if AbyssData:IsLayerBonusGet(slot1) then
		return 3
	elseif slot1 <= AbyssData:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
