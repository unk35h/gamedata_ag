slot0 = class("TowerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Tower/TowerUI_NEW"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectIndex_ = -1
	slot0.rewardItems_ = {}
	slot0.rewardGos_ = {}
	slot0.affixItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.currentController = ControllerUtil.GetController(slot0.transform_, "current")
	slot0.showRightController = ControllerUtil.GetController(slot0.transform_, "showRight")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.sureBtn_, nil, function ()
		uv0:OnButtonSureClick()
	end)

	slot4 = slot0.m_maskBtn

	slot0:AddBtnListener(slot4, nil, function ()
		uv0:OnTowerContentShow(false)
		uv0.selectController:SetSelectedIndex(0)
	end)

	for slot4 = 1, 10 do
		if slot0["m_tower_" .. slot4] then
			slot0:AddBtnListener(slot5, nil, function ()
				uv0.selectIndex_ = uv1

				uv0.selectController:SetSelectedIndex(uv0.selectIndex_)
				uv0:RefreshUI()
			end)
		end
	end
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.chapterId
	slot0.chapterId = slot1
	slot0.towerList = TowerData:GetTowerList(slot1)
	slot0.curId = TowerData:GetCurId(slot1)

	slot0.currentController:SetSelectedIndex(table.indexof(slot0.towerList, slot0.curId) or 11)

	if not slot0.params_.showInfo or not slot2 then
		slot0.selectIndex_ = 0

		slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
		slot0:OnTowerContentShow(false)
	else
		slot0.selectIndex_ = slot2

		slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
		slot0:RefreshUI()
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("SPAWN_DESCRIPE")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:HideAffixInfo()
end

function slot0.BackToCurSelect(slot0)
	slot0.selectIndex_ = table.indexof(slot0.towerList, slot0.curId) or 1

	slot0.selectController:SetSelectedIndex(slot0.selectIndex_)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:OnTowerContentShow(true, slot0.selectIndex_)
	slot0:HideAffixInfo()

	slot2 = BattleTowerStageCfg[slot0.towerList[slot0.selectIndex_]] or {}
	slot0.textTitle_.text = slot2.name
	slot0.textDes_.text = slot2.tips
	slot0.sectionImage_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot2.background_1))

	if not slot0.curId or slot1 <= slot0.curId then
		slot0.textButton_.text = GetTips("READY_BATTLE")
		slot0.textButton_en.text = "READY  FOR COMBAT"
	else
		slot0.textButton_.text = GetTips("BACK_TO_CURRENT")
		slot0.textButton_en.text = "COME BACK"
	end

	slot0:RefreshAffixPanel(slot1)

	if not slot0.curId or slot1 < slot0.curId then
		slot0:RefreshRewardPanel(0)
	else
		slot0:RefreshRewardPanel(slot2.drop_lib_id)
	end

	slot0.rewardView_.horizontalNormalizedPosition = 0
end

function slot0.RefreshRewardPanel(slot0, slot1)
	slot2 = {}

	if slot1 ~= 0 then
		slot2 = getRewardFromDropCfg(slot1, true)
	end

	for slot6, slot7 in pairs(slot2) do
		if slot0.rewardItems_[slot6] then
			slot0.rewardItems_[slot6]:SetData(slot7)
		else
			slot0.rewardGos_[slot6] = slot0.rewardGos_[slot6] or Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_.transform)
			slot0.rewardItems_[slot6] = RewardPoolItem.New(slot0.rewardGos_[slot6], slot7, true)

			slot0.rewardItems_[slot6]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshAffixPanel(slot0, slot1)
	slot2 = BattleTowerStageCfg[slot1] or {}

	table.insertto(clone(getMosterAffix(slot2.affix_type)), getMosterAffix(slot2.affix_type_in_map))

	for slot8, slot9 in pairs(slot3) do
		if not slot0.affixItemList_[slot8] then
			slot0.affixItemList_[slot8] = {}
			slot10 = Object.Instantiate(slot0.affixItem_, slot0.affixParent_.transform)
			slot0.affixItemList_[slot8].gameObject = slot10
			slot0.affixItemList_[slot8].icon = slot0:FindCom(typeof(Image), "icon", slot10.transform)
			slot0.affixItemList_[slot8].text = slot0:FindCom(typeof(Text), "text", slot10.transform)
		end

		SetActive(slot0.affixItemList_[slot8].gameObject, true)

		slot0.affixItemList_[slot8].text.text = GetI18NText(getAffixName(slot9)) .. (({
			"Ⅰ",
			"Ⅱ",
			"Ⅲ",
			"Ⅳ",
			"Ⅴ",
			"Ⅵ",
			"Ⅶ",
			"Ⅷ",
			"Ⅸ"
		})[slot9[2]] or "")
		slot0.affixItemList_[slot8].icon.sprite = getAffixSprite(slot9)
		slot12 = slot0:FindCom(typeof(Button), nil, slot0.affixItemList_[slot8].gameObject.transform)

		slot12.onClick:RemoveAllListeners()
		slot0:AddBtnListener(slot12, nil, function ()
			uv0:ShowAffixInfo(uv1.transform, uv2)
		end)
	end

	for slot8 = #slot3 + 1, #slot0.affixItemList_ do
		SetActive(slot0.affixItemList_[slot8].gameObject, false)
	end
end

function slot0.OnButtonSureClick(slot0)
	slot1 = slot0.towerList[slot0.selectIndex_]

	if not slot0.curId or slot1 <= slot0.curId then
		if BattleTowerStageCfg[slot1].level <= PlayerData:GetPlayerInfo().userLevel then
			slot0:Go("/sectionSelectHero", {
				section = slot1,
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
			})
		else
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot3))
		end
	else
		slot0:BackToCurSelect()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	for slot4, slot5 in pairs(slot0.rewardGos_) do
		Object.Destroy(slot5)
	end

	slot0.rewardGos_ = {}
	slot0.affixItemList_ = {}

	slot0:RemoveTween()
	uv0.super.Dispose(slot0)
end

function slot0.ShowAffixInfo(slot0, slot1, slot2)
	slot0.affixinfoTrs_:SetParent(slot1)

	slot0.affixinfoTrs_.localPosition = Vector3(0, 160, 0)

	SetActive(slot0.affixinfoTrs_.gameObject, true)

	slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot0.affixcontentTrs_.transform.localPosition.y, 0)

	if slot0.endPoint_:TransformPoint(Vector3(0, 0, 0)).x <= slot0.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x then
		slot0.affixcontentTrs_.transform.localPosition = Vector3(slot0.affixinfoTrs_:InverseTransformPoint(slot4).x, slot3.y, 0)
	else
		slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot3.y, 0)
	end

	slot0.affixcontentText_.text = getAffixDesc(slot2)
	slot0.affixnameText_.text = getAffixName(slot2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixcontentTrs_)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		SetActive(uv0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	slot0.countdownTimer_:Start()
end

function slot0.HideAffixInfo(slot0)
	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	SetActive(slot0.affixinfoTrs_.gameObject, false)
end

function slot0.OnTowerContentShow(slot0, slot1, slot2)
	slot0.showRightController:SetSelectedIndex(slot1 and 1 or 0)

	if slot1 then
		slot0:RemoveTween()

		slot6 = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, -slot0["m_tower_" .. slot2].transform.localPosition.x - 350, 0.3)
		slot0.tween_ = slot6:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0:RemoveTween()

		slot3 = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, 0, 0.3)
		slot0.tween_ = slot3:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_middleContent.gameObject)

		slot0.tween_ = nil
	end
end

return slot0
