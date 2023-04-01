slot0 = class("NewHeroWeaponPage", NewHeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.weaponInfo_ = {}
	slot0.heroInfo_ = {}
	slot0.servantInfo_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetHeroInfo(slot0, slot1)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.heroInfo_ = ForeignInfoData:GetHeroInfo(slot1.id)
		elseif slot0.isTemp_ then
			slot0.heroInfo_ = TempHeroData:GetHeroDataByHeroID(slot0.extra_.tempHeroList, slot1.id)
		elseif slot0.isPolyhedron_ then
			slot0.heroInfo_ = PolyhedronData:GetPolyhedronHeroData(slot1.id)
		end
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)

		manager.redPoint:bindUIandKey(slot0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroInfo_.id)
	end

	manager.redPoint:bindUIandKey(slot0.weaponstrengthTrs_, RedPointConst.HERO_WEAPON_BREAK_ID .. slot0.heroInfo_.id)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.servantInfo_ = ForeignInfoData:GetHeroServantInfo(slot0.heroInfo_.id)
		elseif slot0.isTemp_ then
			slot0.servantInfo_ = TempHeroData:GetHeroServantInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id)
		elseif slot0.isPolyhedron_ then
			slot0.servantInfo_ = slot0.heroInfo_.servant
		end
	else
		slot0.servantInfo_ = HeroTools.GetHeroServantInfo(slot0.heroInfo_.id)
	end

	slot0:RefreshServant(slot0.servantInfo_)
	slot0:RefreshWeapon()
	slot0:RefreshStrengthText()
end

function slot0.RefreshStrengthText(slot0)
	slot1 = ""
	slot0.weaponstrengthText_.text = (HeroData:GetHeroList()[slot0.heroInfo_.id].weapon_info.level ~= HeroConst.WEAPON_LV_MAX or GetTips("TIP_DETAIL")) and (GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] ~= slot0.weaponInfo_.level or slot0.weaponInfo_.level == HeroConst.WEAPON_LV_MAX or GetTips("TIP_BREAK")) and GetTips("TIP_STRENGTH")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.weaponstrengthBtn_, nil, function ()
		if HeroData:GetHeroList()[uv0.heroInfo_.id].weapon_info.level == HeroConst.WEAPON_LV_MAX then
			uv0:Go("/weapon", {
				state = "detail",
				HeroID = uv0.heroInfo_.id
			})

			return
		end

		uv0:Go("/weapon", {
			state = "strength",
			HeroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.strengthBtn_, nil, function ()
		if uv0.btnStatus_ == "PROMOTE" then
			uv0:Go("/weaponServant", {
				state = "strength",
				HeroID = uv0.heroInfo_.id
			})
		elseif uv0.btnStatus_ == "MERGE" then
			slot0 = HeroTools.GetHeroSpecServant(uv0.heroInfo_.id)

			uv0:Go("/weaponServantMerge", {
				race = WeaponServantCfg[slot0].race,
				servantID = slot0,
				costUid = uv0.heroInfo_.servantInfo.uid
			})
		end
	end)
	slot0:AddBtnListener(slot0.emptyreplaceBtn_, nil, function ()
		if uv0.extra_ then
			return
		end

		slot1 = HeroCfg[uv0.heroInfo_.id].race
		slot2 = {}

		for slot6, slot7 in pairs(WeaponServantData:GetWeaponServantList()) do
			if WeaponServantCfg[slot7.id].race == slot1 then
				table.insert(slot2, slot7)
			end
		end

		if #slot2 == 0 then
			ShowTips("NO_SERVANT_CAN_BE_EQUIPED")

			return
		end

		uv0:Go("/weaponServant", {
			state = "replace",
			HeroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.replaceBtn_, nil, function ()
		uv0:Go("/weaponServant", {
			state = "replace",
			HeroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.lockBtn_, nil, function ()
		ServantAction.ServantLock(uv0.servantInfo_.uid)
	end)
	slot0:AddBtnListener(slot0.servantcontentBtn_, nil, function ()
		if uv0.extra_ then
			return
		end

		if WeaponServantCfg[HeroTools.GetHeroServantInfo(uv0.heroInfo_.id).id].type == 3 then
			JumpTools.OpenPageByJump("/showServantView", {
				look = true,
				state = "onlydetail",
				id = slot0.id
			})
		else
			uv0:Go("/weaponServant", {
				state = "detail",
				HeroID = uv0.heroInfo_.id
			})
		end
	end)
	slot0:AddBtnListener(slot0.moduleView_, nil, function ()
		if uv0.extra_ then
			return
		end

		if WeaponModuleCfg[uv0.heroInfo_.id] then
			JumpTools.OpenPageByJump("/weaponModuleView", {
				heroID = uv0.heroInfo_.id
			})
		end
	end)
end

function slot0.OnServantLock(slot0, slot1, slot2)
	slot0.servantInfo_ = HeroTools.GetHeroServantInfo(slot0.heroInfo_.id)

	slot0:RefreshLock(slot0.servantInfo_.locked == 1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pageController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.servantRareController_ = ControllerUtil.GetController(slot0.transform_, "servantRare")
	slot0.isSelfController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isSelf")
	slot0.moduleController_ = ControllerUtil.GetController(slot0.moduleView_.transform, "module")
	slot0.btnStatus_ = "MERGE"
end

function slot0.RefreshWeapon(slot0)
	slot0.weaponInfo_ = nil
	slot1 = slot0.heroInfo_.id

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.weaponInfo_ = deepClone(ForeignInfoData:GetHeroInfo(slot0.heroInfo_.id).weapon_info)

			if WeaponModuleCfg[slot1] then
				SetActive(slot0.moduleView_.gameObject, true)

				if ForeignInfoData:GetForeignModuleLevelByHeroID(slot1) == 0 then
					slot0.moduleController_:SetSelectedState("lock")
				else
					slot0.moduleController_:SetSelectedState("unlock")

					slot0.moduleNameText_.text = WeaponModuleCfg[slot1].name
					slot0.moduleImage_.sprite = getSpriteWithoutAtlas("Textures/WeaponModule/" .. slot1)
					slot0.levelText_.text = slot2
				end
			else
				SetActive(slot0.moduleView_.gameObject, false)
			end
		elseif slot0.isTemp_ then
			slot0.weaponInfo_ = deepClone(TempHeroData:GetHeroWeaponInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id))

			SetActive(slot0.moduleView_.gameObject, false)
		elseif slot0.isPolyhedron_ then
			slot0.weaponInfo_ = deepClone(PolyhedronData:GetPolyhedronHeroData(slot0.heroInfo_.id).weapon_info)

			if WeaponModuleCfg[slot1] then
				SetActive(slot0.moduleView_.gameObject, true)

				if HeroData:GetCurModuleLevel(slot1) == 0 then
					slot0.moduleController_:SetSelectedState("lock")
				else
					slot0.moduleController_:SetSelectedState("unlock")

					slot0.moduleNameText_.text = WeaponModuleCfg[slot1].name
					slot0.moduleImage_.sprite = getSpriteWithoutAtlas("Textures/WeaponModule/" .. slot1)
					slot0.levelText_.text = slot2
				end
			else
				SetActive(slot0.moduleView_.gameObject, false)
			end
		end
	else
		slot0.weaponInfo_ = deepClone(HeroData:GetHeroList()[slot0.heroInfo_.id].weapon_info)

		if WeaponModuleCfg[slot1] then
			SetActive(slot0.moduleView_.gameObject, true)

			if HeroData:GetCurModuleLevel(slot1) == 0 then
				slot0.moduleController_:SetSelectedState("lock")
			else
				slot0.moduleController_:SetSelectedState("unlock")

				slot0.moduleNameText_.text = WeaponModuleCfg[slot1].name
				slot0.moduleImage_.sprite = getSpriteWithoutAtlas("Textures/WeaponModule/" .. slot1)
				slot0.levelText_.text = slot2
			end
		else
			SetActive(slot0.moduleView_.gameObject, false)
		end
	end

	slot2, slot0.nowlvText_.text = WeaponTools.AddWeaponExp(slot0.weaponInfo_.exp, slot0.weaponInfo_.breakthrough, 0)
	slot0.nameText_.text = HeroCfg[slot1].weapon_name
	slot0.toplvText_.text = "/" .. GameSetting.weapon_exp_limit.value[slot0.weaponInfo_.breakthrough + 1] or HeroConst.WEAPON_LV_MAX

	if slot3 == HeroConst.WEAPON_LV_MAX then
		slot0:RefreshExpBar(1)

		slot0.expText_.text = "--/--"
	else
		slot4 = GameLevelSetting[slot3].weapon_level_exp

		slot0:RefreshExpBar(slot2 / slot4)

		slot0.expText_.text = slot2 .. "/" .. slot4
	end

	slot4 = WeaponTools.WeaponAtk(slot0.weaponInfo_.level, slot0.weaponInfo_.breakthrough)
	slot5, slot6 = nil

	if slot0.extra_ then
		if slot0.isForeign_ then
			slot5 = ForeignInfoData:GetHeroServantInfo(slot0.heroInfo_.id)
		elseif slot0.isTemp_ then
			slot5 = TempHeroData:GetHeroServantInfo(slot0.extra_.tempHeroList, slot0.heroInfo_.id)
		elseif slot0.isPolyhedron_ then
			slot5 = HeroTools.GetHeroServantInfo(slot1)
		end
	else
		slot5 = HeroTools.GetHeroServantInfo(slot1)
	end

	if slot5 then
		slot0.atkText_.text = string.format("%d<color=#FFE400>+%d</color>", slot4, WeaponServantCfg[slot5.id].attrib_addition * slot4 / 100)
	else
		slot0.atkText_.text = string.format("%d", slot4)
	end

	slot0.crinameText_.text, slot0.criText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot0.weaponInfo_.breakthrough + 1])
end

function slot0.RefreshExpBar(slot0, slot1)
	slot0.expbarTrs_.sizeDelta = Vector2(slot0.progressTrs_.rect.width * slot1, slot0.progressTrs_.rect.height)
end

function slot0.RefreshServant(slot0, slot1)
	if not slot1 or not slot1.id then
		slot0.pageController_:SetSelectedState("lock")

		return
	end

	slot0.pageController_:SetSelectedState("unlock")

	slot2 = WeaponServantCfg[slot1.id]
	slot0.servantnameText_.text = ItemCfg[slot1.id].name

	slot0:RefreshStar(slot2.starlevel)
	slot0.servantRareController_:SetSelectedState(tostring(slot2.starlevel))

	slot0.servanticonImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.ServantIcon438.path .. slot1.id)
	slot0.raceImg_.sprite = getSprite("Atlas/CampItem", string.format("icon_group_%d_c", WeaponServantCfg[slot1.id].race))
	slot7 = slot1.stage

	if HeroTools.GetHeroWeaponAddLevel(slot0.heroInfo_) > 0 then
		slot0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), slot7, slot6)
	else
		slot0.refinetextText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), slot7)
	end

	slot0.servantdescText_.text = ServantTools.GetServantEffect(slot1.id, slot7 + slot6, false, slot0.extra_)

	if slot3.type == 3 then
		slot0.btnStatus_ = "MERGE"
		slot0.btnText_.text = GetTips("SERVANT_MERGE")
	else
		slot0.btnStatus_ = "PROMOTE"
		slot0.btnText_.text = GetTips("PROMOTE")
	end

	slot0:RefreshLock(slot1.locked == 1)
end

function slot0.RefreshStar(slot0, slot1)
	for slot5 = 1, 5 do
		SetActive(slot0["star" .. slot5], slot5 <= slot1)
	end
end

function slot0.RefreshLock(slot0, slot1)
	if slot1 then
		SetActive(slot0.openGo_, false)
		SetActive(slot0.closeGo_, true)
	else
		SetActive(slot0.openGo_, true)
		SetActive(slot0.closeGo_, false)
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
	manager.redPoint:unbindUIandKey(slot0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroInfo_.id)
	HeroTools.StopTalk()
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron

	slot0.isSelfController_:SetSelectedState(slot0.extra_ and "true" or "false")
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.weaponstrengthTrs_)
	manager.redPoint:unbindUIandKey(slot0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroInfo_.id)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
