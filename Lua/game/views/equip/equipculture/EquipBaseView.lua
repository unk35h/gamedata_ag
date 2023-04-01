slot0 = class("EquipBaseView", ReduxView)

function slot0.GetEquipInfoViewItem(slot0)
	return EquipPopInfoView
end

function slot0.Init(slot0, slot1)
	if slot0.equipInfoGo_ then
		slot0.equipInfoView_ = slot0:GetEquipInfoViewItem().New(slot0.equipInfoGo_)
	end

	if slot0.equipSkillGo_ then
		slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.equipSkillGo_)
	end

	if slot0.equipHeroSkillGo_ then
		slot0.equipHeroSkillView_ = EquipNewHeroSkillInfoView.New(slot0.equipHeroSkillGo_)
	end

	if slot0.maskGo_ and slot0.maskGo_:GetComponent(typeof(Button)) then
		slot0:AddBtnListener(slot2, nil, function ()
			uv0:HideMaskMessage()
		end)
	end

	if slot1 == nil then
		slot1 = 0
	end

	slot0.hideType = slot1
end

function slot0.HideMaskMessage(slot0)
	slot0:SetEquipObjectActive(slot0.maskGo_, false)
	slot0:SetEquipObjectActive(slot0.equipSkillGo_, false)

	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	if slot0.hideType == 1 then
		slot0:SetEquipObjectActive(slot0.equipInfoGo_, false)
	end
end

function slot0.HideSkillMask(slot0)
	if slot0.hideType == 0 then
		slot0:SetEquipObjectActive(slot0.maskGo_, false)
	end

	slot0:SetEquipObjectActive(slot0.equipSkillGo_, false)

	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end
end

function slot0.SetEquipObjectActive(slot0, slot1, slot2)
	if slot1 then
		SetActive(slot1, slot2)
	end
end

function slot0.SkillClick(slot0, slot1, slot2)
	slot0:SetEquipObjectActive(slot0.maskGo_, true)
	slot0:SetEquipObjectActive(slot0.equipSuitGo_, false)
	slot0:SetEquipObjectActive(slot0.equipSkillGo_, true)
	slot0:SetEquipObjectActive(slot0.equipHeroSkillGo_, true)

	if slot0.lastSuitSelect_ then
		slot0.lastSuitSelect_:ShowSelect(false)
	end

	if slot0.lastSkillSelect_ then
		slot0.lastSkillSelect_:ShowSelect(false)
	end

	if slot0.lastHeroSkillSelect_ then
		slot0.lastHeroSkillSelect_:ShowSelect(false)
	end

	slot0.lastSkillSelect_ = slot1

	slot1:ShowSelect(true)

	if slot0.equipSkillView_ then
		slot0.equipSkillView_:RefreshData(slot0, slot2)
	end
end

function slot0.SuitClick(slot0, slot1, slot2)
end

function slot0.HeroSkillClick(slot0, slot1, slot2)
end

function slot0.RefreshEquipInfo(slot0, slot1, slot2)
	slot0:HideSkillMask()

	if slot0.equipInfoView_ then
		slot1.isKeep = true

		slot0.equipInfoView_:RefreshData(slot0, slot1, slot2)

		slot1.isKeep = nil
	end
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
	if slot0.equipInfoView_ then
		slot0.equipInfoView_:Dispose()
	end

	if slot0.equipSkillView_ then
		slot0.equipSkillView_:Dispose()
	end

	if slot0.equipHeroSkillView_ then
		slot0.equipHeroSkillView_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
