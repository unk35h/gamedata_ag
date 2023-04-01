slot0 = class("ObtainView", ReduxView)
slot1 = "OBTAIN_HERO_MOVIE"

function slot0.UIName(slot0)
	return "UI/Obtain/ObtainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Creat(slot0, slot1, slot2)
	slot3 = slot0.content_
	slot4 = nil

	if slot1 == ItemConst.ITEM_TYPE.HERO then
		slot5 = nil
		slot4 = ObtainHeroView.New((slot2 ~= 2 or Asset.Load("UI/Obtain/ObtainHeroSUI")) and (slot2 ~= 1 or Asset.Load("UI/Obtain/ObtainHeroAUI")) and Asset.Load("UI/Obtain/ObtainHeroBUI"), slot3)
	elseif slot1 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot5 = nil
		slot4 = ObtainWeaponView.New((slot2 ~= 2 or Asset.Load("UI/Obtain/ObtainWeaponSUI")) and (slot2 ~= 1 or Asset.Load("UI/Obtain/ObtainWeaponAUI")) and Asset.Load("UI/Obtain/ObtainWeaponBUI"), slot3)
	elseif slot1 == ItemConst.ITEM_TYPE.HERO_SKIN then
		slot5 = nil
		slot4 = ObtainSkinView.New((slot2 ~= 2 or Asset.Load("UI/Obtain/Skin/ObtainSkinSUI")) and (slot2 ~= 1 or Asset.Load("UI/Obtain/Skin/ObtainSkinAUI")) and Asset.Load("UI/Obtain/Skin/ObtainSkinBUI"), slot3)
	else
		slot4 = (slot1 ~= uv0 or ObtainHeroMovieView.New(Asset.Load("UI/Obtain/HeroMovie/ObtainHeroMovieUI"), slot3, slot0.showSkipHandler, slot0.refreshShareHandler_)) and ObtainItemView.New(Asset.Load("UI/Obtain/ObtainItemUI"), slot3)
	end

	slot4:Init()

	return slot4
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = {}

	SetActive(slot0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	slot0.showSkipHandler = handler(slot0, slot0.ShowSkipBtn)
	slot0.refreshShareHandler_ = handler(slot0, slot0.RefreshShareBtn)
end

function slot0.ShowSkipBtn(slot0)
	if slot0.goSkip_ and slot0.skipHandler then
		SetActive(slot0.goSkip_, not slot0:GetIsHaveUnWatchHero())
	end
end

function slot0.RefreshShareBtn(slot0)
	SetActive(slot0.goShare_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))
end

function slot0.AddListeners(slot0)
	if slot0.maskBtn_ then
		slot0:AddBtnListener(slot0.maskBtn_, nil, handler(slot0, slot0.OnMaskBtnClick))
	end

	if slot0.skipBtn_ then
		slot0:AddBtnListener(slot0.skipBtn_, nil, handler(slot0, slot0.OnSkipBtnClick))
	end

	slot0:AddBtnListener(slot0.buttonShare_, nil, function ()
		slot0 = uv0.itemList[uv0.index]

		uv0.cur:Skip2End()

		if uv0.timer_ then
			uv0.timer_:Stop()
		end

		slot1 = uv0.goShare_.activeSelf
		slot2 = uv0.goSkip_.activeSelf
		uv0.timer_ = Timer.New(function ()
			uv0.timer_:Stop()

			uv0.timer_ = nil

			manager.share:Share(function ()
				SetActive(uv0.goShare_, false)
				SetActive(uv0.goSkip_, false)
				uv0.cur:HideShareUI(uv1)
			end, function ()
				SetActive(uv0.goShare_, uv1)
				SetActive(uv0.goSkip_, uv2)
				uv0.cur:ShowShareUI(uv3)
			end, function ()
			end)
		end, 0.066, 1)

		uv0.timer_:Start()
	end)
end

function slot0.OnMaskBtnClick(slot0)
	if slot0.cur and slot0.cur:OnClick() then
		slot0:DoNext()
	end
end

function slot0.OnSkipBtnClick(slot0)
	slot0:Back()

	if slot0.skipHandler then
		slot0.skipHandler()
	end
end

function slot0.DoNext(slot0)
	if slot0.cur then
		slot0.cur:Hide()
	end

	slot0.index = slot0.index + 1

	if slot0.index > #slot0.itemList then
		slot0:Back()

		if slot0.doNextHandler then
			slot0.doNextHandler()
		end
	else
		if ItemCfg[slot0.itemList[slot0.index].id].type ~= ItemConst.ITEM_TYPE.HERO and slot4 ~= ItemConst.ITEM_TYPE.WEAPON_SERVANT and slot4 ~= ItemConst.ITEM_TYPE.HERO_SKIN then
			slot4 = 0
		end

		if not slot3 then
			slot0:DoNext()
		else
			slot6 = 0
			slot7 = slot4 .. "_" .. (slot3.display_rare >= 5 and 2 or slot5 >= 4 and 1 or 0)

			if slot4 == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[slot2] then
				slot4 = uv0
				slot7 = uv0

				if not (getData(DrawConst.WATCH_TAG, tostring(slot2)) or false) then
					SetActive(slot0.goSkip_, false)
					SetActive(slot0.goShare_, false)
				end
			end

			if not slot0.list[slot7] then
				slot0.list[slot7] = slot0:Creat(slot4, slot6)
			end

			slot0.cur = slot0.list[slot7]

			slot0.cur:Show(slot1)
		end
	end
end

function slot0.GetIsHaveUnWatchHero(slot0)
	if #slot0.itemList > 0 then
		for slot5 = slot0.index + 1, slot1 do
			if ItemCfg[slot0.itemList[slot5].id].type == ItemConst.ITEM_TYPE.HERO and ObtainHeroMovieCfg[slot6.id] and not (getData(DrawConst.WATCH_TAG, tostring(slot6.id)) or false) then
				return true
			end
		end
	end

	return false
end

function slot0.OnEnter(slot0)
	slot0.doNextHandler = slot0.params_.doNextHandler
	slot0.skipHandler = slot0.params_.skipHandler
	slot0.itemList = slot0.params_.itemList
	slot0.index = 0

	if slot0.goSkip_ and slot0.skipHandler then
		SetActive(slot0.goSkip_, not slot0:GetIsHaveUnWatchHero())
	else
		SetActive(slot0.goSkip_, false)
	end

	if manager.windowBar:GetIsShow() then
		slot0.barList = manager.windowBar:GetLastBarList()

		manager.windowBar:HideBar()
	else
		slot0.barList = nil
	end

	slot0:DoNext()
end

function slot0.OnExit(slot0)
	if slot0.cur then
		slot0.cur:Hide()

		slot0.cur = nil
	end

	if slot0.barList then
		manager.windowBar:SwitchBar(slot0.barList)
	end

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.list) do
		slot5:Dispose()
	end

	slot0.list = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnObtainHeroMovieAnimtionEvent(slot0)
	for slot4, slot5 in pairs(slot0.list) do
		slot5:OnObtainHeroMovieAnimtionEvent()
	end
end

return slot0
