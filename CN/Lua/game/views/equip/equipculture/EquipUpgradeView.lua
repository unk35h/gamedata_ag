slot0 = class("EquipUpgradeView", ReduxView)
slot1 = import("game.const.HeroConst")

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipUpgradeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrIcon_ = {}
	slot0.attrName_ = {}
	slot0.attrOld_ = {}
	slot0.attrNew_ = {}

	for slot4 = 1, 2 do
		slot0.attrIcon_[slot4] = slot0:FindCom(typeof(Image), "panel/right/promoteViewUI/content/property/attritem" .. slot4 .. "/icon")
		slot0.attrName_[slot4] = slot0:FindCom(typeof(Text), "panel/right/promoteViewUI/content/property/attritem" .. slot4 .. "/text")
		slot0.attrOld_[slot4] = slot0:FindCom(typeof(Text), "panel/right/promoteViewUI/content/property/attritem" .. slot4 .. "/present")
		slot0.attrNew_[slot4] = slot0:FindCom(typeof(Text), "panel/right/promoteViewUI/content/property/attritem" .. slot4 .. "/num")
	end

	slot0.item_ = Asset.Load("UI/Common/CommonItem")
	slot0.costItem = {}

	for slot4 = 1, 3 do
		slot5 = Object.Instantiate(slot0.item_, slot0.layout_)
		slot5.transform.localScale = Vector3(0.7, 0.7, 1)
		slot0.costItem[slot4] = CommonItem.New(slot5)
		slot6 = slot0.costItem[slot4]

		slot6:RegistCallBack(function (slot0)
			ShowPopItem(POP_OPERATE_ITEM, {
				slot0.id,
				slot0.number
			})
		end)
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.limitController = ControllerUtil.GetController(slot0.m_limitController, "limit")
	slot0.btnCon_ = ControllerUtil.GetController(slot0.transform_, "btn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		EquipAction.ApplyUpgradeEquip(tonumber(uv0.equipId))
	end)
	slot0:AddBtnListener(slot0.limitBtn_, nil, function ()
		ShowTips("EQUIP_BREAK_LIMITED")
	end)
end

function slot0.RefreshEquip(slot0)
	slot0:RefreshBtn()
	slot0:RefreshEquipUpInfo()
	slot0:RefreshEquipUpCost()
	slot0:RefreshEquipUpLimit()
end

function slot0.RefreshBtn(slot0)
	if slot0.equip.race == 0 or table.keyof(RaceEffectCfg.all, slot0.equip.race) then
		slot1 = EquipCfg[slot0.equip.prefab_id]
		slot3 = slot1.max_level[slot0.equip.now_break_level + 2]

		if slot1.hero_slot_open_level[1] and slot4 <= slot3 then
			slot0.btnCon_:SetSelectedState("true")

			return
		end
	end

	slot0.btnCon_:SetSelectedState("false")
end

function slot0.RefreshEquipUpInfo(slot0)
	slot6 = "LEVEL"
	slot0.newLv_.text = GetTips(slot6) .. string.format("%d", EquipCfg[slot0.equip.prefab_id].max_level[slot0.equip.now_break_level + 2])

	for slot6 = 1, 2 do
		slot7 = slot1.fixed_attributes[slot2 + 1]
		slot8 = PublicAttrCfg[slot7[slot6][1]]
		slot0.attrIcon_[slot6].sprite = getSprite("Atlas/Common", slot8.icon)
		slot0.attrName_[slot6].text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(slot8.name))
		slot0.attrOld_[slot6].text = slot7[slot6][3]
		slot0.attrNew_[slot6].text = slot1.fixed_attributes[slot2 + 2][slot6][3]
	end
end

function slot0.RefreshEquipUpCost(slot0)
	if not slot0.equip:GetUpgradeCost() then
		return
	end

	slot0.moneyCost_ = slot1.money
	slot3 = tostring(slot0.moneyCost_)

	if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1.money then
		slot3 = "<color='#FF0000'>" .. slot3 .. "</color>"
	end

	slot0.costNum_.text = slot3

	for slot7 = 1, 3 do
		if slot1.item_list[slot7] then
			slot0.costItem[slot7]:Show(true)

			slot9 = slot1.item_list[slot7][2]
			slot11 = MaterialData:GetMaterial(slot1.item_list[slot7][1]) and slot10.num or 0

			slot0.costItem[slot7]:RefreshData({
				id = slot8,
				number = slot9
			})

			slot13 = tostring(slot11)

			if slot11 < slot9 then
				slot13 = "<color='#FF0000'>" .. slot13 .. "</color>"
			end

			slot0.costItem[slot7]:SetBottomText(slot13 .. "/" .. slot9)
		else
			slot0.costItem[slot7]:Show(false)
		end
	end
end

function slot0.RefreshEquipUpLimit(slot0)
	if PlayerData:GetPlayerInfo().userLevel < GameSetting.equip_break_user_level.value[slot0.equip.now_break_level + 1] then
		slot0.limitText_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), slot2)

		slot0.limitController:SetSelectedIndex(0)
	else
		slot0.limitText_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), slot2)

		slot0.limitController:SetSelectedIndex(1)
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.params_.equipId = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId)

	slot0:RefreshEquip()
end

function slot0.OnTop(slot0)
	slot0:RefreshEquip()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = {
				"Textures/ChapterPaint/chapter/equip_courses_01",
				"Textures/ChapterPaint/chapter/equip_courses_02",
				"Textures/ChapterPaint/chapter/equip_courses_03",
				"Textures/ChapterPaint/chapter/equip_courses_04",
				"Textures/ChapterPaint/chapter/equip_courses_05",
				"Textures/ChapterPaint/chapter/equip_courses_06",
				"Textures/ChapterPaint/chapter/equip_courses_07",
				"Textures/ChapterPaint/chapter/equip_courses_08"
			}
		}
	})
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.costItem then
		for slot4, slot5 in pairs(slot0.costItem) do
			slot5:Dispose()
		end

		slot0.costItem = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot2 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD)
		slot3 = tostring(slot2)

		if slot2 < slot0.moneyCost_ then
			slot3 = "<color='#FF0000'>" .. slot3 .. "</color>"
		end

		slot0.costNum_.text = slot3 .. "/" .. slot0.moneyCost_
	end
end

return slot0
