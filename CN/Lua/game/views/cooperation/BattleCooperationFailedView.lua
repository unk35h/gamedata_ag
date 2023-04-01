slot0 = class("BattleCooperationFailedView", BattleFailedView)

function slot0.Quit(slot0)
	slot0.isEnd = true

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry()
		end
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

function slot0.RecordThreeStar(slot0)
end

return slot0
