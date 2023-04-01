slot0 = class("WeaponServantStrPage", ReduxView)
slot1 = "CD421E"
slot2 = "363A42"
slot3 = {
	MATERIAL = 1,
	ITEM = 0
}

function slot4(slot0)
	table.sort(slot0, function (slot0, slot1)
		if WeaponServantData:GetServantDataByUID(slot0).stage ~= WeaponServantData:GetServantDataByUID(slot1).stage then
			return slot2.stage < slot3.stage
		end

		return slot2.uid < slot3.uid
	end)
end

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.strCon_ = ControllerUtil.GetController(slot0.transform_, "strCon")
	slot0.costCon_ = ControllerUtil.GetController(slot0.choice2Trs_, "conName")
	slot0.costItem_ = CommonItem.New(slot0.costservantGo_)
	slot0.costMaterial_ = CommonItem.New(slot0.costmaterialGo_)
	slot0.costItemCon_ = ControllerUtil.GetController(slot0.costservantpTrs_, "conName")
	slot0.costMaterialCon_ = ControllerUtil.GetController(slot0.costmaterialpTrs_, "conName")

	slot0.costMaterial_:SetSelectType("equip")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.strengthBtn_, nil, function ()
		print("Locked:", uv0.mainServant_.locked, "Stage:", uv0.mainServant_.stage, "UID:", uv0.mainServant_.uid, "ID:", uv0.mainServant_.id, "State:", uv0.params_.state, "StrSelect", uv0.params_.strSelect, "costUid:", uv0.servantS_[1])

		if WeaponServantData:GetServantDataByUID(uv0.mainServant_.uid) == nil then
			print("servant info is null")
		end

		slot0 = nil

		function slot1()
			slot0 = WeaponServantData:GetServantDataByUID(uv0.mainServant_.uid)

			if checkGold(ServantTools.ServantBreakCost(WeaponServantCfg[slot0.id].starlevel, slot0.stage)) then
				ServantAction.ServantPromote(uv0.params_.strSelect, uv0.mainServant_.uid, uv1, slot3)
			end
		end

		if uv0.params_.strSelect == uv1.ITEM then
			if not uv0.servantS_[1] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

				return
			end

			if WeaponServantData:GetServantDataByUID(slot0).stage > 1 then
				ShowMessageBox({
					content = string.format(GetTips("SERVANT_CONSUME_CONFIRM"), WeaponServantData:GetServantDataByUID(slot0).stage),
					OkCallback = slot1
				})

				return
			end

			slot2 = SettingData:GetRemindSettingData()

			if not _G.SkipTip.SkipServantPromoteRefineTip and slot2.servant_promote_reminder == 1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("SERVANT_TRANSCEND_BY_SERVANT"), ItemCfg[uv0.mainServant_.id].name),
					OkCallback = function ()
						_G.SkipTip.SkipServantPromoteRefineTip = uv0.SkipServantPromoteRefineTip_

						uv1()
					end,
					ToggleCallback = function (slot0)
						uv0.SkipServantPromoteRefineTip_ = slot0
					end
				})

				return
			end
		else
			slot3 = ServantTools.ServantBreakMaterialCost(uv0.mainServant_.id, WeaponServantCfg[uv0.mainServant_.id].starlevel)

			if MaterialData:GetMaterial(slot3[1]).num < slot3[2] then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

				return
			end

			slot5 = SettingData:GetRemindSettingData()
			slot6 = ServantTools.ServantBreakMaterialCost(uv0.mainServant_.id, slot2)

			if not _G.SkipTip.SkipSpiritRefineTip and slot5.spirit_refine_reminder == 1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = string.format(GetTips("SERVANT_TRANSCEND"), slot6[2]),
					OkCallback = function ()
						_G.SkipTip.SkipSpiritRefineTip = uv0.SkipSpiritRefineTip_

						uv1()
					end,
					ToggleCallback = function (slot0)
						uv0.SkipSpiritRefineTip_ = slot0
					end
				})

				return
			end
		end

		slot1()
	end)
	slot0:AddBtnListener(slot0.costservantpBtn_, nil, function ()
		if uv0.params_.strSelect ~= uv1.ITEM then
			uv0.costMaterialCon_:SetSelectedState(0)
			uv0.costItemCon_:SetSelectedState(1)

			uv0.params_.strSelect = uv1.ITEM
		end
	end)
	slot0:AddBtnListener(slot0.costmaterialpBtn_, nil, function ()
		if uv0.params_.strSelect ~= uv1.MATERIAL then
			uv0.costItemCon_:SetSelectedState(0)
			uv0.costMaterialCon_:SetSelectedState(1)

			uv0.params_.strSelect = uv1.MATERIAL
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.servantS_ = ServantTools.GetServantByIDLimited(slot1.id, true, true, slot1.uid)

	uv0(slot0.servantS_)

	if GameSetting.weapon_promote_max.value[WeaponServantCfg[slot1.id].starlevel] + 1 <= slot1.stage then
		slot0.strCon_:SetSelectedState("max")

		slot0.originText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), slot4)
		slot0.strdescText_.text = ServantTools.GetServantEffect(slot1.id, slot1.stage)

		return
	end

	slot0.strCon_:SetSelectedState("normal")

	slot0.strdescText_.text = ServantTools.GetServantEffect(slot1.id, slot1.stage + 1)
	slot0.originText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), slot1.stage)
	slot0.afterText_.text = string.format(GetTips("SERVANT_PROMOTE_LEVEL_2"), slot1.stage + 1)
	slot0.mainServant_ = slot1
	slot0.cost_ = ServantTools.ServantBreakCost(WeaponServantCfg[slot1.id].starlevel, slot1.stage)
	slot0.costgoldText_.text = setTextColor(uv1, uv2, slot0.cost_, CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD))
	slot0.params_ = slot2
	slot0.params_.strSelect = slot2.strSelect or uv3.ITEM

	if slot6 == 3 then
		slot0.costCon_:SetSelectedState("1")
		slot0:RefreshStrengthItem(true)

		slot0.params_.strSelect = uv3.ITEM
	else
		slot0.costCon_:SetSelectedState("2")
		slot0:RefreshStrengthItem()
	end

	slot0.costItemCon_:SetSelectedState(slot0.params_.strSelect == uv3.ITEM and 1 or 0)
	slot0.costMaterialCon_:SetSelectedState(slot0.params_.strSelect == uv3.MATERIAL and 1 or 0)
end

function slot0.RefreshGoldText(slot0)
	slot1 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)

	if slot0.cost_ ~= nil then
		slot0.costgoldText_.text = setTextColor(uv0, uv1, slot0.cost_, slot1)
	end
end

function slot0.RefreshStrengthItem(slot0, slot1)
	slot0.costItem_:RefreshData({
		id = slot0.mainServant_.id,
		number = setTextColor(uv0, "33363B", #slot0.servantS_, 1, function (slot0, slot1)
			return slot0 < slot1
		end) .. "/" .. 1
	})

	slot0.costservantnameText_.text = ItemCfg[slot0.mainServant_.id].name

	if not slot1 then
		slot5 = ServantTools.ServantBreakMaterialCost(slot0.mainServant_.id, WeaponServantCfg[slot0.mainServant_.id].starlevel)
		slot6 = slot5[1]
		slot8 = slot5[2]

		slot0.costMaterial_:RefreshData({
			id = slot6,
			number = setTextColor(uv0, "33363B", MaterialData:GetMaterial(slot6).num, slot8, function (slot0, slot1)
				return slot0 < slot1
			end) .. "/" .. slot8
		})

		slot0.costmaterialnameText_.text = ItemCfg[slot6].name
	end
end

function slot0.Dispose(slot0)
	slot0.costItem_:Dispose()
	slot0.costMaterial_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
