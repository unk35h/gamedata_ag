slot0 = singletonClass("LoadSceneMgr")

function slot0.Ctor(slot0)
	slot0.loadScenePool_ = {}
	slot0.isLoading_ = false
	slot0.loadInit_ = SceneLoadAndUnloadManager.Instance
end

function slot0.SetShouldLoadSceneName(slot0, slot1)
	if not ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1] then
		return
	end

	slot2 = ""
	slot3 = ""

	if slot1 == "home" then
		slot2 = "Levels/" .. slot0:GetHomeShouldLoadSceneName()
	else
		error("未实现界面场景获取途径")
	end

	if slot3 == slot0.loadScenePool_[slot1] then
		return
	end

	slot0.isLoading_ = true
	slot4 = slot0.loadInit_

	slot4:ChangeScene(slot2, slot0.loadScenePool_[slot1], function ()
		uv0.isLoading_ = false
		uv0.loadScenePool_[uv1] = uv2
	end)
end

function slot0.CanEnd(slot0)
	return not slot0.isLoading_
end

slot1 = {
	time = 3,
	data = 2,
	weather = 1
}

function slot0.GetHomeShouldLoadSceneName(slot0)
	return slot0:GetHHScene(manager.time:STimeDescS(manager.time:GetServerTime(), "!%H"))
end

function slot0.GetHHScene(slot0, slot1)
	slot2 = tonumber(slot1)

	for slot7, slot8 in ipairs(HomeSceneCfg.get_id_list_by_type[uv0.time]) do
		slot9 = HomeSceneCfg[slot8]
		slot11 = slot9.end_time

		if slot9.start_time <= slot2 and slot2 <= slot11 then
			return slot9.scene
		end
	end

	return ""
end

function slot0.Dispose(slot0)
	slot0.loadScenePool_ = {}
end

return slot0
