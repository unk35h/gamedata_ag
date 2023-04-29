slot0 = singletonClass("LoadSceneMgr")

function slot0.Ctor(slot0)
	slot0.loadScenePool_ = {}
	slot0.isLoading_ = false
	slot0.loadInit_ = SceneLoadAndUnloadManager.Instance
end

function slot0.GetNeedLoadSceneName(slot0, slot1)
	for slot5 = #slot1, 1, -1 do
		if ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1[slot5]] then
			slot6, slot7 = slot0:GetShouldLoadSceneName(slot1[slot5])

			if not slot0.loadScenePool_[slot1[slot5]] then
				return slot1[slot5]
			end
		end
	end

	return nil
end

function slot0.SetShouldLoadSceneName(slot0, slot1)
	if not ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1] then
		return
	end

	slot2, slot3 = slot0:GetShouldLoadSceneName(slot1)

	if slot3 == slot0.loadScenePool_[slot1] then
		return
	end

	slot0.isLoading_ = true
	slot4 = slot0.loadInit_

	slot4:ChangeScene(slot2, slot0.loadScenePool_[slot1], function ()
		uv0.isLoading_ = false
		uv0.loadScenePool_[uv1] = uv2
		slot0 = nil

		if SceneManager.GetSceneByName(uv2).rootCount > 0 then
			slot0 = SceneManager.GetSceneByName(uv2):GetRootGameObjects()
		end

		if slot0 ~= nil then
			for slot4 = 0, slot0.Length - 1 do
				if slot0[slot4].name == uv2 then
					SetActive(slot0[slot4], true)
				end
			end
		end
	end)
end

function slot0.GetShouldLoadSceneName(slot0, slot1)
	slot2 = ""
	slot3 = ""

	if slot1 == "home" then
		slot2 = "Levels/" .. slot0:GetHomeShouldLoadSceneName()
	else
		error("未实现界面场景获取途径")
	end

	return slot2, slot3
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
