slot0 = class("SkuldTravelMapView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/EDream_travelled/EDream_travelmap"
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
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["btn_" .. slot4], nil, function ()
			JumpTools.OpenPageByJump("skuldTravelItemSelectView", {
				mapindex = uv0
			})
		end)
	end

	slot0:AddBtnListener(slot0.bgbtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		manager.redPoint:bindUIandKey(slot0["btn_" .. slot4].transform, RedPointConst.TRAVEL_SKULD_TRAVELMAP .. slot4)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(TravelSkuldStoryCfg.get_id_list_by_location_id) do
		manager.redPoint:unbindUIandKey(slot0["btn_" .. slot4].transform, RedPointConst.TRAVEL_SKULD_TRAVELMAP .. slot4)
	end

	slot0.super.Dispose(slot0)
end

return slot0
