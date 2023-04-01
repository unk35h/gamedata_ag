slot0 = class("HeroSurpassView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSurpass/SurpassUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.initController = ControllerUtil.GetController(slot0.m_itemContent.transform, "init")
	slot0.stateController = ControllerUtil.GetController(slot0.m_stateController, "contain")
	slot0.SkillTypeController = ControllerUtil.GetController(slot0.m_skillContent.transform, "skillType")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_skillAttributeList, HeroSurpassAttributeItem)
	slot0.attributeUI = {}

	ComponentBinder.GetInstance():BindCfgUI(slot0.attributeUI, slot0.m_attribute)

	slot0.itemUI = {}
	slot4 = slot0.itemUI
	slot5 = slot0.m_itemContent

	ComponentBinder.GetInstance():BindCfgUI(slot4, slot5)

	slot0.items = {}

	for slot4, slot5 in ipairs(HeroStarCfg.all) do
		table.insert(slot0.items, HeroSurpassItem.New(slot0.itemUI["m_item" .. slot5], slot4, handler(slot0, slot0.OnItemClick)))
	end

	slot0.skillAttributeList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_pieceBtn, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			ItemCfg[uv0.heroId].fragment
		})
	end)
	slot0:AddBtnListener(slot0.m_coinBtn, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		uv0:OnItemClick(0)
	end)
	slot0:AddBtnListener(slot0.m_sureBtn, nil, function ()
		if uv0.heroInfo.piece < HeroStarCfg[uv0.heroInfo.star].star_up then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_HERO_PIECE")

			return
		end

		if not checkGold(slot0.gold_cost, true) then
			return
		end

		uv0.lastStarId_ = uv0.heroInfo.star

		HeroAction.HeroStarUp(uv0.heroInfo.id)
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.skillAttributeList[slot1])
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.RefreshInfo))

	slot1 = slot0.params_.heroId
	slot0.heroId = slot1
	slot0.heroInfo = HeroData:GetHeroData(slot1)
	slot0.curIndex = table.indexof(HeroStarCfg.all, slot0.heroInfo.star)

	slot0.initController:SetSelectedIndex(HeroStarCfg[HeroCfg[slot1].unlock_star].star - 1)
	slot0:RefreshPanel()

	slot0.timer_ = Timer.New(function ()
		if #uv0 < uv1 + 1 then
			uv2:OnItemClick(#uv0, false)
		else
			uv2:OnItemClick(uv1 + 1, false)
		end
	end, 0.033, 1)

	slot0.timer_:Start()

	slot7 = HeroCfg[slot0.heroId]
	slot0.m_nameText.text = slot7.name
	slot0.m_suffixText.text = slot7.suffix
	slot0.m_roleImg.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. SkinCfg[slot0.heroId].picture_id)

	slot0.m_roleImg:SetNativeSize()

	manager.ui.cameraExtension.uiFov = 50
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()

	slot0.selectIndex = 0

	SetActive(slot0.m_rightGo, false)

	manager.ui.cameraExtension.uiFov = 30
end

function slot0.RefreshPanel(slot0)
	for slot4, slot5 in ipairs(slot0.items) do
		slot5:Refresh(slot0.curIndex, slot0.heroId)
	end
end

function slot0.RefreshInfo(slot0)
	if slot0.selectIndex == 0 or HeroStarCfg.all[slot0.selectIndex] == nil then
		return
	end

	slot2 = HeroStarCfg[HeroStarCfg.all[slot0.selectIndex]]
	slot3 = HeroCfg[slot0.heroId]
	slot0.m_ratingImg.sprite = getSprite("Atlas/Common", "star_" .. slot2.star)

	if slot2.phase == 0 then
		SetActive(slot0.m_ratingNumImg.gameObject, false)
	else
		SetActive(slot0.m_ratingNumImg.gameObject, true)

		slot0.m_ratingNumImg.sprite = getSprite("Atlas/HeroSurpass", "Number" .. slot2.phase)
	end

	if slot2.phase == 0 then
		slot4 = slot2.star
		slot0.attributeUI.m_atkText.text = slot3.atk_ratio[slot4]
		slot0.attributeUI.m_armText.text = slot3.arm_ratio[slot4]
		slot0.attributeUI.m_staText.text = slot3.sta_ratio[slot4]
		slot0.attributeUI.m_lastAtkText.text = math.max(slot4 - 1, 0) > 0 and slot3.atk_ratio[slot5] or 0
		slot0.attributeUI.m_lastStaText.text = slot5 > 0 and slot3.sta_ratio[slot5] or 0
		slot0.attributeUI.m_lastArmText.text = slot5 > 0 and slot3.arm_ratio[slot5] or 0

		SetActive(slot0.m_attribute, true)
	else
		SetActive(slot0.m_attribute, false)
	end

	slot6 = {}

	for slot10, slot11 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot3.star_up_skill_template]) do
		if HeroStarUpTemplateCfg[slot11].stage == slot1 then
			slot6 = HeroStarSkillCfg[slot12.skill_id]

			break
		end
	end

	if HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == slot6.type then
		slot0.SkillTypeController:SetSelectedIndex(0)

		slot0.titleText_.text = GetTips("BASE_PROPERTY_UP")
		slot0.skillAttributeList = slot6.params

		slot0.scrollHelper:StartScroll(#slot0.skillAttributeList)
	elseif HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == slot6.type then
		slot0.SkillTypeController:SetSelectedIndex(1)

		slot0.titleText_.text = GetTips("SKILL_LEVEL_UP")

		if #slot6.params == 1 then
			slot7 = HeroCfg[slot0.heroId]
			slot8 = slot6.params[1]
			slot0.m_skillDesText.text = string.format(GetI18NText(slot6.desc), GetI18NText(slot7.skill_subhead[slot8[1]]), GetI18NText(HeroSkillCfg[slot7.skills[slot8[1]]].name), slot8[2])
		else
			slot0.m_skillDesText.text = slot6.desc
		end
	else
		slot0.SkillTypeController:SetSelectedIndex(2)

		slot0.titleText_.text = GetTips("BASE_PROPERTY_UP")
		slot0.m_skillDesText.text = slot6 and slot6.desc or ""
	end

	if slot0.selectIndex - 1 > 0 and slot0.curIndex <= slot7 then
		slot10 = ItemCfg[slot0.heroId].fragment
		slot0.m_pieceName.text = ItemCfg[slot10].name
		slot0.m_pieceIcon.sprite = ItemTools.getItemLittleSprite(slot10)

		if ItemTools.getItemNum(slot10) < HeroStarCfg[HeroStarCfg.all[slot7]].star_up then
			slot0.m_pieceNum.text = string.format("<color=#A8000E>%d</color>/%d", slot11, slot9.star_up)
			slot0.m_pieceBg.sprite = getSprite("Atlas/HeroSurpass", "bg_b")
		else
			slot0.m_pieceNum.text = string.format("%d/%d", slot11, slot9.star_up)
			slot0.m_pieceBg.sprite = getSprite("Atlas/HeroSurpass", "bg_a")
		end

		slot0.m_goldName.text = ItemCfg[CurrencyConst.CURRENCY_TYPE_GOLD].name
		slot0.m_goldIcon.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_GOLD)

		if not checkGold(slot9.gold_cost, false) then
			slot0.m_goldNum.text = string.format("<color=#A8000E>%d</color>", slot9.gold_cost)
			slot0.m_goldBg.sprite = getSprite("Atlas/HeroSurpass", "bg_b")
		else
			slot0.m_goldNum.text = string.format("%d", slot9.gold_cost)
			slot0.m_goldBg.sprite = getSprite("Atlas/HeroSurpass", "bg_a")
		end

		SetActive(slot0.m_conditionsGo, true)
	else
		SetActive(slot0.m_conditionsGo, false)
	end

	if slot7 == slot0.curIndex then
		slot0.stateController:SetSelectedIndex(0)
	elseif slot7 < slot0.curIndex then
		slot0.stateController:SetSelectedIndex(1)
	else
		slot0.stateController:SetSelectedIndex(2)
	end
end

function slot0.OnItemClick(slot0, slot1, slot2)
	if slot1 == 0 and slot0.selectIndex == slot1 then
		return
	end

	slot0.selectIndex = slot1

	if slot1 ~= 0 then
		SetActive(slot0.m_rightGo, true)
		slot0:RefreshInfo()
	else
		SetActive(slot0.m_rightGo, false)
	end

	slot0:SetSelect(slot1, slot2)
end

function slot0.SetSelect(slot0, slot1, slot2)
	for slot6 = 1, #slot0.items do
		slot0.items[slot6]:SetChoice(slot1)
	end

	if slot0.items[slot1] then
		slot7 = -slot0.m_scrollContent.transform:InverseTransformPoint(slot3.transform_.parent:TransformPoint(Vector3(0, 0, 0))).x
		slot0.m_scrollCom.enabled = false

		if slot2 then
			slot0:RemoveTween()

			slot8 = LeanTween.value(slot0.m_scrollContent, slot0.m_scrollContent.transform.localPosition.x, slot7, 0.2)
			slot0.tween_ = slot8:setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.m_scrollContent.transform.localPosition = Vector3(slot0, 0, 0)
			end))
		else
			slot0.m_scrollContent.transform.localPosition = Vector3(slot7, 0, 0)

			TimeTools.StartAfterSeconds(0.1, function ()
				uv0.m_scrollContent.transform.localPosition = Vector3(uv1, 0, 0)
			end, {})
		end

		return
	end

	slot0.m_scrollCom.enabled = true
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.OnHeroStarUp(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot0.heroInfo = HeroData:GetHeroData(slot0.heroId)

		if HeroStarCfg[slot0.heroInfo.star].phase == 0 then
			JumpTools.OpenPageByJump("heroSurpassPhaseUp", {
				star = slot3,
				heroId = slot0.heroInfo.id
			})
		else
			JumpTools.OpenPageByJump("heroSurpassStarUp", {
				star = slot3,
				heroId = slot0.heroInfo.id
			})
		end

		slot5 = HeroStarCfg.all
		slot6 = table.indexof(slot5, slot3)
		slot0.curIndex = slot6

		slot0:RefreshPanel()

		if #slot5 < slot6 + 1 then
			slot0:OnItemClick(#slot5, true)
		else
			slot0:OnItemClick(slot6 + 1, true)
		end
	else
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()

	for slot4, slot5 in ipairs(slot0.items) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
