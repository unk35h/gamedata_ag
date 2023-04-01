slot0 = class("GuildActivityBossPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityBossPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.queryRankHandler_ = handler(slot0, slot0.OnQueryRank)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.finalReachableController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "finalReachable")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		GuildActivityAction.QueryRankList(uv0.params_.nodeId, uv0.queryRankHandler_)
	end)
	slot0:AddBtnListener(slot0.recordBtn_, nil, function ()
		GuildActivityAction.GetFightRecord(uv0.params_.nodeId, function (slot0)
			JumpTools.OpenPageByJump("guildActivityRecord", {
				dataList = slot0
			})
		end)
	end)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		uv0:Go("/guildActivitySelectHero", {
			section = uv0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = uv0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if GuildActivityData:GetNodeData(uv0.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function ()
					uv0:UpdateView()
					uv0:TipsOkCallBack()
				end
			})

			return
		end

		uv0:Go("/guildActivitySelectHero", {
			section = uv0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = uv0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	slot0:AddBtnListener(slot0.nextFloorBtn_, nil, function ()
		if table.indexof(ActivityClubMapCfg.all, uv0.nodeCfg_.map_id) < #GuildActivityData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_NEW_LEVEL)
		else
			GuildActivityAction.EnterNext(uv0.nodeCfg_.id)
		end
	end)
end

function slot0.TipsOkCallBack(slot0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	if slot0.delayTimer_ then
		slot0.delayTimer_:Stop()
	end

	slot0.delayTimer_ = FrameTimer.New(function ()
		GuildActivityLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	end, 1, 1)

	slot0.delayTimer_:Start()
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(UPDATE_GRIDS_DATA, function (slot0)
		if table.indexof(slot0, uv0.params_.nodeId) then
			uv0:UpdateView()
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.nodeCfg_ = ActivityClubCfg[slot0.params_.nodeId]

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.delayTimer_ then
		slot0.delayTimer_:Stop()
	end
end

function slot0.UpdateView(slot0)
	slot1 = GuildActivityData:GetNodeData(slot0.params_.nodeId)
	slot3 = table.indexof(ActivityClubMapCfg.all, slot0.nodeCfg_.map_id)
	slot0.titleLabel_.text = BattleClubActivityCfg[slot0.nodeCfg_.stage_id].name
	slot4 = slot0.nodeCfg_.boss_score
	slot5 = slot1.health
	slot0.hpLabel_.text = string.format("%d/%d", slot5, slot4)
	slot0.hpProgressBar_.value = slot5 / slot4
	slot0.bossNameLabel_.text = slot0.nodeCfg_.boss_name
	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.ActivityClubBossHeadIcon.path .. slot0.nodeCfg_.boss_icon)
	slot0.costLabel_.text = slot0.nodeCfg_.vitality_cost
	slot7 = GuildActivityData:IsNodeCanReach(slot0.params_.nodeId)

	if slot1.health <= 0 then
		if slot0.params_.nodeId == GuildActivityData:GetMaxNodeId() then
			slot0.statusController_:SetSelectedState("finalLevel")

			if slot7 then
				slot0.finalReachableController_:SetSelectedState("true")
			else
				slot0.finalReachableController_:SetSelectedState("false")
			end
		else
			slot0.statusController_:SetSelectedState("nextLevel")
		end
	elseif slot7 then
		slot0.statusController_:SetSelectedState("alive")
	else
		slot0.statusController_:SetSelectedState("unreach")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OnQueryRank(slot0)
	JumpTools.OpenPageByJump("guildActivityRank")
end

return slot0
