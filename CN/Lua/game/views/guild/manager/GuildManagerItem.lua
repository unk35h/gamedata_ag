slot0 = class("GuildManagerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.memberController_ = ControllerUtil.GetController(slot0.transform_, "taskItem")
	slot0.controller_ = ControllerUtil.GetController(slot0.transformPost_, "conName")
	slot0.buttonController_ = ControllerUtil.GetController(slot0.transformButton_, "conName")
	slot0.refreshImpeachHandler_ = handler(slot0, slot0.RefreshImpeach)

	manager.notify:RegistListener(GUILD_CAPTAIN_IMPEACH, slot0.refreshImpeachHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopImpeahTimer()
	manager.notify:RemoveListener(GUILD_CAPTAIN_IMPEACH, slot0.refreshImpeachHandler_)

	slot0.refreshImpeachHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonInfo_, nil, function ()
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.id_)
	end)
	slot0:AddBtnListener(slot0.buttonRemove_, nil, function ()
		if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
			ShowTips("ACTIVITY_CLUB_ACTIVITYING_REMOVE_MEMBER_TIP")

			return
		end

		slot0 = GuildData

		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("CLUB_REMOVE_MEMBER"), slot0:GetGuildMemberData(uv0.id_).name),
			OkCallback = function ()
				GuildAction.GuildRemoveMember(uv0.id_, function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonPost_, nil, function ()
		JumpTools.OpenPageByJump("guildMobilityPost", {
			memberID = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.buttonImpeach_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_IMPEACH_TIPS"),
			OkCallback = function ()
				GuildAction.GuildImpeach(uv0.id_, function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.buttonCancelImpeach_, nil, function ()
		GuildAction.GuildCancelImpeach(function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonAgree_, nil, function ()
		GuildAction.GuildAgreeRequest(uv0.id_, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.buttonRefuse_, nil, function ()
		GuildAction.GuildRefuseRequest(uv0.id_, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.applyBtn_, nil, function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_APPLY_CAPTAIN_TIPS"),
			OkCallback = function ()
				GuildAction.ApplyCaptain(function (slot0)
					ShowTips(slot0.result)
				end)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.isMember_ = slot2

	slot0:StopImpeahTimer()

	slot3 = nil

	if slot2 then
		slot3 = GuildData:GetGuildMemberData(slot1)

		if GuildData:GetGuildInfo().post == GuildConst.GUILD_POST.CAPTAIN then
			if slot3.id == USER_ID then
				if slot4.impeachTime - manager.time:GetServerTime() > 0 then
					slot0.buttonController_:SetSelectedState("impeach")
					slot0:AddImpeachTimer()
				else
					slot0.buttonController_:SetSelectedState("null")
				end
			elseif slot3.post == GuildConst.GUILD_POST.TRAINEE then
				slot0.buttonController_:SetSelectedState("remove")
			else
				slot0.buttonController_:SetSelectedState("captain")
			end
		elseif slot4.post == GuildConst.GUILD_POST.DEPUTY then
			if slot3.id == USER_ID or slot3.post == GuildConst.GUILD_POST.DEPUTY then
				slot0.buttonController_:SetSelectedState("null")
			elseif slot3.post == GuildConst.GUILD_POST.CAPTAIN then
				if slot4.impeachTime - manager.time:GetServerTime() > 0 then
					if slot4.isCandidate then
						slot0.buttonController_:SetSelectedState("applied")
					else
						slot0.buttonController_:SetSelectedState("impeaching")
					end

					slot0:AddImpeachTimer()
				elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
					slot0.buttonController_:SetSelectedState("deputy")
				else
					slot0.buttonController_:SetSelectedState("null")
				end
			else
				slot0.buttonController_:SetSelectedState("remove")
			end
		elseif slot3.post == GuildConst.GUILD_POST.CAPTAIN then
			if slot4.impeachTime - manager.time:GetServerTime() > 0 then
				if slot4.isCandidate then
					slot0.buttonController_:SetSelectedState("applied")
				else
					slot0.buttonController_:SetSelectedState("impeaching")
				end

				slot0:AddImpeachTimer()
			elseif manager.time:GetServerTime() > GuildData:GetCaptainOfflineTime() + 864000 then
				slot0.buttonController_:SetSelectedState("deputy")
			else
				slot0.buttonController_:SetSelectedState("null")
			end
		else
			slot0.buttonController_:SetSelectedState("null")
		end

		slot0.memberController_:SetSelectedState("member")
	else
		slot3 = GuildData:GetGuildRequestData(slot1)

		slot0.buttonController_:SetSelectedState("request")
		slot0.memberController_:SetSelectedState("run")
	end

	slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot3.icon)
	slot0.imageHeadBg_.sprite = ItemTools.getItemSprite(slot3.frame)
	slot0.textName_.text = slot3.name
	slot0.textLevel_.text = GetTips("LEVEL") .. string.format("%s", slot3.level)
	slot0.textContribute_.text = slot3.weekContribute

	if slot3.offlineStamptime == 0 then
		slot0.textOnline_.text = string.format("<color=#6AA788>%s</color>", manager.time:GetOnLineText(slot3.offlineStamptime))
	else
		slot0.textOnline_.text = string.format("<color=#494A4F>%s</color>", manager.time:GetOnLineText(slot3.offlineStamptime))
	end

	slot0.controller_:SetSelectedState(slot3.post)

	if slot3.post == GuildConst.GUILD_POST.CAPTAIN then
		slot0.labelText_.text = GetTips("CLUB_CHAIR_MAN")
	elseif slot3.post == GuildConst.GUILD_POST.DEPUTY then
		slot0.labelText_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif slot3.post == GuildConst.GUILD_POST.MEMBER then
		slot0.labelText_.text = GetTips("CLUB_MEMBER")
	elseif slot3.post == GuildConst.GUILD_POST.TRAINEE then
		slot0.labelText_.text = GetTips("CLUB_NOVICIATE")
	end
end

function slot0.RefreshImpeach(slot0)
	if slot0.isMember_ and GuildData:GetGuildMemberData(slot0.id_).post == GuildConst.GUILD_POST.CAPTAIN then
		slot0:SetData(slot1, slot0.isMember_)
	end
end

function slot0.AddImpeachTimer(slot0)
	slot0.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(GuildData:GetGuildInfo().impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))
	slot0.impeachTimer_ = Timer.New(function ()
		slot0 = uv0.impeachTime - manager.time:GetServerTime()
		uv1.textCountdown_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCDTime(slot0, "%H:%M:%S"))

		if slot0 <= 0 then
			uv1:StopImpeahTimer()
			GuildAction.RequiredGuildMemberList(function (slot0)
				if isSuccess(slot0) then
					manager.notify:Invoke(GUILD_CAPTAIN_IMPEACH)
				end
			end)
		end
	end, 1, -1)

	slot0.impeachTimer_:Start()
end

function slot0.StopImpeahTimer(slot0)
	if slot0.impeachTimer_ then
		slot0.impeachTimer_:Stop()

		slot0.impeachTimer_ = nil
	end
end

return slot0
