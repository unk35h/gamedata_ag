slot0 = class("AbyssLevelView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isBossController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isBoss")
	slot0.difficultyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "difficulty")
	slot0.resetGrayedController_ = ControllerUtil.GetController(slot0.resetBtn_.transform, "grayed")
	slot0.completeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "complete")
	slot0.lockList_ = LuaList.New(handler(slot0, slot0.IndexLockItem), slot0.lockListGo_, AbyssHeroItemView)
	slot0.abandonList_ = LuaList.New(handler(slot0, slot0.IndexAbandonItem), slot0.abandonListGo_, AbyssHeroItemView)
	slot0.monsterList_ = LuaList.New(handler(slot0, slot0.IndexMonsterItem), slot0.monsterListGo_, AbyssMonsterItemView)
end

function slot0.IndexLockItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.lockedHeroList_[slot1])
end

function slot0.IndexAbandonItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.abandonHeroList_[slot1])
end

function slot0.IndexMonsterItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.monsterIdList_[slot1])
	slot2:RegisterClickListener(handler(slot0, slot0.OnMonsterClick))
end

function slot0.OnMonsterClick(slot0)
	JumpTools.OpenPageByJump("abyssBossDetail", {
		bossIdList = slot0.monsterIdList_
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bossHeadBtn_, nil, function ()
		JumpTools.OpenPageByJump("abyssBossDetail", {
			bossIdList = uv0.monsterIdList_
		})
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		gameContext:Go("/abyssSelectHero", {
			section = uv0.stageCfg_[2],
			sectionType = BattleConst.STAGE_TYPE_NEW.ABYSS,
			layerId = uv0.layerId_,
			stageIndex = uv0.stageIndex_
		})
	end)
	slot0:AddBtnListener(slot0.resetBtn_, nil, function ()
		if AbyssData:GetStageResetTime() <= 0 then
			ShowTips("ABYSS_STAGE_RESET_CLICK_TIP")

			return
		end

		slot2 = AbyssData:GetLayerStatus(uv0.layerId_ + 1)

		if uv0.layerId_ < AbyssData:GetCurrentLayer() and slot2 >= 2 then
			slot3 = slot0

			if AbyssData:GetLayerStatus(slot0) == 1 then
				slot3 = slot0 - 1
			end

			ShowTips(string.format(GetTips("ABYSS_STAGE_CHALLENGING_RESET_TIP"), slot3))

			return
		end

		slot9 = AbyssData
		slot10 = AbyssData

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = string.format(GetTips("ABYSS_STAGE_RESET_TIP"), slot9:GetStageResetTime(), slot10:GetStageResetLimit()),
			OkCallback = function ()
				AbyssAction.ResetStage(uv0.layerId_, uv0.stageIndex_, uv0.battleAbyssCfg_.id)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_LAYER_RESET_TIME_UPDATE, function (slot0)
		if slot0 == uv0.layerId_ then
			uv0:UpdateView()
		end
	end)
	slot0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function (slot0, slot1)
		if slot0 == uv0.layerId_ and slot1 == uv0.stageCfg_[2] then
			ShowTips("ABYSS_RESET_STAGE_FINISH_TIP")
			uv0:UpdateView()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.layerId_ = slot1
	slot0.stageIndex_ = slot2
	slot0.abyssCfg_ = AbyssCfg[slot1]
	slot0.stageCfg_ = slot0.abyssCfg_.stage_list[slot0.stageIndex_]
	slot0.stageId_ = slot0.stageCfg_[2]
	slot0.battleAbyssCfg_ = BattleAbyssCfg[slot0.stageCfg_[2]]
	slot0.monsterIdList_ = slot0.abyssCfg_.stage_target[slot0.stageIndex_]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.stageCfg_[1] == 3 then
		slot0.abandonHeroList_ = AbyssData:GetStageAbandonList(slot0.layerId_, slot0.stageIndex_)
	end

	slot0.monsterList_:StartScroll(#slot0.monsterIdList_)
	slot0.difficultyController_:SetSelectedState(tostring(slot0.stageCfg_[1]))

	slot0.descLabel_.text = slot0.battleAbyssCfg_.tips

	if slot0.stageCfg_[1] == 3 then
		slot0.bossImage_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot0.monsterIdList_[1])

		if AbyssUICfg[slot0.monsterIdList_[1]] ~= nil then
			if slot1.icon_pos ~= nil and slot1.icon_pos ~= "" and #slot1.icon_pos > 0 then
				slot0.bossImage_.transform.anchoredPosition = Vector3(slot1.icon_pos[1], slot1.icon_pos[2], slot1.icon_pos[3])
			end

			if slot1.icon_scale ~= nil and slot1.icon_scale ~= "" and #slot1.icon_scale > 0 then
				slot0.bossImage_.transform.localScale = Vector3(slot1.icon_scale[1], slot1.icon_scale[2], slot1.icon_scale[3])
			end

			if slot1.icon_rot ~= nil and slot1.icon_rot ~= "" and #slot1.icon_rot > 0 then
				slot0.bossImage_.transform.localEulerAngles = Vector3(slot1.icon_rot[1], slot1.icon_rot[2], slot1.icon_rot[3])
			end
		end

		slot0.isBossController_:SetSelectedState("true")
	else
		slot0.isBossController_:SetSelectedState("false")
	end

	if AbyssData:IsLayerUnlock(slot0.layerId_) then
		slot0.stageData_ = AbyssData:GetStageData(slot0.abyssCfg_.id, slot0.stageIndex_)
		slot0.lockedHeroList_ = slot0.stageData_.lock_hero_id_list

		if slot0.stageData_.is_completed then
			slot0.completeController_:SetSelectedState("true")

			slot0.scoreLabel_.text = AbyssData:GetStageScore(slot0.abyssCfg_.id, slot0.stageIndex_)
		elseif slot0.stageCfg_[1] == 3 then
			if #slot0.stageData_.team_info_list > 0 then
				slot0.completeController_:SetSelectedState("challenging")
			else
				slot0.completeController_:SetSelectedState("false")
			end
		else
			slot0.completeController_:SetSelectedState("false")
		end

		if slot0.stageCfg_[1] == 3 then
			slot0.abandonList_:StartScroll(#slot0.abandonHeroList_)

			slot1 = AbyssData:GetStageData(slot0.layerId_, slot0.stageIndex_)
			slot4 = AbyssData:ConvertPhaseBossHpToTotal(slot0.stageId_, slot1.phase, slot1.boss_hp_rate) / AbyssData:GetBossTotalHp(slot0.stageId_)
			slot0.hpPercentLabel_.text = math.ceil(100 * slot4)
			slot0.bossHpSlider_.value = slot4
		else
			slot0.isBossController_:SetSelectedState("false")
		end

		slot0.lockList_:StartScroll(#slot0.lockedHeroList_)
	else
		if slot0.stageCfg_[1] == 3 then
			slot0.hpPercentLabel_.text = math.ceil(100)
			slot0.bossHpSlider_.value = 1
		end

		slot0.completeController_:SetSelectedState("not_open")
	end

	if AbyssData:GetStageResetTime() <= 0 then
		slot0.resetGrayedController_:SetSelectedState("true")
	else
		slot0.resetGrayedController_:SetSelectedState("false")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.lockList_ then
		slot0.lockList_:Dispose()

		slot0.lockList_ = nil
	end

	if slot0.abandonList_ then
		slot0.abandonList_:Dispose()

		slot0.abandonList_ = nil
	end

	if slot0.monsterList_ then
		slot0.monsterList_:Dispose()

		slot0.monsterList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
