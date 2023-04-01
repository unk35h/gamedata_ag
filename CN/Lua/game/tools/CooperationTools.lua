return {
	GotoCooperation = function ()
		if not CooperationData:GetRoomData() then
			error("GotoCooperation with nil room")

			return
		end

		slot1 = slot0.dest

		OpenPageUntilLoaded("/cooperationBlank/cooperation")
	end,
	GotoCooperationEntry = function (slot0, slot1)
		print("GotoCooperationEntry", slot0)
		OpenPageUntilLoaded("/cooperationBlank/demoCooperationEntry")
	end
}
