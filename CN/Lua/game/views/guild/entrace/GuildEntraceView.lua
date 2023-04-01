slot0 = class("GuildEntraceView", ReduxView)

function slot0.Init(slot0)
	slot0.enterGuildHandler_ = handler(slot0, slot0.EnterGuild)
	slot0.exitGuildHandler_ = handler(slot0, slot0.ExitGuild)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(GUILD_ENTER, slot0.enterGuildHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.exitGuildHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_ENTER, slot0.enterGuildHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.exitGuildHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.enterGuildHandler_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.EnterGuild(slot0)
	if slot0:IsOpenRoute("chat") then
		JumpTools.OpenPageByJump("guildEntrace/guildMain/chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	else
		slot0:Go("/guildEntrace/guildMain")
	end
end

function slot0.ExitGuild(slot0)
	slot0:Go("/home")
end

return slot0
