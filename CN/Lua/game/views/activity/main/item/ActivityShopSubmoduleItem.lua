slot0 = class("ActivityShopSubmoduleItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.theme_ = ActivityCfg[slot2].activity_theme
	slot0.shopList_ = shopList

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.shopController_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot1 = {}
		slot2 = {}

		if ActivityShopCfg.get_id_list_by_activity_theme[uv0.theme_] == nil then
			return
		end

		for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot0]) do
			table.insert(slot1, ShopListCfg[ActivityShopCfg[slot7].shop_id].activity_id)
			table.insert(slot2, ActivityShopCfg[slot7].shop_id)
		end

		if #slot1 <= 0 then
			return
		end

		slot3 = nil
		slot4 = 0
		slot5 = slot2[1]

		for slot9, slot10 in ipairs(slot1) do
			if ActivityData:GetActivityData(slot10).stopTime - manager.time:GetServerTime() > 0 and (slot4 == 0 or slot12 < slot4) then
				slot4 = slot12
				slot5 = slot2[slot9]
			end
		end

		slot6, slot7 = ShopTools.IsShopOpen(slot5)

		if slot6 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot5,
				showShops = slot2
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot7 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot7 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot2 = {}

	if ActivityShopCfg.get_id_list_by_activity_theme[slot0.theme_] == nil or slot0.shopTimeText_ == nil then
		return
	end

	for slot6, slot7 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[slot1]) do
		table.insert(slot2, ShopListCfg[ActivityShopCfg[slot7].shop_id].activity_id)
	end

	if #slot2 <= 0 then
		return
	end

	slot3 = nil
	slot4 = 0

	for slot8, slot9 in ipairs(slot2) do
		if ActivityData:GetActivityData(slot9).stopTime - manager.time:GetServerTime() > 0 and (slot4 == 0 or slot11 < slot4) then
			slot4 = slot11
			slot3 = slot9
		end
	end

	if slot3 == nil then
		slot0.shopController_:SetSelectedState("off")

		return
	end

	if ActivityData:GetActivityData(slot3).stopTime - manager.time:GetServerTime() < 0 then
		slot0.shopController_:SetSelectedState("off")

		return
	end

	slot7 = true

	if slot6 <= 432000 then
		slot0.shopController_:SetSelectedState("on")

		slot0.shopTimeText_.text = manager.time:GetLostTimeStr2(slot5, nil, true)
	else
		slot0.shopController_:SetSelectedState("off")

		slot7 = false
	end

	slot0.timer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()

		if uv0 <= uv2 then
			if uv0 <= 0 then
				uv3.shopController_:SetSelectedState("off")
				uv3:StopTimer()
				uv3:AddTimer()

				return
			end

			if uv4 then
				uv3.shopController_:SetSelectedState("on")

				uv3.shopTimeText_.text = manager.time:GetLostTimeStr2(uv1, nil, true)
				uv4 = false
			end

			uv3.shopTimeText_.text = manager.time:GetLostTimeStr2(uv1, nil, true)
		elseif uv4 == false then
			uv3.shopController_:SetSelectedState("off")

			uv4 = true
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
