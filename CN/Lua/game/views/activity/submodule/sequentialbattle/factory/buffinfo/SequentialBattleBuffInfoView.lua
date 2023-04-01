slot0 = class("SequentialBattleBuffInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/continuousBattle/MardukBuffDetailsPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectBuffHandler_ = handler(slot0, slot0.RefreshSelectBuff)
	slot0.buffUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, SequentialBattleBuffInfoItem)
	slot0.conditionList_ = {}
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.stageID_ = slot0.params_.stageID
	slot0.buffList_ = clone(SequentialBattleBuffCfg.get_id_list_by_activity_id[SequentialBattleChapterCfg[slot0.activityID_].main_id])

	if slot0.stageID_ ~= nil then
		slot5 = SequentialBattleData
		slot7 = slot5
		slot3 = clone(slot5.GetChapterData(slot7, slot0.activityID_).team[table.keyof(SequentialBattleChapterCfg[slot0.activityID_].stage_id, slot0.stageID_)].enabledBuff)

		for slot7 = #slot0.buffList_, 1, -1 do
			if table.keyof(slot3, slot0.buffList_[slot7]) then
				table.remove(slot0.buffList_, slot7)
			end
		end

		table.insertto(slot3, slot0.buffList_)

		slot0.buffList_ = slot3
	end

	slot0.selectID_ = slot0.buffList_[1]

	slot0.buffUIList_:StartScroll(#slot0.buffList_)
	manager.notify:RegistListener(SEQUENTIAL_BATTLE_BUFF, slot0.selectBuffHandler_)
	slot0:RefreshSelectBuff(slot0.selectID_)
	slot0:RefreshTitle()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(SEQUENTIAL_BATTLE_BUFF, slot0.selectBuffHandler_)

	slot0.params_.stageID = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectBuffHandler_ = nil

	for slot4, slot5 in ipairs(slot0.conditionList_) do
		slot5:Dispose()
	end

	slot0.conditionList_ = nil

	slot0.buffUIList_:Dispose()

	slot0.buffUIList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot3 = slot0.buffList_[slot1]
	slot4 = false

	if slot0.stageID_ ~= nil and table.keyof(clone(SequentialBattleData:GetChapterData(slot0.activityID_).team[table.keyof(SequentialBattleChapterCfg[slot0.activityID_].stage_id, slot0.stageID_)].enabledBuff), slot3) then
		slot4 = true
	end

	slot2:SetData(slot3, slot4)
	slot2:RefreshSelect(slot0.selectID_)
end

function slot0.RefreshTitle(slot0)
	if slot0.stageID_ then
		slot0.teamText_.text = GetTips(string.format("TEAM_%s", table.keyof(SequentialBattleChapterCfg[slot0.activityID_].stage_id, slot0.stageID_)))
	else
		slot0.teamText_.text = GetTips("BUFF_PREVIEW")
	end
end

function slot0.RefreshSelectBuff(slot0, slot1)
	slot0.selectID_ = slot1
	slot4 = slot0.buffUIList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:RefreshSelect(slot1)
	end

	slot0:RefreshRightPanel()
	slot0:RefreshCondition()
end

function slot0.RefreshRightPanel(slot0)
	slot1 = SequentialBattleBuffCfg[slot0.selectID_]
	slot2 = slot1.affix_id
	slot0.selectIcon_.sprite = getSpriteWithoutAtlas("Textures/BuffIcon/maedukAffix/" .. PublicBuffCfg[AffixTypeCfg[slot2].affix_buff_id].icon)
	slot0.nameText_.text = getAffixName({
		slot2
	})
	slot0.descText_.text = slot1.desc
end

function slot0.RefreshCondition(slot0)
	for slot5 = #slot0.conditionList_, #SequentialBattleBuffCfg[slot0.selectID_].type + 1, -1 do
		slot0.conditionList_[slot5]:Show(false)
	end

	for slot5 = 1, #slot1.type do
		slot0.conditionList_[slot5] = slot0.conditionList_[slot5] or SequentialBattleBuffInfoCondition.New(slot0.conditionItem_, slot0.conditionParent_)

		slot0.conditionList_[slot5]:SetData(slot0.activityID_, slot0.stageID_, slot0.selectID_, slot5)
	end
end

return slot0
