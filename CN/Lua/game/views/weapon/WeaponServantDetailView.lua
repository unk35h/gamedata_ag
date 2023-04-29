slot0 = class("WeaponServantDetailView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.watchFunc_ = nil

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveInstanceController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveInstance")
	slot0.lookController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "look")
	slot0.descBtnController_ = ControllerUtil.GetController(slot0.descBtnPanelGo_.transform, "btnState")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.lockbtnBtn_, nil, function ()
		ServantAction.ServantLock(uv0.weaponServantData_.uid)
	end)
	slot0:AddBtnListener(slot0.btnlook1Btn_, nil, function ()
		if uv0.watchFunc_ then
			uv0.watchFunc_(true)
		end
	end)
	slot0:AddBtnListener(slot0.simpleDescBtn_, nil, function ()
		uv0:RefreshEffectText(1)
	end)
	slot0:AddBtnListener(slot0.detailDescBtn_, nil, function ()
		uv0:RefreshEffectText(2)
	end)
end

function slot0.SetWeaponServantData(slot0, slot1, slot2, slot3)
	slot0.weaponServantData_ = slot1
	slot0.weaponServantCfg_ = WeaponServantCfg[slot0.weaponServantData_.id]
	slot0.itemCfg_ = ItemCfg[slot0.weaponServantData_.id]
	slot0.servantMap_ = ServantTools.GetServantMap()

	slot0:UpdateView(slot2, slot3)
	slot0.haveInstanceController_:SetSelectedState("true")
	SetActive(slot0.replaceGo_, true)
	SetActive(slot0.sleepybtnGo_, false)
end

function slot0.RefreshToSleepyServant(slot0, slot1)
	slot0.weaponServantData_ = {
		locked = 0,
		stage = 1,
		uid = 0,
		id = slot1
	}
	slot0.weaponServantCfg_ = WeaponServantCfg[slot0.weaponServantData_.id]
	slot0.itemCfg_ = ItemCfg[slot0.weaponServantData_.id]
	slot0.servantMap_ = ServantTools.GetServantMap()

	slot0:UpdateView()
	slot0.haveInstanceController_:SetSelectedState("false")
	SetActive(slot0.replaceGo_, false)
	SetActive(slot0.sleepybtnGo_, true)
end

function slot0.RegisterWatchFunc(slot0, slot1)
	slot0.watchFunc_ = slot1
end

function slot0.UpdateView(slot0, slot1, slot2)
	slot3 = slot0.weaponServantData_
	slot0.name_.text = slot0.itemCfg_.name

	slot0:RefreshStar(ItemCfg[slot3.id].rare)

	slot4 = slot3.stage
	slot5 = 0

	if slot1 and slot2 then
		slot5 = HeroTools.GetHeroWeaponAddLevel(HeroData:GetHeroData(slot2))
	end

	slot0.servantAddLv_ = slot5

	if slot5 > 0 then
		slot0.stage_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL"), slot4, slot5)
	else
		slot0.stage_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_1"), slot4)
	end

	slot6 = WeaponServantCfg[slot3.id].race
	slot0.raceText_.text = string.format(GetTips("EQUIP_RACE"), GetI18NText(RaceEffectCfg[slot6].name))
	slot0.raceiconImg_.sprite = getSprite("Atlas/CampItem", string.format("icon_group_%d_c", slot6))
	slot0.numberText_.text = "+" .. WeaponServantCfg[slot3.id].attrib_addition .. "%"
	slot0.strnameText_.text, slot9, slot0.strimgImg_.sprite = SkillTools.GetAttr(WeaponServantCfg[slot3.id].attribute)
	slot0.strnumText_.text = "+" .. slot9

	slot0:RefreshLock(slot3.locked == 1)

	slot0.descType_ = slot0.descType_ or 1

	if slot0.canSwitchDesc_ == true then
		slot0:RefreshEffectText(slot0.descType_)
	end

	if not slot0.servantMap_[slot3.uid] then
		SetActive(slot0.statusGo_, false)
	else
		SetActive(slot0.statusGo_, true)

		slot0.whoiconImg_.sprite = HeroTools.GetSmallHeadSprite(slot11)
		slot0.usetextText_.text = string.format(GetTips("SERVANT_EQUIPED"), GetI18NText(HeroCfg[slot11].name))
	end

	slot0.shortdescText_.text = WeaponServantCfg[slot3.id].desc
	slot13 = 0

	if WeaponServantCfg[slot3.id].effect[1] > 0 then
		slot13 = WeaponEffectCfg[slot12].spec_char[1]
	end

	if slot13 ~= nil and slot13 > 0 then
		SetActive(slot0.recommendGo_, true)

		slot0.recommendWhoIconImg_.sprite = HeroTools.GetSmallHeadSprite(slot13)
	else
		SetActive(slot0.recommendGo_, false)
	end

	slot0.skilleffectSrex_.normalizedPosition = Vector2(0, 1)
end

function slot0.RefreshEffectText(slot0, slot1)
	if slot1 == 1 then
		slot0.skillcontentText_.text = ServantTools.GetServantEffect(slot0.weaponServantData_.id, nil, true)
	else
		slot0.skillcontentText_.text = ServantTools.GetServantEffect(slot0.weaponServantData_.id, slot0.weaponServantData_.stage + slot0.servantAddLv_)
	end

	slot0.descType_ = slot1

	slot0.descBtnController_:SetSelectedState(tostring(slot1))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.RefreshStar(slot0, slot1)
	for slot5 = 1, 5 do
		SetActive(slot0["star" .. slot5 .. "_"], slot5 <= slot1)
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

function slot0.SetLockBtn(slot0, slot1)
	slot0.haveInstanceController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetLookBtn(slot0, slot1)
	slot0.lookController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetDescBtn(slot0, slot1)
	slot0.canSwitchDesc_ = slot1

	SetActive(slot0.descBtnPanelGo_, slot1)
end

function slot0.OnServantLock(slot0, slot1, slot2)
	if slot1 == slot0.weaponServantData_.uid then
		slot0:RefreshLock(slot2 == 1)
	end
end

function slot0.OnEnter(slot0)
	slot0.onServantLockHandler_ = handler(slot0, slot0.OnServantLock)

	manager.notify:RegistListener(SERVANT_LOCK, slot0.onServantLockHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SERVANT_LOCK, slot0.onServantLockHandler_)

	slot0.descType_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
