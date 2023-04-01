slot0 = class("GuildActivityNormalPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivityUI/GuildActivityNormalPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot0 = GuildActivityData:GetNodeData(uv0.params_.nodeId)

		if slot0.occupied_num + slot0.processing_num >= 10 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_GRID_OCCUPY_MAX"),
				OkCallback = function ()
					uv0:TipsOkCallBack()
				end
			})

			return
		end

		if GuildActivityData:GetMaxOccupyCount() <= GuildActivityData:GetMyOccupiedNum() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_SELF_OCCUPY_MAX"),
				OkCallback = function ()
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
		GuildActivityAction.LockNode(uv0.params_.nodeId)
	end)
	slot0:AddBtnListener(slot0.giveupBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_NORMAL_GRID_GIVEUP_CONFIRM"),
			OkCallback = function ()
				uv0:TipsOkCallBack()
				GuildActivityAction.GiveUpNode(uv0.nodeCfg_.id)
				uv0:Back()
			end,
			CancelCallback = function ()
			end
		})
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
	slot0.titleLabel_.text = BattleClubActivityCfg[slot0.nodeCfg_.stage_id].name
	slot0.levelLabel_.text = "Lv." .. slot0.nodeCfg_.level
	slot0.cdLabel_.text = "+" .. slot0.nodeCfg_.token_get

	if 10 - GuildActivityData:GetNodeData(slot0.params_.nodeId).history_occupied_num < 1 then
		slot2 = 1
	end

	slot0.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(slot2))
	slot0.difficultyReduceLabel_.text = tostring(100 - slot2 * 10) .. "%"
	slot0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_ATTACK_DESC"), slot1.occupied_num, slot1.processing_num)
	slot0.energyCostLabel_.text = slot0.nodeCfg_.vitality_cost

	if GuildActivityData:IsMyOccupiedNode(slot0.params_.nodeId) then
		slot0.statusController_:SetSelectedState("occupied")
	elseif slot1.occupied_num + slot1.processing_num >= 10 then
		slot0.statusController_:SetSelectedState("full")
	elseif GuildActivityData:IsNodeCanReach(slot0.params_.nodeId) then
		slot0.statusController_:SetSelectedState("unoccupy")
	else
		slot0.statusController_:SetSelectedState("unreach")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
