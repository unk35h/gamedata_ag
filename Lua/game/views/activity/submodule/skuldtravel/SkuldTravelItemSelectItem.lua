slot0 = class("SkuldTravelItemSelectItem", ReduxView)
slot1 = "Textures/EmptyDream/travel/item/"

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0.lock_ then
			uv0.selecthandler_(uv0.itemid_)
		end
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.islockcontroller_ = ControllerUtil.GetController(slot0.transform_, "islock")
	slot0.selectcontroller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.itemid_ = slot1
	slot0.mapid_ = slot2
	slot0.poltid_ = SkuldTravelData:GetPlotIdByMapIdAndItemId(slot0.mapid_, slot0.itemid_)
	slot0.itemimage_.sprite = getSpriteWithoutAtlas(uv0 .. TravelSkuldItemCfg[slot0.itemid_].icon)

	slot0:RefreshLockStatu()
	slot0:RefreshSelectStatu(slot3)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. slot0.poltid_)
end

function slot0.SetSelecthandler(slot0, slot1)
	slot0.selecthandler_ = slot1
end

function slot0.RefreshLockStatu(slot0)
	slot0.lock_ = false
	slot1 = 1
	slot2 = SkuldTravelData:GetAttrib()
	slot6 = slot0.itemid_

	for slot6, slot7 in pairs(TravelSkuldItemCfg[slot6].unlock) do
		if slot2[slot6] < slot7 then
			slot0.lock_ = true
		end

		if slot7 > 0 then
			SetActive(slot0["attribtext_" .. slot1].gameObject, true)

			slot0["attribtext_" .. slot1].text = GetTips("TIP_NEED") .. SkuldTravelData:AttribIndexToString(slot6) .. slot7
			slot1 = slot1 + 1
		end
	end

	for slot6 = slot1, 2 do
		SetActive(slot0["attribtext_" .. slot6].gameObject, false)
	end

	slot0.islockcontroller_:SetSelectedState(slot0.lock_ and "true" or "false")
end

function slot0.RefreshSelectStatu(slot0, slot1)
	slot0.selectcontroller_:SetSelectedState(slot1 == slot0.itemid_ and "true" or "false")
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.TRAVEL_SKULD_TRAVELITEM .. slot0.poltid_)

	slot0.selecthandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
