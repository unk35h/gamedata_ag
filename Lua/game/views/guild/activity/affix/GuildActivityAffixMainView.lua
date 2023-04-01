slot0 = class("GuildActivityAffixMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivitytalentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.selectRaceItemHandler_ = handler(slot0, slot0.OnSelectRaceItem)
	slot0.selectAffixItemHandler_ = handler(slot0, slot0.OnSelectAffixItem)
	slot0.raceItemList_ = {}
	slot0.affixItemList_ = {}
	slot0.affixInfoItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.racePanelTrans_, "select")
	slot0.upgeadeStateController_ = ControllerUtil.GetController(slot0.transform_, "upgradeState")

	for slot5 = 1, slot0.racePanelTrans_.childCount do
		slot0.raceItemList_[slot5] = GuildActivityAffixRaceItem.New(slot0.racePanelTrans_:GetChild(slot5 - 1))

		slot0.raceItemList_[slot5]:SetSelectCallBack(slot0.selectRaceItemHandler_)
	end

	for slot6 = 1, slot0.affixPanelTrans_.childCount do
		slot0.affixItemList_[slot6] = GuildActivityAffixItem.New(slot0.affixPanelTrans_:GetChild(slot6 - 1))

		slot0.affixItemList_[slot6]:SetSelectCallBack(slot0.selectAffixItemHandler_)
	end

	for slot7 = 1, slot0.affixInfoPanelTrans_.childCount do
		slot0.affixInfoItemList_[slot7] = GuildActivityAffixInfoItem.New(slot0.affixInfoPanelTrans_:GetChild(slot7 - 1))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
		if uv0.isMaxLevel_ == true then
			return
		end

		if uv0.costEnough_ == false then
			ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")

			return
		end

		GuildActivityAction.UpgradeAffix(uv0.curAffixID_, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = MaterialData:GetMaterialList()[uv0.currencyID_]
				slot2.num = slot2.num - uv0.upgradeCost_

				manager.notify:Invoke(MATERIAL_MODIFY, uv0.currencyID_)

				slot6 = uv0.activityID_
				slot7 = uv0.curAffixID_

				GuildActivityData:UpgradeAffix(slot6, slot7)
				uv0:RefreshAffixItem()

				for slot6, slot7 in ipairs(uv0.affixInfoItemList_) do
					if uv0.curAffixLevel_ == slot6 then
						slot7:OnUpgrade()

						break
					end
				end
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0:InitBar()
	slot0:AddEventListeners()

	slot0.activityID_ = slot0.params_.activityID
	slot0.raceIDList_ = RaceEffectCfg.all

	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.InitBar(slot0)
	slot0.currencyID_ = TalentTreeCfg[TalentTreeCfg.get_id_list_by_activity_id[slot0.params_.activityID][1]].cost[1][1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot0.currencyID_
	})
	manager.windowBar:SetBarCanAdd(slot0.currencyID_, true)
	manager.windowBar:SetGameHelpKey("CLUB_ACTIVITY_AFFIX_DESC")
end

function slot0.OnTop(slot0)
	slot1, slot2 = GuildActivityData:CheckRateUpgrade(slot0.activityID_)

	if slot1 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = slot2
		})
		GuildActivityData:RefreshRateRedPoint(slot0.params_.activityID)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	slot0:UnBindRedPoint()

	for slot4, slot5 in ipairs(slot0.affixInfoItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0.selectRaceItemHandler_ = nil
	slot0.selectAffixItemHandler_ = nil

	for slot4, slot5 in ipairs(slot0.raceItemList_) do
		slot5:Dispose()
	end

	slot0.raceItemList_ = nil

	for slot4, slot5 in ipairs(slot0.affixItemList_) do
		slot5:Dispose()
	end

	slot0.affixItemList_ = nil

	for slot4, slot5 in ipairs(slot0.affixInfoItemList_) do
		slot5:Dispose()
	end

	slot0.affixInfoItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshRaceItem()
end

function slot0.RefreshRaceItem(slot0)
	for slot4, slot5 in ipairs(slot0.raceIDList_) do
		if slot0.raceItemList_[slot4] then
			slot0.raceItemList_[slot4]:SetData(slot5)
			slot0.raceItemList_[slot4]:SetActive(true)
		end
	end

	for slot4 = #slot0.raceItemList_, #slot0.raceIDList_ + 1, -1 do
		slot0.raceItemList_[slot4]:SetActive(false)
	end

	slot0.curRaceID_ = GuildActivityData:GetSelectRaceID(slot0.activityID_) or slot0.raceIDList_[1]

	slot0:OnSelectRaceItem(slot0.curRaceID_)
end

function slot0.OnSelectRaceItem(slot0, slot1)
	GuildActivityData:SetSelectRaceID(slot0.activityID_, slot1)

	slot0.curRaceID_ = slot1

	slot0.selectController_:SetSelectedState(tostring(slot0.curRaceID_))
	slot0:RefreshAffixItem()
end

function slot0.RefreshAffixItem(slot0)
	slot0.affixIDList_ = TalentTreeCfg.get_id_list_by_activity_id_and_race[slot0.activityID_][slot0.curRaceID_]
	slot0.unlockAffixIDList_ = GuildActivityData:GetUnLockAffixList()
	slot1, slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot0.affixIDList_) do
		if slot0.affixItemList_[slot7] then
			slot0.affixItemList_[slot7]:SetData(slot8, slot0.unlockAffixIDList_[slot8] ~= nil, slot3 and slot3.level or 0)
			slot0.affixItemList_[slot7]:SetActive(true)
		end
	end

	for slot7 = #slot0.affixItemList_, #slot0.affixIDList_ + 1, -1 do
		slot0.affixItemList_[slot7]:SetActive(false)
	end

	slot4 = GuildActivityData:GetSelectAffixID(slot0.activityID_, slot0.curRaceID_)
	slot0.curAffixID_ = GuildActivityData:GetSelectAffixID(slot0.activityID_, slot0.curRaceID_) or slot0.affixIDList_[1]
	slot0.curAffixLevel_ = slot0.unlockAffixIDList_[slot0.curAffixID_] and slot3.level or 0

	slot0:OnSelectAffixItem(slot0.curAffixID_, slot0.curAffixLevel_)
end

function slot0.OnSelectAffixItem(slot0, slot1, slot2)
	slot6 = slot0.activityID_
	slot7 = slot0.curRaceID_

	GuildActivityData:SetSelectAffixID(slot6, slot7, slot1)

	slot0.curAffixID_ = slot1
	slot0.curAffixLevel_ = slot2

	for slot6, slot7 in ipairs(slot0.affixItemList_) do
		slot7:SetSelect(slot1)
	end

	slot0:RefershAffixInfo()
	slot0:RefreshUpgradeBtn()
end

function slot0.RefershAffixInfo(slot0)
	slot1 = TalentTreeCfg[slot0.curAffixID_].affix_id

	for slot5, slot6 in ipairs(slot0.affixInfoItemList_) do
		slot6:SetData(slot1, slot5, slot0.curAffixLevel_)
	end

	slot0.titleText_.text = TalentTreeCfg[slot0.curAffixID_].name
	slot0.descText_.text = TalentTreeCfg[slot0.curAffixID_].desc
end

function slot0.RefreshUpgradeBtn(slot0)
	if TalentTreeCfg[slot0.curAffixID_].cost[slot0.curAffixLevel_ + 1] ~= nil then
		slot0.isMaxLevel_ = false

		SetActive(slot0.consumePanelGo_, true)

		slot0.currencyID_ = slot1[1]
		slot0.upgradeCost_ = slot1[2]
		slot0.costEnough_ = slot0.upgradeCost_ ~= nil and slot0.upgradeCost_ <= (ItemTools.getItemNum(slot0.currencyID_) or 0)
		slot0.consumeIcon_.sprite = ItemTools.getItemSprite(slot0.currencyID_)

		if slot0.costEnough_ == true then
			slot0.consumeNumText_.text = slot0.upgradeCost_
		else
			slot0.consumeNumText_.text = "<color='#FF0000'>" .. slot0.upgradeCost_ .. "</color>"
		end
	else
		slot0.isMaxLevel_ = true

		SetActive(slot0.consumePanelGo_, false)
	end

	if slot0.costEnough_ == true and slot0.isMaxLevel_ == false then
		slot0.upgeadeStateController_:SetSelectedState("true")
	else
		slot0.upgeadeStateController_:SetSelectedState("false")
	end
end

function slot0.BindRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.raceItemList_) do
		slot5:BindRedPoint(slot0.activityID_)
	end
end

function slot0.UnBindRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.raceItemList_) do
		slot5:UnBindRedPoint(slot0.activityID_)
	end
end

return slot0
