return {
	GetMainUIName = function (slot0)
		if ActivityConst.SPRING_ANTITHETICAL_COUPLET == slot0 then
			return "UI/EmptyDream/SpringFestivalCouplets/EDream_SFCoupletsUI"
		else
			return "UI/EmptyDream/SpringFestivalCouplets/EDream_SFCoupletsUI"
		end
	end,
	GetResultUIName = function (slot0)
		if ActivityConst.SPRING_ANTITHETICAL_COUPLET == slot0 then
			return "UI/EmptyDream/SpringFestivalCouplets/EDream_SFCoupletsGameUI"
		else
			return "UI/EmptyDream/SpringFestivalCouplets/EDream_SFCoupletsGameUI"
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.SPRING_ANTITHETICAL_COUPLET == slot0 then
			return "ACTIVITY_SPRING_FESTIVAL_COUPLETS_DESCRIPE"
		else
			return ""
		end
	end
}
