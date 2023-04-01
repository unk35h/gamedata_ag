slot0 = class("AbyssLevelItemView", ReduxView)

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

	slot0.difficultyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "difficulty")
	slot0.unlockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "unlock")
	slot0.bossStatusController_ = ControllerUtil.GetController(slot0.winGo_.transform, "Challengestatus")
	slot0.challengeStatusController_ = ControllerUtil.GetController(slot0.winGo_.transform, "Challengestatus1")
	slot0.selectController_ = ControllerUtil.GetController(slot0.winGo_.transform, "select")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.lockListGo_, AbyssHeroItemView)
	slot0.abandonUIList_ = LuaList.New(handler(slot0, slot0.indexAbandonItem), slot0.abandonListGo_, AbyssHeroItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, AbyssData:GetStageData(slot0.cfg_.id, slot0.index_).lock_hero_id_list[slot1])
end

function slot0.indexAbandonItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.abandonIdList_[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_STAGE_RESET_TIME_UPDATE, function (slot0, slot1)
		if uv0.cfg_ == nil then
			return
		end

		if slot0 == uv0.cfg_.id and slot1 == uv0.stageId_ then
			uv0:UpdateView()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.cfg_ = slot1
	slot0.index_ = slot2
	slot0.stageCfg_ = slot0.cfg_.stage_list[slot2]
	slot0.stageType_ = slot0.stageCfg_[1]
	slot0.stageId_ = slot0.stageCfg_[2]
	slot0.score_ = slot0.stageCfg_[3]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.difficultyController_:SetSelectedState(tostring(slot0.stageCfg_[1]))

	if AbyssData:IsLayerUnlock(slot0.cfg_.id) then
		slot0.unlockController_:SetSelectedState("true")

		slot0.scoreLabel_.text = AbyssData:GetStageScore(slot0.cfg_.id, slot0.index_)

		if AbyssData:GetStageData(slot0.cfg_.id, slot0.index_).is_completed then
			slot0.challengeStatusController_:SetSelectedState("lock")

			if slot0.index_ == 3 then
				CustomLog.Log(debug.traceback(string.format("3")))
			end

			slot0.uiList_:StartScroll(#slot1.lock_hero_id_list)
		else
			slot0.challengeStatusController_:SetSelectedState("no")
		end

		if slot0.stageType_ == 3 then
			slot2 = AbyssData:GetStageData(slot0.cfg_.id, slot0.index_)
			slot5 = AbyssData:ConvertPhaseBossHpToTotal(slot0.stageId_, slot2.phase, slot2.boss_hp_rate) / AbyssData:GetBossTotalHp(slot0.stageId_)
			slot0.hpPercentLabel_.text = math.ceil(100 * slot5)
			slot0.bossHpSlider_.value = slot5
			slot0.abandonIdList_ = AbyssData:GetStageAbandonList(slot0.cfg_.id, slot0.index_)

			if #slot0.abandonIdList_ > 0 then
				slot0.abandonUIList_:StartScroll(#slot0.abandonIdList_)
				slot0.bossStatusController_:SetSelectedState("boss")
			else
				slot0.bossStatusController_:SetSelectedState("boss_1")
			end
		else
			slot0.bossStatusController_:SetSelectedState("normal")
		end
	else
		slot0.unlockController_:SetSelectedState("false")
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

function slot0.SetSelect(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState("select_1")
	else
		slot0.selectController_:SetSelectedState("normal")
	end
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	if slot0.abandonUIList_ then
		slot0.abandonUIList_:Dispose()

		slot0.abandonUIList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
