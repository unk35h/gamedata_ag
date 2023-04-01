slot0 = class("FishingIllustratedItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:GetTmpCorners()
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.iconController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "icon")
	slot0.upController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "up")
	slot0.fishIcon_ = FishIcon.New(slot0.fishIconGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityConst.SUMMER_FISHING).startTime + uv0.cfg_.open_time then
			ShowTips(string.format(GetTips("PURCHASE_SYSTEM_NOT_OPEN"), tostring(manager.time:GetLostTimeStr(slot0.startTime + uv0.cfg_.open_time))))

			return
		end

		JumpTools.OpenPageByJump("fishingBuy", {
			fishId = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		JumpTools.OpenPageByJump("fishingInfoPop", {
			rect = uv0:GetScreenRect(uv0.container_),
			id = uv0.id_
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(FISHING_BUY_SUCCESS, function (slot0)
		if slot0 == uv0.id_ then
			uv0:UpdateView()
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = RareFishCfg[slot2]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.index_ % 2 == 1 then
		slot0.upController_:SetSelectedState("false")
	else
		slot0.upController_:SetSelectedState("true")
	end

	slot0.fishNameLabel_.text = slot0.cfg_.name
	slot1 = 0

	if FishingData:GetFish(slot0.id_) ~= nil then
		slot1 = slot2.num
	end

	slot0.haveValueLabel_.text = slot1

	if FishingData:GetFish(slot0.id_) ~= nil then
		slot0.iconController_:SetSelectedState("false")
	else
		slot0.iconController_:SetSelectedState("not")
	end

	slot0.fishIcon_:SetId(slot0.id_)

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_SUMMER_FISHING_COIN)
	slot0.pic_.sprite = getSpriteWithoutAtlas("Textures/Fishing/FishRole/" .. slot0.id_)

	slot0.pic_:SetNativeSize()

	slot0.priceLabel_.text = RareFishCfg[slot0.id_].price
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.GetScreenRect(slot0, slot1)
	slot2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	slot1:GetWorldCorners(slot0.corners)

	slot3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[0])

	return UnityEngine.Rect.New(slot3, UnityEngine.RectTransformUtility.WorldToScreenPoint(slot2, slot0.corners[2]) - slot3)
end

function slot0.GetTmpCorners(slot0)
	if slot0.corners == nil then
		slot0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.fishIcon_ then
		slot0.fishIcon_:Dispose()

		slot0.fishIcon_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
