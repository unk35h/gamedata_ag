slot0 = class("FishingGroupItemView", ReduxView)

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
	slot0.fishList_ = LuaList.New(handler(slot0, slot0.indexFishItem), slot0.fishListGo_, FishIcon)
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

function slot0.indexFishItem(slot0, slot1, slot2)
	slot2:SetNeedUpdateHave(true)

	slot3 = 0

	if FishingData:GetFish(slot0.cfg_.group[1][slot1]) then
		slot3 = slot4.num
	end

	slot2:SetId(slot0.cfg_.group[1][slot1], 1, slot3)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		FishingAction.GetConstituteFishBonus(ActivityConst.SUMMER_FISHING, uv0.groupId_)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RARE_FISH_CHANGE, function (slot0)
		if table.indexof(uv0.cfg_.group[1], slot0) or slot0 == 0 then
			uv0:UpdateView()
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetId(slot0, slot1)
	slot0.groupId_ = slot1
	slot0.cfg_ = ActivitySummerFishGroupCfg[slot1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.groupNameLabel_.text = slot0.cfg_.name

	slot0.fishList_:StartScroll(#slot0.cfg_.group[1])
	slot0.uiList_:StartScroll(#slot0.cfg_.reward_item_list)

	slot1 = true

	for slot5, slot6 in ipairs(slot0.cfg_.group[1]) do
		slot7 = nil

		if not (FishingData:GetActivityData().fish_infos[slot6] and slot8.num > 0 and true or false) then
			slot1 = false

			break
		end
	end

	if table.indexof(FishingData:GetActivityData().received_constitute_list, slot0.cfg_.id) then
		slot0.statusController_:SetSelectedState("haveGet")
	elseif not slot1 then
		slot0.statusController_:SetSelectedState("cannotGet")
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

	if slot0.fishList_ then
		slot0.fishList_:Dispose()

		slot0.fishList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
