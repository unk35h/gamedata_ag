slot0 = class("MardukSpecialRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/special/MardukSpecialRewardUI"
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

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, MardukSpecialRewardItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.activityIds_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(MARDUK_SPECIAL_REWARD_UPDATE, function (slot0)
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
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.cfg_ = ActivityCfg[slot0.params_.activityId]
	slot0.activityIds_ = slot0.cfg_.sub_activity_list

	slot0.uiList_:StartScroll(#slot0.activityIds_, MardukSpecialData:GetCanGetRewardIndex())
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.getLabel1_.text = MardukSpecialData:GetGotRewardNum()
	slot0.getLabel2_.text = "/" .. 3 * #slot0.activityIds_
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
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
