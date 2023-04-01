return {
	GetDrawInfo = function (slot0)
		slot1 = DrawInfoCfg.get_id_list_by_pool_id[slot0]
		slot2 = #slot1
		slot3 = {}

		for slot7, slot8 in ipairs(slot1) do
			slot3[DrawInfoCfg[slot8].index] = {
				name = DrawInfoCfg[slot8].name .. "",
				probability = DrawInfoCfg[slot8].probability .. "",
				rare = DrawInfoCfg[slot8].rare .. "",
				index = DrawInfoCfg[slot8].index,
				length = slot2
			}
		end

		return slot3
	end,
	GetCostTicket = function (slot0)
		return DrawPoolCfg[slot0].cost_once[1]
	end,
	GetActivityCostTicket = function (slot0)
		return DrawPoolCfg[slot0].cost_once_activity_material[1] or 0
	end,
	LoadDrawLevel = function (slot0)
		if SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
			return
		end

		if slot0.operation_ then
			return
		end

		slot0.operation_ = Asset.LoadLevelAsync("Levels/X102", true)

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		slot0.timer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.timer_:Start()
	end,
	Process = function (slot0)
		if slot0.operation_:IsDone() then
			if not gameContext:GetOpenPageHandler("draw") and SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
				SceneManager.UnloadSceneAsync("X102")
			end

			if slot0.timer_ then
				slot0.timer_:Stop()

				slot0.timer_ = nil
			end

			slot0.operation_ = nil
		end
	end,
	UnLoadDrawLevel = function (slot0)
		if slot0.operation_ then
			return
		end

		if SceneManager.GetSceneByName("X102") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X102")
		end
	end,
	LevelIsDone = function (slot0)
		if slot0.operation_ then
			return slot0.operation_:IsDone()
		end

		return true
	end
}
