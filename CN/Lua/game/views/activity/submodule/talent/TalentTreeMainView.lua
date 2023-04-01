slot0 = class("DemonChallengeMainView", ReduxView)

function slot0.UIName(slot0)
	return nil
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitGo(slot0, slot1)
	if slot0.gameObject_ then
		Object.Destroy(slot0.gameObject_)
	end

	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot1), slot0:UIParent())
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.levelUpGo_ = slot0.levelUpTrs_.gameObject
	slot0.levelUpAni_ = slot0.levelUpTrs_:GetComponent("Animator")
end

slot1 = 5

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.upGo_ = slot0.upBtn_.gameObject
	slot0.subDesControllerS_ = {}

	for slot4 = 0, uv0 do
		if slot0[string.format("item%dTrs_", slot4)] then
			slot0.subDesControllerS_[slot4] = ControllerUtil.GetController(slot5, "item")
		end
	end

	slot0.raceToId_ = {}
end

function slot0.AddUIListener(slot0)
	for slot4 = 0, uv0 do
		if slot0[string.format("race%dBtn_", slot4)] then
			slot0:AddBtnListener(slot5, nil, function ()
				uv0:SelectItem(uv1)
			end)
		end
	end

	slot0:AddBtnListener(slot0.upBtn_, nil, function ()
		slot0 = uv0.raceToId_[uv0.currentRace_]
		slot3 = TalentTreeCfg[slot0].cost[TalentTreeData:GetTalentLevel(slot0) + 1]

		if CurrencyData:GetCurrencyNum(slot3[1]) < slot3[2] then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[slot3[1]].name)))

			return
		end

		TalentTreeAction.UpTalentLevel(slot0, slot1.cost[slot2 + 1])
	end)
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[slot0.activityId_]) do
		slot7 = TalentTreeCfg[slot6]
		slot0.raceToId_[slot7.race] = slot6

		if slot7.race == 0 then
			slot0.coreText_.text = getAffixName({
				slot7.affix_id,
				1
			})
			slot0.coreDesText_.text = getAffixDesc({
				slot7.affix_id,
				1
			})
		else
			slot0:RefreshItemMainLevel(slot6)
		end
	end
end

function slot0.RefreshItem(slot0, slot1)
	slot3 = TalentTreeData:GetTalentLevel(slot1)

	slot0:RefreshItemMainLevel(slot1)

	slot0.talentText_.text = getAffixName({
		TalentTreeCfg[slot1].affix_id,
		1
	})

	if slot0.descText_ then
		slot0.descText_.text = slot2.desc
	end

	for slot7 = 1, slot2.max_level do
		if slot0[string.format("subDes%dText_", slot7)] then
			slot8.text = getAffixDesc({
				slot2.affix_id,
				slot7
			})
		end

		if slot0.subDesControllerS_[slot7] then
			slot0.subDesControllerS_[slot7]:SetSelectedState(tostring(slot7 <= slot3))
		end
	end
end

function slot0.PlayLevelUpAni(slot0, slot1)
	slot0.levelUpTrs_.parent = slot0[string.format("item%dTrs_", TalentTreeData:GetTalentLevel(slot1))]
	slot0.levelUpTrs_.localPosition = Vector3.zero

	slot0.levelUpAni_:Play("TalentUILevelUp", 0, 0)
end

function slot0.RefreshItemMainLevel(slot0, slot1)
	slot3 = TalentTreeData:GetTalentLevel(slot1)

	if slot0[string.format("num%dText_", TalentTreeCfg[slot1].race)] then
		slot4.text = string.format("%d%%", slot3 / slot2.max_level * 100)
	end
end

function slot0.RefreshCost(slot0)
	slot1 = slot0.raceToId_[slot0.currentRace_]

	if TalentTreeData:GetTalentLevel(slot1) < TalentTreeCfg[slot1].max_level then
		SetActive(slot0.upGo_, true)

		slot4 = slot2.cost[slot3 + 1]
		slot0.costText_.text = slot4[2]

		if slot4[2] <= CurrencyData:GetCurrencyNum(slot4[1]) then
			slot0.costText_.color = CurrencyConst.ENOUGH_COLOR_LIGHT
		else
			slot0.costText_.color = CurrencyConst.LACK_COLOR
		end
	else
		SetActive(slot0.upGo_, false)
	end
end

function slot0.RefreshRedPoint(slot0)
	for slot4 = 1, uv0 do
		if slot0[string.format("race%dBtn_", slot4)] then
			manager.redPoint:SetRedPointIndependent(slot5.transform, TalentTreeTools.IsCanUp(slot0.raceToId_[slot4]))
		end
	end
end

function slot0.SelectItem(slot0, slot1)
	if slot0.currentRace_ == slot1 then
		return
	end

	if slot0.currentRace_ and slot0[string.format("select%dGo_", slot0.currentRace_)] then
		SetActive(slot2, false)
	end

	slot0.currentRace_ = slot1

	SetActive(slot0.introduceGo_, slot1 == 0)
	SetActive(slot0.talentProgressGo_, slot1 ~= 0)

	if slot0[string.format("select%dGo_", slot1)] then
		SetActive(slot2, true)
	end

	if slot1 ~= 0 then
		slot0:RefreshItem(slot0.raceToId_[slot1])
	else
		slot0.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
	end

	slot0:RefreshCost()
end

function slot0.OnUpTalentLevel(slot0, slot1, slot2)
	slot0:RefreshItem(slot2.id)
	slot0:PlayLevelUpAni(slot2.id)
	slot0:RefreshCost()
	slot0:RefreshRedPoint()
end

function slot0.OnEnter(slot0)
	if not slot0.activityId_ or slot0.params_.activityId ~= slot0.activityId_ then
		slot0.activityId_ = slot0.params_.activityId

		slot0:InitGo(TalentTreeTools.GetMainUIName(slot0.activityId_))
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_HELLA_TALENT_TREE_COIN, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_TALENT_DESCRIPE")
	slot0:RefreshUI()
	slot0:RefreshRedPoint()
	slot0:SelectItem(0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.raceToId_ = {}
	slot0.levelUpTrs_.localPosition = Vector3.New(0, 9999, 0)
end

return slot0
