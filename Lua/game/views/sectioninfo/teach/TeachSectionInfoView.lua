slot0 = class("TeachSectionInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/PathOfTheFlamingSwordInfoUI_teach"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rewardItems_ = {}
	slot0.rewardGos_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnUpdate(slot0)
	if slot0.stageID_ == slot0.params_.section then
		return
	end

	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonBattle_, nil, function ()
		uv0:OnClickBtn()
	end)
	slot0:AddBtnListener(slot0.buttonWeb_, nil, function ()
		slot1 = TeachStageExInfoCfg[uv0.stageID_]

		if not SDKTools.IsSDK() then
			Application.OpenURL(slot1.video_url)
		else
			LuaForUtil.OpenWebView(slot1.video_url, true, function ()
				manager.audio:PauseAll(true)
				print("--->> open webView")
			end, function ()
				print("====>>> close webView")
				manager.audio:PauseAll(false)
			end)
		end

		SDKTools.SendMessageToSDK("lecture_video", {
			channel_type = 2,
			videro_channel = uv0.stageID_
		})
	end)
end

function slot0.OnExit(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStageInfo()
	slot0:RefreshReward()

	slot0.scrollRectRewardList_.horizontalNormalizedPosition = 0

	slot0:RefreshVideoUI()
end

function slot0.RefreshData(slot0)
	slot1 = slot0.stageID_
	slot2 = nil

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot0.stageType_ then
		slot2 = BattleBaseTeachStageCfg[slot1]
	elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot0.stageType_ then
		slot2 = BattleHeroTeachStageCfg[slot1]
	end

	slot0.stageCfg_ = slot2
	slot0.isFirstClear_ = (BattleTeachData:GetStageData()[slot0.stageID_] or 0) <= 0

	BattleFieldData:SetCacheStage(getChapterAndSectionID(slot1), slot1)
end

function slot0.RefreshVideoUI(slot0)
	slot2 = TeachStageExInfoCfg[slot0.stageID_]

	if SDKTools.GetIsOverSea() then
		SetActive(slot0.goButtonWeb_, false)
	else
		slot3 = SetActive
		slot5 = slot0.goButtonWeb_
		slot6 = slot2 and slot2.video_url ~= "" and true or false

		slot3(slot5, slot6)
	end
end

function slot0.RefreshStageInfo(slot0)
	slot1 = slot0.stageCfg_
	slot0.textName_.text = slot1.name
	slot0.imageBg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, slot1.background_1))
	slot0.textDesc_.text = slot1.tips
end

function slot0.RefreshReward(slot0)
	slot0:RefreshRewardPanel(slot0.stageCfg_.drop_lib_id)
end

function slot0.RefreshRewardPanel(slot0, slot1)
	slot2 = getRewardFromDropCfg(slot1, slot0.isFirstClear_)

	if slot0.isFirstClear_ and #DropCfg[slot1].base_drop >= 1 then
		slot0.textRewardTitle_.text = GetTips("FIRST_DROP")
	else
		slot0.textRewardTitle_.text = GetTips("MAYBE_DROP")
	end

	for slot6, slot7 in pairs(slot2) do
		if slot0.rewardItems_[slot6] then
			slot0.rewardItems_[slot6]:SetData(slot7)
		else
			slot0.rewardGos_[slot6] = slot0.rewardGos_[slot6] or Object.Instantiate(slot0.goRewardItem_, slot0.transformItemParent_)
			slot0.rewardItems_[slot6] = RewardPoolItem.New(slot0.rewardGos_[slot6], slot7, true)
		end

		if not slot0.isFirstClear_ or #DropCfg[slot1].base_drop < 1 then
			slot0.rewardItems_[slot6]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			slot0.rewardItems_[slot6]:HideNum()
		else
			slot0.rewardItems_[slot6]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardGos_) do
		Object.Destroy(slot5)
	end

	slot0.rewardGos_ = nil

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnClickBtn(slot0)
	slot0:Go("/sectionSelectHeroTeach", {
		section = slot0.stageID_,
		sectionType = slot0.stageType_
	})
end

return slot0
