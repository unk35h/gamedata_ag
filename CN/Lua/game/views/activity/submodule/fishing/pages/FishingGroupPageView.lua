slot0 = class("FishingGroupPageView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.idList_ = ActivitySummerFishGroupCfg.all

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SortData(slot0)
	slot1 = FishingData
	slot1 = slot1:GetActivityData().received_constitute_list

	table.sort(slot0.idList_, function (slot0, slot1)
		slot5 = table.indexof(uv0, ActivitySummerFishGroupCfg[slot1].id) or 0

		if ((table.indexof(uv0, ActivitySummerFishGroupCfg[slot0].id) or 0) == 0 or slot5 == 0) and slot4 ~= slot5 then
			return slot4 < slot5
		end

		slot6 = 1

		for slot10, slot11 in ipairs(slot2.group[1]) do
			slot12 = nil

			if not (FishingData:GetActivityData().fish_infos[slot11] and slot13.num > 0 and true or false) then
				slot6 = 0

				break
			end
		end

		slot7 = 1

		for slot11, slot12 in ipairs(slot3.group[1]) do
			slot13 = nil

			if not (FishingData:GetActivityData().fish_infos[slot12] and slot14.num > 0 and true or false) then
				slot7 = 0

				break
			end
		end

		if slot7 ~= slot6 then
			return slot7 < slot6
		end

		return slot0 < slot1
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, FishingGroupItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetId(slot0.idList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FISHING_GROUP_REWARD_CHANGE, function ()
		uv0:UpdateView()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0:SortData()
	slot0.uiList_:StartScroll(#slot0.idList_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
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
