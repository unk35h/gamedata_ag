slot0 = class("AffixSelectDetailView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillDetailsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bossIndexController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "bossIndex")
	slot0.items_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		JumpTools.OpenPageByJump("affixSelectBossInfo", {
			bossID = uv0.cfg_.boss_id,
			index = uv0.params_.index
		})
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		gameContext:Go("/sectionSelectHero", {
			section = uv0.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = uv0.params_.activityId
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.affixDic_ = {}
	slot0.cfg_ = ActivityAffixSelectCfg[slot0.params_.activityId]
	slot0.affixIdList_ = slot0.cfg_.pool
	slot0.data_ = ActivityAffixSelectData:GetSubActivityData(slot0.params_.activityId)
	slot0.selectedAffixList_ = slot0.data_.affixList

	slot0:UpdateAffixDic()
	slot0:UpdateView()
	slot0:UpdateGainScore()

	if getData("affixSelect", "scrollPos" .. slot0.params_.activityId) then
		slot0.itemScrollRect_.verticalNormalizedPosition = slot1
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	ActivityAffixSelectAction.SetAffixList(slot0.params_.activityId, slot0.selectedAffixList_)
	saveData("affixSelect", "scrollPos" .. slot0.params_.activityId, slot0.itemScrollRect_.verticalNormalizedPosition)
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	slot4 = tostring

	slot0.bossIndexController_:SetSelectedState(slot4(slot0.params_.index))

	slot0.highestScoreLabel_.text = slot0.data_.point

	for slot4, slot5 in ipairs(slot0.affixIdList_) do
		if not slot0.items_[slot4] then
			slot0.items_[slot4] = AffixSelectAffixItemView.New(Object.Instantiate(slot0.itemPrefab_, slot0.itemContainer_), handler(slot0, slot0.OnItemSelect))
		end

		slot7 = false

		if table.indexof(slot0.selectedAffixList_, slot5) then
			slot7 = true
		end

		slot0.items_[slot4]:SetData(slot4, slot5, slot7)
	end

	while #slot0.items_ > #slot0.affixIdList_ do
		slot0.items_[#slot0.items_]:Dispose()

		slot0.items_[#slot0.items_] = nil
	end

	slot0.enemyAffixLabel_.text = getAffixDesc(slot0.cfg_.boss_affix)
	slot0.enemyAffixIcon_.sprite = getAffixSprite(slot0.cfg_.boss_affix)

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.itemContainer_)
end

function slot0.OnItemSelect(slot0, slot1, slot2)
	slot3 = table.indexof(slot0.selectedAffixList_, slot1)

	if slot2 then
		slot6 = nil

		if slot0.affixDic_[ActivityAffixPoolCfg[slot1].affix[1]] ~= nil then
			slot6 = slot0.affixDic_[slot5]
		end

		slot0.affixDic_[slot5] = slot1

		if not slot3 then
			table.insert(slot0.selectedAffixList_, slot1)
		end

		if slot6 ~= nil and table.indexof(slot0.selectedAffixList_, slot6) then
			table.remove(slot0.selectedAffixList_, slot7)
		end
	else
		slot0.affixDic_[ActivityAffixPoolCfg[slot1].affix[1]] = nil

		if slot3 then
			table.remove(slot0.selectedAffixList_, slot3)
		end
	end

	slot0:UpdateSelect()
	slot0:UpdateGainScore()
end

function slot0.UpdateAffixDic(slot0)
	for slot4, slot5 in ipairs(slot0.selectedAffixList_) do
		slot0.affixDic_[ActivityAffixPoolCfg[slot5].affix[1]] = slot5
	end
end

function slot0.UpdateSelect(slot0)
	for slot4, slot5 in ipairs(slot0.items_) do
		slot8 = false

		if table.indexof(slot0.selectedAffixList_, slot0.affixIdList_[slot4]) then
			slot8 = true
		end

		slot5:SetSelect(slot8)
	end
end

function slot0.UpdateGainScore(slot0)
	slot1 = slot0.cfg_.base_point

	for slot5, slot6 in ipairs(slot0.selectedAffixList_) do
		slot1 = slot1 + ActivityAffixPoolCfg[slot6].point
	end

	slot0.scoreLabel_.text = slot1
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
