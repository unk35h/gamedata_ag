slot0 = class("EquipRaceView", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/Equip/Culture/EquipRaceUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.toggles_ = {
		slot0.raceRebuildToggle_,
		slot0.heroRebuildToggle_
	}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0.materialList_ = {}
	slot0.itemList_ = {}

	for slot4, slot5 in ipairs(slot0.toggles_) do
		if EquipData:GetRaceMaterial(slot4) then
			slot7 = CommonItem.New(slot0[string.format("commonItem%s_", tostring(slot4))])

			slot7:RefreshData(slot6)
			slot7:RegistCallBack(function (slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end)

			slot0.itemList_[#slot0.itemList_ + 1] = slot7
		end

		slot0.materialList_[#slot0.materialList_ + 1] = slot6
	end

	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)
	slot0.raceController = ControllerUtil.GetController(slot0.m_raceController, "race")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnRace_, nil, function ()
		uv0:OnRaceClick()
	end)
	slot0:AddBtnListener(slot0.raceRebuildBtn_, nil, function ()
		if uv0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		EquipData:SetRaceIndex(1)

		uv0.toggles_[1].isOn = true
	end)

	slot4 = slot0.heroRebuildBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		if uv0.heroID_ ~= 0 then
			ShowTips("EQUIP_HERO_HAD_REBUILT")

			return
		end

		if uv0.race_ == 0 then
			ShowTips("EQUIP_RACE_REBUILD_FIRST")

			return
		end

		EquipData:SetRaceIndex(2)

		uv0.toggles_[2].isOn = true
	end)

	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0.selectType_ = uv1

				uv0:RefreshMoney()
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.equipId = slot0.params_.equipId

	slot0:RefreshUI()
	slot0:RefreshSelectType()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
end

function slot0.OnEquipChange(slot0, slot1)
	slot0.equipId = slot1
	slot0.params_.equipId = slot1

	slot0:RefreshUI()
	slot0:RefreshSelectType()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
end

function slot0.OnExit(slot0)
	if slot0.selectType_ ~= 0 then
		slot0.toggles_[slot0.selectType_].isOn = false
	end

	slot0:RemoveAllEventListener()
end

function slot0.RefreshSelectType(slot0)
	if slot0.heroID_ ~= 0 then
		if slot0.selectType_ and slot0.selectType_ ~= 0 then
			slot0.toggles_[slot0.selectType_].isOn = false
		end

		slot0.selectType_ = 1
	elseif slot0.race_ ~= 0 then
		slot1 = EquipData:GetRaceIndex()
		slot0.toggles_[slot1].isOn = true
		slot0.selectType_ = slot1
	else
		slot0.toggles_[1].isOn = true
		slot0.selectType_ = 1

		EquipData:SetRaceIndex(1)
	end
end

function slot0.RefreshMoney(slot0)
	if slot0.selectType_ ~= nil and slot0.selectType_ ~= 0 then
		slot1 = slot0.materialList_[slot0.selectType_].money
		slot3 = tostring(slot1)

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot1 then
			slot3 = "<color='#FF0000'>" .. slot3 .. "</color>"
		end

		slot0.costNum_.text = slot3
	end
end

function slot0.RefreshMaterial(slot0)
	for slot4, slot5 in ipairs(slot0.materialList_) do
		slot7 = MaterialData:GetMaterial(slot5.id) and slot6.num or 0
		slot8 = tostring(slot7)

		if slot7 < slot5.number then
			slot8 = "<color='#FF0000'>" .. slot8 .. "</color>"
		end

		slot0.itemList_[slot4]:SetBottomText(slot8 .. "/" .. slot5.number)
	end
end

function slot0.RefreshUI(slot0)
	if not EquipData:GetEquipData(slot0.equipId) then
		return
	end

	slot2 = RaceEffectCfg.all

	if slot1.race == 0 then
		slot0.race_ = 0
		slot0.heroID_ = 0

		SetActive(slot0.costPanel_, true)
	elseif table.keyof(slot2, slot1.race) ~= nil then
		slot0.race_ = slot1.race
		slot0.heroID_ = 0

		SetActive(slot0.costPanel_, true)
	else
		slot0.race_ = 0
		slot0.heroID_ = slot1.race

		SetActive(slot0.costPanel_, false)
	end

	slot3 = nil

	if slot0.heroID_ ~= 0 then
		if HeroCfg[slot0.heroID_] then
			slot0.textRace_.text = string.format(GetTips("EQUIP_HERO_ATTRIBUTE_UP"), string.format("%s·%s", GetI18NText(slot3.name), GetI18NText(slot3.suffix)))
			slot0.raceImage_.sprite = HeroTools.GetSmallHeadSprite(slot0.heroID_)

			SetActive(slot0.raceImage_.gameObject, true)
		end
	elseif slot0.race_ ~= 0 then
		if RaceEffectCfg[slot0.race_] then
			slot0.textRace_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(slot3.name))
			slot0.raceImage_.sprite = getSprite("Atlas/CampItem", slot3.icon)

			SetActive(slot0.raceImage_.gameObject, true)
			slot0.raceController:SetSelectedIndex(math.min(slot0.race_, 5))
		end
	else
		slot0.textRace_.text = GetTips("EQUIP_NO_RACE")

		SetActive(slot0.raceImage_.gameObject, false)
		slot0.raceController:SetSelectedIndex(0)
	end

	slot0.btnRace_.interactable = slot0.heroID_ == 0
end

function slot0.OnRaceClick(slot0)
	slot1 = slot0.equipId

	if slot0.selectType_ == 1 then
		EquipAction.QueryEquipRace(slot1, slot0.selectType_)
	else
		slot0:Go("/equipHeroRebuild", {
			equipId = slot0.equipId
		})
	end
end

function slot0.OnEquipRaceConfirm(slot0)
	slot0:RefreshUI()
	slot0:RefreshMoney()
	slot0:RefreshMaterial()
end

function slot0.OnTop(slot0)
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

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		for slot4, slot5 in ipairs(slot0.itemList_) do
			slot5:Dispose()
		end

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0:RefreshMoney()
	end
end

return slot0
