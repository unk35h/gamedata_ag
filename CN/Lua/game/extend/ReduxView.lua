slot0 = class("ReduxView", import("game.extend.BaseView"))
slot1 = import("game.tools.JumpTools")
slot2 = "WAIT"
slot3 = "LOADING"
slot4 = "LOADEND"
slot5 = "DESTROY"
slot0.VIEW_ADAPT_DISTANCE = 60
slot0.NEED_ADAPT = false
slot0.ADAPT_RAITO = 1.8888888888888888

function slot0.Ctor(slot0, ...)
	uv0.super.Ctor(slot0)

	slot0.props_ = {}
	slot0.currentUIState_ = uv1

	slot0:OnCtor(...)

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.OnCtor(slot0, ...)
end

function slot0.UIName(slot0)
	return nil
end

function slot0.UIParent(slot0)
	return nil
end

function slot0.UIBackCount(slot0)
	return 1
end

function slot0.Init(slot0)
end

function slot0.ShowDefaultBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	ReduxFactory.GetInstance():OnManagedObjDisposed(slot0)
	slot0:CheckListenersLeak()
end

function slot0.OnUpdate(slot0)
end

function slot0.SyncInit(slot0, slot1, slot2)
	slot0.routeName_ = slot1
	slot0.params_ = slot2

	if slot0:UIName() then
		if Asset.Load(slot3) == nil and Asset.Load(slot3 .. SettingData:GetCurrentLanguageKey()) == nil then
			error("找不到资源：" .. slot3)
		end

		slot0.gameObject_ = Object.Instantiate(slot4, slot0:UIParent())
		slot0.transform_ = slot0.gameObject_.transform
		slot0.currentUIState_ = uv0

		slot0:Init()
	else
		slot0.currentUIState_ = uv0

		slot0:Init()
	end
end

function slot0.AdaptScreen(slot0)
	if not uv0.NEED_ADAPT or slot0.transform_ == nil or uv0.VIEW_ADAPT_DISTANCE == slot0.lastAdaptDistance_ then
		return
	end

	slot0:AdaptLeft()
	slot0:AdaptRight()
	slot0:AdaptMiddle()
	slot0:AdaptChild()

	slot0.lastAdaptDistance_ = uv0.VIEW_ADAPT_DISTANCE
end

function slot0.AdaptLeft(slot0)
	if slot0.leftTrs_ == nil then
		if slot0.leftGo_ == nil then
			slot0.leftGo_ = slot0:FindGo("panel/left")
		end

		slot0.needAdaptLeft_ = false

		if slot0.leftGo_ == nil then
			slot0.leftGo_ = slot0:FindGo("panel/left_adapt")

			if slot0.leftGo_ then
				slot0.needAdaptLeft_ = true
			end
		end

		if slot0.leftGo_ then
			slot0.leftTrs_ = slot0.leftGo_:GetComponent(typeof(RectTransform))
		end
	end

	if slot0.leftTrs_ then
		slot0.leftTrs_.anchoredPosition = Vector3(uv0.VIEW_ADAPT_DISTANCE, 0, 0)

		if slot0.needAdaptLeft_ then
			if slot0.leftTrsSizeDelta_ == nil then
				slot0.leftTrsSizeDelta_ = slot0.leftTrs_.sizeDelta
			end

			slot1 = slot0.leftTrsSizeDelta_
			slot0.leftTrs_.sizeDelta = Vector2.New(slot1.x - uv0.VIEW_ADAPT_DISTANCE * 2, slot1.y)
		end
	end
end

function slot0.AdaptRight(slot0)
	if slot0.rightTrs_ == nil then
		if slot0.rightGo_ == nil then
			slot0.rightGo_ = slot0:FindGo("panel/right")
		end

		slot0.needAdaptRight_ = false

		if slot0.rightGo_ == nil then
			slot0.rightGo_ = slot0:FindGo("panel/right_adapt")

			if slot0.rightGo_ then
				slot0.needAdaptRight_ = true
			end
		end

		if slot0.rightGo_ then
			slot0.rightTrs_ = slot0.rightGo_:GetComponent(typeof(RectTransform))
		end
	end

	if slot0.rightTrs_ then
		slot0.rightTrs_.anchoredPosition = Vector3(-1 * uv0.VIEW_ADAPT_DISTANCE, 0, 0)

		if slot0.needAdaptRight_ then
			if slot0.rightTrsSizeDelta_ == nil then
				slot0.rightTrsSizeDelta_ = slot0.rightTrs_.sizeDelta
			end

			slot1 = slot0.rightTrsSizeDelta_
			slot0.rightTrs_.sizeDelta = Vector2.New(slot1.x - uv0.VIEW_ADAPT_DISTANCE * 2, slot1.y)
		end
	end
end

function slot0.AdaptMiddle(slot0)
	if slot0.middleTrs_ == nil then
		if slot0.middleGo_ == nil then
			slot0.middleGo_ = slot0:FindGo("panel/middle_adapt")
		end

		if slot0.middleGo_ then
			slot0.middleTrs_ = slot0.middleGo_:GetComponent(typeof(RectTransform))
		end
	end

	if slot0.middleTrs_ then
		if slot0.middleTrsSizeDelta_ == nil then
			slot0.middleTrsSizeDelta_ = slot0.middleTrs_.sizeDelta
		end

		slot1 = slot0.middleTrsSizeDelta_
		slot0.middleTrs_.sizeDelta = Vector2.New(slot1.x - uv0.VIEW_ADAPT_DISTANCE * 2, slot1.y)
	end
end

function slot0.AdaptChild(slot0)
	if slot0.containerTrs_ == nil then
		if slot0.containerGo_ == nil then
			slot0.containerGo_ = slot0:FindGo("panel/pageContainer")
		end

		if slot0.containerGo_ then
			slot0.containerTrs_ = slot0.containerGo_:GetComponent(typeof(RectTransform))
		end
	end

	if slot0.containerTrs_ then
		if slot0.containerTrsSizeDelta_ == nil then
			slot0.containerTrsSizeDelta_ = slot0.containerTrs_.sizeDelta
		end

		slot1 = slot0.containerTrsSizeDelta_
		slot0.containerTrs_.sizeDelta = Vector2.New(slot1.x - uv0.VIEW_ADAPT_DISTANCE * 2, slot1.y)
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
end

function slot0.OnBehind(slot0)
end

function slot0.SetParams(slot0, slot1)
	slot0.params_ = slot1
end

function slot0.Go(slot0, slot1, slot2, slot3)
	gameContext:Go(slot1, slot2, slot3)
end

function slot0.Back(slot0, slot1, slot2)
	uv0.Back(slot1, slot2)
end

function slot0.IsBack(slot0, slot1)
	return gameContext:IsBack(slot1)
end

function slot0.IsOpenRoute(slot0, slot1)
	return gameContext:IsOpenRoute(slot1)
end

function slot0.Unequal(slot0, slot1, slot2)
	if type(slot1) == "table" and type(slot2) == "table" then
		if table.length(slot1) ~= table.length(slot2) then
			return true
		end

		for slot6, slot7 in pairs(slot1) do
			if slot0:Unequal(slot7, slot2[slot6]) == true then
				return true
			end
		end
	elseif slot1 ~= slot2 then
		return true
	end

	return false
end

function slot0.SetViewProp(slot0, slot1, slot2)
	slot0.props_ = slot0.props_ or {}
	slot0.oldProps_ = slot0.oldProps_ or {}
	slot3 = false

	if slot0.props_[slot1] == nil then
		slot3 = true
	end

	if slot0:Unequal(slot0.oldProps_[slot1], slot2) then
		if type(slot2) == "table" then
			slot0.props_[slot1] = deepClone(slot2)
			slot0.oldProps_[slot1] = deepClone(slot2)
		else
			slot0.props_[slot1] = slot2
			slot0.oldProps_[slot1] = slot2
		end

		if not slot3 then
			slot0:OnViewPropChanged(slot1, slot2)
		end
	end
end

function slot0.GetViewProp(slot0, slot1)
	slot0.props_ = slot0.props_ or {}

	return slot0.props_[slot1]
end

function slot0.OnViewPropChanged(slot0, slot1, slot2)
end

function slot0.OnUnload(slot0)
	if slot0.currentUIState_ ~= uv0 then
		slot0:Dispose()
		slot0:Unload()
	end

	slot0.currentUIState_ = uv1
end

function slot0.Unload(slot0)
	manager.gc:Collect()

	if not isNil(slot0.gameObject_) then
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
	end

	slot0.props_ = nil
	slot0.oldProps_ = nil
end

function slot0.IsTop(slot0)
	return gameContext.routes_[#gameContext.routes_] == slot0.routeName_
end

function slot0.Cacheable(slot0)
	return true
end

function slot0.CheckCooperationInviteEntry(slot0)
	if slot0:GetCooperationInviteEntryGo() ~= nil then
		if CooperationData:CheckInviteEntryShow() then
			SetActive(slot1, true)
		else
			SetActive(slot1, false)
		end
	end
end

function slot0.GetCooperationInviteEntryGo(slot0)
	return nil
end

function slot0.OnCoopreationInvitUpdate(slot0)
	slot0:CheckCooperationInviteEntry()
end

return slot0
