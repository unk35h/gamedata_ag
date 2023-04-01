slot0 = class("SkuldTravelItemSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelchoosepop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemselecthandle_ = handler(slot0, slot0.OnSelectItem)
	slot0.list_ = LuaList.New(handler(slot0, slot0.rendeler), slot0.listgo_, SkuldTravelItemSelectItem)
	slot0.isgetcontroller_ = ControllerUtil.GetController(slot0.transform_, "isget")
end

function slot0.rendeler(slot0, slot1, slot2)
	slot2:SetData(TravelSkuldStoryCfg[slot0.plotlist_[slot1]].item_id, slot0.params_.mapindex, slot0.curitemid_)
	slot2:SetSelecthandler(slot0.itemselecthandle_)
end

function slot0.OnSelectItem(slot0, slot1)
	slot0.curitemid_ = slot1
	slot0.itemnametext_.text = TravelSkuldItemCfg[slot1].name
	slot0.desctext_.text = TravelSkuldItemCfg[slot1].desc

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:RefreshSelectStatu(slot1)
	end

	slot0:RefreshGetStatu()
end

function slot0.RefreshGetStatu(slot0)
	if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(slot0.params_.mapindex, slot0.curitemid_) then
		slot0.isgetcontroller_:SetSelectedState("true")
	else
		slot0.isgetcontroller_:SetSelectedState("false")
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.travelbtn_, nil, function ()
		slot0 = SkuldTravelData:GetPlotIdByMapIdAndItemId(uv0.params_.mapindex, uv0.curitemid_)

		if SkuldTravelData:GetPlotIsGetByMapIdAndItemId(uv0.params_.mapindex, uv0.curitemid_) then
			ShowMessageBox({
				content = GetTips("TRAVEL_SKULD_STORY_GETTED"),
				OkCallback = function ()
					SkuldTravelAction:GotoTravel(uv0)
				end
			})
		else
			SkuldTravelAction:GotoTravel(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	if slot0.curmapid_ ~= slot0.params_.mapindex then
		slot0.curmapid_ = slot0.params_.mapindex
		slot0.plotlist_ = TravelSkuldStoryCfg.get_id_list_by_location_id[slot0.params_.mapindex]
		slot0.curitemid_ = TravelSkuldStoryCfg[slot0.plotlist_[1]].item_id
	end

	slot0.itemnametext_.text = TravelSkuldItemCfg[slot0.curitemid_].name
	slot0.desctext_.text = TravelSkuldItemCfg[slot0.curitemid_].desc

	slot0:RefreshGetStatu()
	slot0.list_:StartScroll(#slot0.plotlist_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.itemselecthandle_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
