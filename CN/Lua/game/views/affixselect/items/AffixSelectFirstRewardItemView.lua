slot0 = class("AffisSelectFirstRewardItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateBtnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "stateBtn")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, CommonItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.cfg_.reward_item_list[slot1][1],
		number = slot0.cfg_.reward_item_list[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_receiveBtn, nil, function ()
		ActivityAffixSelectAction.GetFirstPassReward(uv0.activityId_)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.activityId_ = slot2
	slot0.cfg_ = ActivityAffixSelectCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("[%s]", slot0.cfg_.name)

	slot0.uiList_:StartScroll(#slot0.cfg_.reward_item_list)

	if (ActivityAffixSelectData:GetSubActivityData(slot0.activityId_) or {
		clearState = 1
	}).clearState == 3 then
		slot0.stateBtnController_:SetSelectedState("rewarded")
	elseif slot2 == 1 then
		slot0.stateBtnController_:SetSelectedState("unfinished")
	else
		slot0.stateBtnController_:SetSelectedState("complete")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
