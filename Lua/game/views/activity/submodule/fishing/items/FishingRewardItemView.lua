slot0 = class("FishingRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.bonusListGo_, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
	slot2:RefreshData({
		id = slot0.cfg_.reward_item_list[slot1][1],
		number = slot0.cfg_.reward_item_list[slot1][2]
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		FishingAction.GetBonus(ActivityConst.SUMMER_FISHING, uv0.id_)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetId(slot0, slot1)
	slot0.id_ = slot1
	slot0.cfg_ = ActivityPointRewardCfg[slot1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.uiList_:StartScroll(#slot0.cfg_.reward_item_list)

	slot0.conditionLabel_.text = tostring(slot0.cfg_.need)
	slot1 = 0

	if FishingData:GetActivityData() then
		slot1 = slot2.score
	end

	if slot1 < slot0.cfg_.need then
		slot0.statusController_:SetSelectedState("cannotGet")
	elseif table.indexof(FishingData:GetActivityData().received_award_list, slot0.cfg_.id) then
		slot0.statusController_:SetSelectedState("haveGet")
	else
		slot0.statusController_:SetSelectedState("canGet")
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
