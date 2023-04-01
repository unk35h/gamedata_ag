slot0 = class("FishEndingView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Fishing/FishingEndingUI"
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

	slot0.emptyStatusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "emptyStatus")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, FishIcon)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetId(slot0.fishes_[slot1].id)
	manager.audio:PlayEffect("minigame_fishing", "fishing_win_bubble", "")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		JumpTools.Back()

		if uv0.params_.callback ~= nil then
			uv0.params_.callback()
		end
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()

		if uv0.params_.callback ~= nil then
			uv0.params_.callback()
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.score_ = slot0.params_.score
	slot0.fishes_ = slot0.params_.fishes
	slot0.gainScore_ = slot0.params_.gainScore

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.fishes_)

	slot0.scoreValueLabel_.text = slot0.score_
	slot0.coinValueLabel_.text = tostring(FishingData:GetActivityData().today_total_score) .. "/" .. GameSetting.activity_fishing_money_max.value[1]
	slot2 = FishingData:GetActivityData().today_treasure_num
	slot0.fishValueLabel_.text = tostring(slot2) .. "/" .. GameSetting.activity_fishing_fish_max.value[1]

	if GameSetting.activity_fishing_fish_max.value[1] <= slot2 then
		slot0.emptyStatusController_:SetSelectedState("full")
	else
		slot0.emptyStatusController_:SetSelectedState("no")
	end
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
