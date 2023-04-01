slot0 = class("NewHeroSkinView", ReduxView)

function slot0.isUnlock(slot0, slot1)
	for slot7, slot8 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot1].hero)) do
		if slot8 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isSelect(slot0, slot1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[slot1].hero).id == slot1 then
		return true
	end

	return false
end

function slot0.UIName(slot0)
	return "UI/HeroSkin/SkinUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.SetBtnState(slot0)
	slot0.btnState = {
		"btn_now",
		"btn_replace",
		"btn_go",
		"sourcetext",
		"btn_change",
		"unlockinfo"
	}
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.btnState_ = nil
	slot0.skinID_ = 1
	slot0.selectIndex_ = 1
	slot0.isCanUnlock_ = false

	slot0:SetSkinItem()
	slot0:SetBtnState()
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.unlockinfoGo_.transform, "isfinish")
	slot0.taskController_1 = ControllerUtil.GetController(slot0.tasktrans_1, "isfinish")
	slot0.taskController_2 = ControllerUtil.GetController(slot0.tasktrans_2, "isfinish")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, slot0.skinTemplate_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.portraitBtn_, nil, function ()
		uv0:Go("heroPortrait", {
			skinID = uv0.skinID_
		})
	end)
	slot0:AddBtnListener("panel/right/btn_replace", nil, function ()
		HeroAction.SelectSkin(uv0.heroID_, uv0.skinID_)
		uv0:PlayVoice()
	end)
	slot0:AddBtnListener("panel/right/btn_go", nil, function ()
		uv0.params_.skinID = uv0.skinID_

		uv0:Go("skinBuyCheck", {
			goodID = HeroTools.GetShopIdBySkinId(uv0.skinID_),
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener("panel/right/btn_change", nil, function ()
		uv0.params_.skinID = uv0.skinID_

		CommonAction.TryToUseItem({
			{
				num = 1,
				item_id = HeroTools.GetSkinChangeItem(uv0.skinID_),
				use_list = {}
			}
		})
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if uv0.isCanUnlock_ then
			HeroAction.UnLockSkin(uv0.skinID_)
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:RefreshUIWithOutScroll()
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot4 = ItemCfg[slot2.use_item_list[1].item_id].param[1]

		getReward({
			{
				slot4,
				1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
		MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1, slot2.use_item_list[1].time_valid, slot2.use_item_list[1].time_valid)
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[slot4].hero)
		HeroAction.SkinAdd(slot0.skinID_)
		slot0:SetButtonActive(2)
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnSelectSkin(slot0, slot1, slot2)
	slot0:SetButtonActive(1)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetDelegate(handler(slot0, slot0.RefreshButton))
	slot2:Show(slot0.itemList_[slot1], slot1)
	slot2:ShowSelect(slot0.selectIndex_ == slot1)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID

	if not slot0.params_.skinID then
		slot0.skinID_ = HeroTools.HeroUsingSkinInfo(slot0.heroID_).id
	else
		slot0.skinID_ = slot0.params_.skinID
	end

	manager.ui:SetMainCamera("heroSkin")

	slot1 = CameraCfg.heroSkin
	slot2 = CameraCfg.hero

	slot0.heroAvatarView_:SetCameraOffset(Vector3(slot1.position[1] - slot2.position[1], slot1.position[2] - slot2.position[2], slot1.position[3] - slot2.position[3]), Vector3(slot1.rotate[1] - slot2.rotate[1], slot1.rotate[2] - slot2.rotate[2], slot1.rotate[3] - slot2.rotate[3]))
	slot0.heroAvatarView_:SetSkinId(slot0.skinID_)
	slot0.heroAvatarView_:ShowHeroModel(true)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0.heroAvatarView_:OnExit()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshUI(slot0)
	slot5 = slot0.SkinState

	slot0:RefreshInfo(slot0.skinID_, slot5(slot0, slot0.skinID_))

	slot4 = slot0.SkinState

	slot0:SetButtonActive(slot4(slot0, slot0.skinID_))
	slot0:RefreshItemData()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5 == slot0.skinID_ then
			slot0.selectIndex_ = slot4
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.itemList_, slot0.selectIndex_)
end

function slot0.RefreshUIWithOutScroll(slot0)
	slot0:RefreshInfo(slot0.skinID_, slot0:SkinState(slot0.skinID_))
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
end

function slot0.RefreshItemData(slot0)
	slot0.itemList_ = {}
	slot4 = slot0.heroID_

	for slot4, slot5 in ipairs(SkinCfg.get_id_list_by_hero[slot4]) do
		if not HeroTools.GetIsSkinHide(slot5) then
			if slot0:isUnlock(slot5) then
				table.insert(slot0.itemList_, slot5)
			elseif SkinCfg[slot5].display_type == 1 then
				table.insert(slot0.itemList_, slot5)
			elseif HeroTools.CanChangeSkin(slot5) then
				table.insert(slot0.itemList_, slot5)
			end
		end
	end

	if slot0.params_.skinID and not table.indexof(slot0.itemList_, slot0.params_.skinID) then
		table.insert(slot0.itemList_, slot0.params_.skinID)
	end
end

function slot0.SetSkinItem(slot0)
	slot0.skinTemplate_ = NewHeroSkinItem
end

function slot0.RefreshButton(slot0, slot1)
	slot0.selectIndex_ = slot1.index_
	slot2 = slot1:SkinState()
	slot3 = slot1.skinID_

	slot0:SetButtonActive(slot2)
	slot0.heroAvatarView_:SetSkinId(slot3)
	slot0.heroAvatarView_:ShowHeroModel(true)
	slot0:RefreshInfo(slot3, slot2)

	slot0.skinID_ = slot3

	slot0.scrollHelper_:Refresh()
end

function slot0.SetButtonActive(slot0, slot1)
	if slot0.btnState_ == slot1 then
		return
	end

	slot2 = nil

	if slot0.btnState_ then
		SetActive(slot0[slot0.btnState[slot0.btnState_] .. "Go_"], false)
	end

	SetActive(slot0[slot0.btnState[slot1] .. "Go_"], true)

	slot0.btnState_ = slot1
end

function slot0.RefreshInfo(slot0, slot1)
	slot0.nameText_.text = SkinCfg[slot1].name
	slot0.infoText_.text = SkinCfg[slot1].desc

	if HeroTools.GetSkinChangeItem(slot1) then
		slot0.sourcetextText_.text = ItemCfg[slot2].desc_source
		slot0.couponImg_.sprite = ItemTools.getItemLittleSprite(slot2)
	else
		slot0.sourcetextText_.text = ItemCfg[slot1].desc_source
	end

	if slot0.btnState_ == 6 then
		slot0.isCanUnlock_ = true

		for slot6, slot7 in pairs(SkinCfg[slot1].unlock_id_list) do
			slot8, slot9, slot10 = IsConditionAchieved(slot7, {
				heroId = slot0.heroID_
			})

			if slot8 then
				slot0["taskController_" .. slot6]:SetSelectedState("true")
			else
				slot0.isCanUnlock_ = false

				slot0["taskController_" .. slot6]:SetSelectedState("false")
			end

			slot0["tasktext_" .. slot6].text = ConditionCfg[slot7].desc
		end

		slot0.unlockController_:SetSelectedState(slot0.isCanUnlock_ and "false" or "true")
	end
end

function slot0.SkinState(slot0, slot1)
	if slot0:isUnlock(slot1) then
		if slot0:isSelect(slot1) then
			return 1
		end

		return 2
	else
		if HeroTools.CanChangeSkin(slot1) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(slot1) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(slot1) then
			return 4
		end

		return 3
	end
end

function slot0.HaveMaterial(slot0)
	if ItemCfg[ShopCfg[HeroTools.GetShopIdBySkinId(slot0.skinID_)].cost_id].type == ItemConst.ITEM_TYPE.CURRENCY then
		if slot1.cost_id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
			return CurrencyData:GetRechargeDiamond()
		end

		return CurrencyData:GetCurrencyNum(slot1.cost_id)
	elseif (slot2.type == ItemConst.ITEM_TYPE.MATERIAL or slot2.type == ItemConst.ITEM_TYPE.PROPS) and MaterialData:GetMaterialList()[slot1.cost_id] then
		return slot3.num
	end

	return slot2, 0
end

function slot0.GetCost(slot0)
	slot1 = ShopCfg[HeroTools.GetShopIdBySkinId(slot0.skinID_)]

	return ItemCfg[slot1.cost_id], ShopTools.GetPrice(slot1.goods_id)
end

function slot0.Dispose(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.PlayVoice(slot0)
	if slot0.delayPlayTimer_ then
		return
	end

	HeroTools.PlayVoice(slot0.heroID_, "cloth")

	slot0.delayPlayTimer_ = Timer.New(function ()
		if uv0.delayPlayTimer_ then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil
		end
	end, 10, -1)

	slot0.delayPlayTimer_:Start()
end

return slot0
