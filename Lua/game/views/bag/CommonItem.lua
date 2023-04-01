slot0 = class("CommonItem", ReduxView)
CLICK_MODE = {
	LONG = 2,
	SINGLE = 1
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:UpdateView()
end

function slot0.RefreshData(slot0, slot1)
	slot0.info_ = slot1

	if slot1 == nil then
		return
	end

	slot2 = nil

	slot0:UpdateType((not slot1.type or slot1.type) and (not ItemCfg[slot1.id] or ItemCfg[slot1.id].type) and ItemConst.ITEM_TYPE.MATERIAL)
	slot0:UpdateView()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
	slot0.qualityController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "quality")
	slot0.campController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "camp")
	slot0.lockedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "locked")
	slot0.usingController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "using")
	slot0.selectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selected")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "grade")
	slot0.enchantmentController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "enchantment")
	slot0.selectTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selectType")
	slot0.floorController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "floor")
	slot0.countdownStatusController_ = ControllerUtil.GetController(slot0.countdownGo_.transform, "countdownStatus")
	slot0.geryController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "grey")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.clickMode_ == CLICK_MODE.SINGLE and uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)
	slot0:AddPressingByTimeListener(slot0.longClickBtn_, 3, 0.5, 0.2, function ()
		if uv0.clickLongFunc and uv0.clickMode_ == CLICK_MODE.LONG then
			return uv0.clickLongFunc(uv0.info_)
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.clickCutBtn_, 3, 0.5, 0.2, function ()
		if uv0.clickCutFunc then
			return uv0.clickCutFunc(uv0.info_)
		end

		return false
	end)

	if slot0.clickGaryBtn_ then
		slot0:AddBtnListener(slot0.clickGaryBtn_, nil, function ()
			if uv0.clickGaryFunc then
				uv0.clickGaryFunc(uv0.info_)
			end
		end)
	end
end

function slot0.ResetTransform(slot0)
	slot0.transform_.localPosition = Vector3(0, 0, 0)
	slot0.transform_.localScale = Vector3(1, 1, 1)
	slot0.transform_.localEulerAngles = Vector3.New(0, 0, 0)
end

function slot0.SetScale(slot0, slot1)
	slot0.transform_.localScale = slot1
end

function slot0.SetSelectType(slot0, slot1)
	slot0.manualSelectType_ = slot1

	slot0.selectTypeController_:SetSelectedState(slot1)
end

function slot0.UpdateType(slot0, slot1)
	if ItemConst.ITEM_TYPE.CURRENCY == slot1 or ItemConst.ITEM_TYPE.MATERIAL == slot1 or ItemConst.ITEM_TYPE.PROPS == slot1 or ItemConst.ITEM_TYPE.GIFT == slot1 or ItemConst.ITEM_TYPE.ARCHIVE_GIFT == slot1 then
		slot0.typeController_:SetSelectedState("material")

		slot0.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.HERO_PIECE == slot1 then
		slot0.typeController_:SetSelectedState("heroPiece")

		slot0.defaultSelectType_ = "item"
	elseif ItemConst.ITEM_TYPE.EQUIP == slot1 then
		slot0.typeController_:SetSelectedState("equip")

		slot0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.WEAPON_SERVANT == slot1 then
		slot0.typeController_:SetSelectedState("weaponServant")

		slot0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO == slot1 then
		slot0.typeController_:SetSelectedState("hero")

		slot0.defaultSelectType_ = "equip"
	elseif ItemConst.ITEM_TYPE.HERO_SKIN == slot1 then
		slot0.typeController_:SetSelectedState("heroSkin")

		slot0.defaultSelectType_ = "equip"
	else
		slot0.typeController_:SetSelectedState("material")

		slot0.defaultSelectType_ = "item"
	end
end

function slot0.UpdateView(slot0)
	if slot0.info_ == nil then
		return
	end

	slot0:UpdateIcon()
	slot0:UpdateName()
	slot0:UpdateRareBg()
	slot0:UpdateStar()

	if slot0.typeController_:GetSelectedState() == "material" then
		slot0:UpdateMaterialView()
	elseif slot0.typeController_:GetSelectedState() == "heroPiece" then
		slot0:UpdateHeroPieceView()
	elseif slot0.typeController_:GetSelectedState() == "weaponServant" then
		slot0:UpdateWeaponServantView()
	elseif slot0.typeController_:GetSelectedState() == "equip" then
		slot0:UpdateEquipView()
	elseif slot0.typeController_:GetSelectedState() == "hero" then
		slot0:UpdateHeroView()
	elseif slot0.typeController_:GetSelectedState() == "heroSkin" then
		slot0:UpdateHeroSkinView()
	end
end

function slot0.UpdateMaterialView(slot0)
	slot0:ShowLock(slot0.info_.locked == 1)

	if slot0.info_.number then
		slot0:SetBottomText(slot0.info_.number)
	end
end

function slot0.UpdateHeroPieceView(slot0)
	if slot0.info_.number then
		slot0:SetBottomText(slot0.info_.number)
	end

	slot0:UpdateCamp(HeroCfg[slot0.info_.id % 10000].race)
	slot0:ShowLock(slot0.info_.locked == 1)
end

function slot0.UpdateWeaponServantView(slot0)
	if slot0.refineText_ then
		if not slot0.info_.isEquip then
			slot0.refineText_.text = ""
		else
			slot0.refineText_.text = GetTips("PROMOTE")
		end
	end

	if slot0.info_.isAdd then
		slot0.servantStageText_.text = "<color=#FF9500>" .. tostring(slot0.info_.number) .. "</color>"
	else
		slot0.servantStageText_.text = tostring(slot0.info_.number)
	end

	if slot0.severantRect_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.severantRect_)
	end

	slot1 = false
	slot2 = 0

	if slot0.info_.equiping and slot0.info_.equiping.heroId > 0 then
		slot1 = true
		slot2 = slot0.info_.equiping.heroId
	end

	slot0:ShowEquiping(slot1, slot2)
	slot0:UpdateCamp(WeaponServantCfg[slot0.info_.id].race)
	slot0:ShowLock(slot0.info_.locked == 1)
end

function slot0.UpdateEquipView(slot0)
	slot0:UpdateLevel(slot0.info_.level or 1)

	if slot0.typeController_:GetSelectedState() == "equip" and slot0.info_.equip_lv then
		slot0.num_.text = GetTips("LEVEL") .. string.format("%d", slot0.info_.equip_lv)
	end

	slot1 = false
	slot2 = 0

	if slot0.info_.equiping and slot0.info_.equiping.heroId > 0 then
		slot1 = true
		slot2 = slot0.info_.equiping.heroId
	end

	slot0:ShowEquiping(slot1, slot2)

	slot0.equipPosTrs_.localEulerAngles = Vector3.New(0, 0, 60 * (EquipCfg[slot0.info_.id].pos - 1))

	slot0.enchantmentController_:SetSelectedIndex(slot0.info_.equip_info and slot0.info_.equip_info:GetEnchantCount() or 0)
	slot0:ShowLock(slot0.info_.equip_info and slot0.info_.equip_info.is_lock or false)

	slot5 = nil
	slot6 = RaceEffectCfg.all

	if (slot0.info_.equip_info and (slot0.info_.equip_info.race or 0) or slot0.info_.race or 0) == 0 or table.keyof(slot6, slot5) ~= nil then
		SetActive(slot0.equiHeroRebuildGo_, false)
		slot0:UpdateCamp(slot5)
	else
		slot0.equiHeroRebuildImg_.sprite = HeroTools.GetSmallHeadSprite(slot5)

		SetActive(slot0.equiHeroRebuildGo_, true)
		slot0:UpdateCamp(0)
	end
end

function slot0.UpdateAnimator(slot0)
	slot0.mainAni_:Play(slot0.mainAni_:GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 0)

	slot0.mainAni_.enabled = true
end

function slot0.StopAnimator(slot0)
	slot0.mainAni_:Play(slot0.mainAni_:GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 1)
end

function slot0.UpdateHeroView(slot0)
	slot0:UpdateLevel(slot0.info_.level or 1)

	slot1 = HeroCfg[slot0.info_.id]

	slot0.gradeController_:SetSelectedState(HeroStarCfg[slot0.info_.star or slot1.unlock_star] ~= nil and slot2.star or 1 or 1)
	slot0:UpdateCamp(slot1.race)
	slot0:ShowLock(slot0.info_.locked == 1)
end

function slot0.UpdateHeroSkinView(slot0)
	slot0:ShowLock(slot0.info_.locked == 1)
	slot0:UpdateIcon()
	slot0:SetBottomText(slot0.info_.number or 1)
end

function slot0.UpdateIcon(slot0)
	slot0.icon_.enabled = false

	ItemTools.GetItemSpriteAsync(slot0.info_.id, function (slot0, slot1)
		if uv0.disposed_ then
			return
		end

		if slot0 == uv0.info_.id then
			uv0.icon_.enabled = true
			uv0.icon_.sprite = slot1

			if ItemCfg[slot0] then
				uv0:ResizeIcon(slot0)
			end
		end
	end, slot0.info_.iconPath)
end

function slot0.ResizeIcon(slot0, slot1)
	if ItemCfg[slot1].type ~= ItemConst.ITEM_TYPE.STICKER and ItemCfg[slot1].type ~= ItemConst.ITEM_TYPE.EQUIP then
		slot0.icon_:SetNativeSize()
	end
end

function slot0.UpdateName(slot0)
	if ItemCfg[slot0.info_.id] then
		slot0.nameText_.text = slot1.name
	end
end

function slot0.UpdateStar(slot0)
	slot1 = 0

	if ItemCfg[slot0.info_.id] then
		slot1 = slot2.display_rare
	end

	if (slot0.info_.equip_star or slot0.info_.star or getItemStar(slot0.info_.id)) > 0 then
		slot1 = slot3
	end

	slot0.starController_:SetSelectedState(tostring(slot1))
end

function slot0.UpdateRareBg(slot0)
	if ItemCfg[slot0.info_.id] then
		slot0.qualityController_:SetSelectedState(tostring(slot1.display_rare))
	end
end

function slot0.ShowName(slot0, slot1)
	SetActive(slot0.nameText_.gameObject, slot1)
end

function slot0.ShowEquiping(slot0, slot1, slot2)
	slot0.usingController_:SetSelectedState(slot1 and "true" or "false")

	if slot1 then
		slot0.whoIconImg_.sprite = HeroTools.GetSmallHeadSprite(slot2)
	end
end

function slot0.ShowLock(slot0, slot1)
	slot0.lockedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.ShowNew(slot0, slot1)
	SetActive(slot0.new_, slot1)
end

function slot0.SetBottomText(slot0, slot1)
	slot0.num_.text = slot1

	if slot0.boxImage_ ~= nil then
		slot0.boxImage_.enabled = #(slot1 and tostring(slot1) or "") > 0
	end
end

function slot0.SetBottomTextColor(slot0, slot1)
	slot0.num_.color = slot1
end

function slot0.SetIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.ShowBlackBack(slot0, slot1)
end

function slot0.UpdateTime(slot0)
	slot1 = slot0.countdownStatusController_
	slot2 = ItemCfg[slot0.info_.id]

	if ItemTools.GetItemExpiredTimeByInfo(slot0.info_) == nil or slot3 == 0 then
		slot1:SetSelectedState("noLimit")
	elseif ItemTools.IsItemExpired(slot0.info_) then
		slot1:SetSelectedState("expired")
	elseif slot0.info_.time_valid then
		slot1:SetSelectedState("countdowning")

		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStr(ItemTools.GetItemExpiredTimeByInfo(slot0.info_), nil, true)
	else
		slot1:SetSelectedState("noLimit")
	end
end

function slot0.UpdateCamp(slot0, slot1)
	if slot1 == 0 then
		slot0.campController_:SetSelectedState("noCamp")
		SetActive(slot0.campPanelGo_, false)
	else
		slot0.campController_:SetSelectedState(tostring(slot1))
		SetActive(slot0.campPanelGo_, true)
	end

	if slot0.functionTrans_ then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.functionTrans_)
	end
end

function slot0.UpdateLevel(slot0, slot1)
	slot0:SetBottomText(tostring(slot1))
end

function slot0.ShowSelect(slot0, slot1)
	type(slot1)

	slot2 = false

	if type(slot1) == "number" then
		if slot1 > 0 then
			slot2 = true
		end
	else
		slot2 = slot1
	end

	slot0.selectTypeController_:SetSelectedState(slot0.manualSelectType_ or slot0.defaultSelectType_)

	if slot2 then
		slot0.selectedController_:SetSelectedState("true")

		if ItemConst.ITEM_TYPE.EQUIP ~= ItemCfg[slot0.info_.id].type then
			slot0.selectNum_.text = "x" .. slot1
		end
	else
		slot0.selectedController_:SetSelectedState("false")
		slot0:StopLongClickTimer()
	end
end

function slot0.HideNum(slot0)
	slot0:SetBottomText("")
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.ShowFloor(slot0, slot1)
	slot0.floorController_:SetSelectedState(slot1 or ItemConst.ITEM_FLOOR.LONG)
end

function slot0.SetGrey(slot0, slot1)
	slot0.geryController_:SetSelectedState(slot1)
end

function slot0.HideServantTxt(slot0)
	SetActive(slot0.severantGo_, false)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickMode_ = CLICK_MODE.SINGLE
	slot0.clickFunc = slot1

	SetActive(slot0.longClickBtn_, false)
end

function slot0.RegistLongCallBack(slot0, slot1)
	slot0.clickMode_ = CLICK_MODE.LONG
	slot0.clickLongFunc = slot1

	SetActive(slot0.longClickBtn_, true)
end

function slot0.RegistCutCallBack(slot0, slot1)
	slot0.clickCutFunc = slot1
end

function slot0.RegistGaryCallBack(slot0, slot1)
	slot0.clickGaryFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.disposed_ = true
end

return slot0
