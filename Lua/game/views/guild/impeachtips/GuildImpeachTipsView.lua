slot0 = class("GuildImpeachTipsView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubImpeachTips"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:AddImpeachTimer()
	GuildData:SetImpeachFlag()
end

function slot0.OnExit(slot0)
	slot0:StopImpeahTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		GuildAction.GuildCancelImpeach(function (slot0)
			if isSuccess(slot0.result) then
				uv0:Back()
			else
				ShowTips(slot0.result)
			end
		end)
	end)
end

function slot0.AddImpeachTimer(slot0)
	slot0.textCountdown_.text = string.format("%s%s", GetTips("CLUB_IMPEACH_CD"), manager.time:DescCDTime(GuildData:GetGuildInfo().impeachTime - manager.time:GetServerTime(), "%H:%M:%S"))
	slot0.impeachTimer_ = Timer.New(function ()
		slot0 = uv0.impeachTime - manager.time:GetServerTime()
		uv1.textCountdown_.text = string.format("%s%s", uv2, manager.time:DescCDTime(slot0, "%H:%M:%S"))

		if slot0 <= 0 then
			uv1:StopImpeahTimer()
			manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
			GuildAction.RequiredGuildMemberList(function ()
			end)
			uv1:Back()
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
