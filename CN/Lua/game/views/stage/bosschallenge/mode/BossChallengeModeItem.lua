slot0 = class("BossChallengeModeItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "chooseItem")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.chooseHandler_ = handler(slot0, slot0.ChooseMode)

	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)

	slot0.chooseHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if table.keyof(BattleBossChallengeData:GetOpenModeList(), BossChallengeAdvanceCfg.all[uv0.index_]) == nil then
			if BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[uv0.index_ - 1]].type == 1 then
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_UNLOCK_TIPS"), GetI18NText(slot2.name2), BossChallengeAdvanceCfg[slot1].open_condition))
			else
				ShowTips(string.format(GetTips("BOSS_CHALLENGE_ADVANCE_UNLOCK_TIPS"), GetI18NText(slot2.name2), BossChallengeAdvanceCfg[slot1].open_condition))
			end

			return
		end

		manager.notify:Invoke(CHALLENGE_CHOOSE_MODE, uv0.index_)
	end)
end

function slot0.ChooseMode(slot0, slot1)
	if slot0.index_ == slot1 then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot4 = BossChallengeAdvanceCfg[BossChallengeAdvanceCfg.all[slot1]]
	slot0.modeText_.text = slot4.name

	if slot4.type == 2 then
		slot0.difficultText_.text = ""
		slot0.romaImage_.sprite = getSprite("Atlas/Switch", string.format("bg_n%s", table.keyof(BossChallengeAdvanceCfg.get_id_list_by_type[2], slot3)))
	else
		slot0.difficultText_.text = slot4.name2
	end

	SetActive(slot0.romaGo_, slot4.type == 2)
	SetSpriteWithoutAtlasAsync(slot0.bgImage_, SpritePathCfg.ChapterPaint.path .. slot4.bg)

	if table.keyof(BattleBossChallengeData:GetOpenModeList(), slot3) then
		slot0.lockController_:SetSelectedState("false")
	else
		slot0.lockController_:SetSelectedState("true")
	end

	slot0:ChooseMode(slot2)
end

return slot0
