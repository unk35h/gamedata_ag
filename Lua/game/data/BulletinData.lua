slot0 = singletonClass("BulletinData")
slot1 = {}
slot2 = {}
slot3 = false
slot4 = false
slot5, slot6 = nil
slot7 = false
slot8, slot9 = nil
slot10 = Timer.New(function ()
	for slot3, slot4 in pairs(BulletinData.GetBulletinPageList()) do
		if slot4.endTime < manager.time:GetServerTime() then
			BulletinAction.BulletinDelete(slot4.id)
		end
	end
end, 1, -1)

slot10:Start()

function slot0.Init()
	uv0 = {}
	uv1 = {}
	uv2 = false
end

function slot0.constructImage(slot0)
	return {
		itemType = slot0.content_type,
		spriteUrl = slot0.image,
		text = slot0.text,
		event = {
			slot0.event_type,
			slot0.event_arg
		}
	}
end

function slot0.constructText(slot0)
	return {
		itemType = slot0.content_type,
		text = slot0.text
	}
end

function slot0.constructTitle(slot0)
	return {
		itemType = slot0.content_type,
		text = string.match(slot0.text, "<title>(%a+)</title>")
	}
end

function slot0.constructReward(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.reward_item) do
		table.insert(slot1, {
			slot6.id,
			slot6.num
		})
	end

	return {
		itemType = slot0.content_type,
		rewardList = slot1
	}
end

function slot0.constructBulletin(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.content) do
		if slot6.content_type == 1 then
			slot1[slot5] = uv0.constructImage(slot6)
		elseif slot6.content_type == 2 then
			if string.find(slot6.text, "<title>") then
				slot6.content_type = 4
				slot1[slot5] = uv0.constructTitle(slot6)
			else
				slot1[slot5] = uv0.constructText(slot6)
			end
		elseif slot6.content_type == 3 then
			slot1[slot5] = uv0.constructReward(slot6)
		end
	end

	return {
		id = slot0.id,
		type = slot0.type,
		name = slot0.title,
		startTime = slot0.start_timestamp,
		endTime = slot0.end_timestamp,
		index = slot0.index,
		content = slot1
	}
end

function slot0.constructBulletionID(slot0, slot1)
	uv0[slot0] = uv0[slot0] or {}

	for slot5, slot6 in pairs(uv0[slot0]) do
		if slot6 == slot1 then
			return
		end
	end

	for slot5, slot6 in ipairs(uv0[slot0]) do
		if uv1[slot6].index < uv1[slot1].index then
			table.insert(uv0[slot0], slot5, slot1)

			return
		end
	end

	table.insert(uv0[slot0], slot1)
end

function slot0.insertBulletin(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if slot5.id == slot0.id then
			uv0[slot0.id] = uv1.constructBulletin(slot0)

			return
		end
	end

	uv0[slot0.id] = uv1.constructBulletin(slot0)
end

function slot0.refreshBulletin(slot0)
	for slot4, slot5 in ipairs(slot0.announcement_list) do
		uv0.insertBulletin(slot5)
		uv0.constructBulletionID(slot5.type, slot5.id)
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
end

function slot0.deleteBulletin(slot0)
	uv0[slot0.id] = nil

	for slot5, slot6 in pairs(uv1) do
		for slot10, slot11 in pairs(slot6) do
			if slot11 == slot1 then
				uv1[slot5][slot10] = nil

				break
			end
		end
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
	manager.notify:Invoke(BULLETIN_DELETE, slot1)
end

function slot0.GetBulletinIDList()
	return uv0
end

function slot0.GetBulletinPageList()
	return uv0
end

function slot0.GetReadFlag()
	return uv0
end

function slot0.SetReadFlag(slot0)
	uv0 = slot0

	manager.notify:Invoke(BULLETIN_READ_UPDATE)
end

function slot0.SetReadFlagById(slot0)
	saveData("bulletin", "bulletin_" .. slot0, "true")
	manager.notify:Invoke(BULLETIN_SINGLE_READ_UPDATE, slot0)
end

function slot0.GetCachePop()
	return uv0
end

function slot0.SetCachePop(slot0)
	uv0 = slot0
end

function slot0.GetIslogin()
	return uv0
end

function slot0.SetIslogin(slot0)
	uv0 = slot0
end

function slot0.SetCacheString(slot0, slot1)
	uv0 = slot0
	uv1 = slot1
end

function slot0.GetCurCacheStringAndID()
	return uv0, uv1
end

function slot0.GetCacheStringIsShowByID(slot0)
	slot2 = getData("BulletinData", "Num") or {
		-1
	}

	if table.indexof(getData("BulletinData", "Id") or {
		-1
	}, slot0) then
		if slot2[slot3] > 2 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function slot0.SetCacheStringIsShowByID(slot0)
	slot2 = getData("BulletinData", "Num") or {
		-1
	}

	if table.indexof(getData("BulletinData", "Id") or {
		-1
	}, slot0) then
		slot2[slot3] = slot2[slot3] + 1
	else
		table.insert(slot1, slot0)
		table.insert(slot2, 1)
	end

	saveData("BulletinData", "Id", slot1)
	saveData("BulletinData", "Num", slot2)
end

function slot0.CreateTimer()
	if uv0.timer_ == nil then
		uv0.timer_ = Timer.New(function ()
			BulletinTools.CreatTipsWithoutTimer(uv0, uv1)
		end, 300, 2)

		uv0.timer_:Start()
	end
end

function slot0.StopTimer()
	if uv0.timer_ then
		uv0.timer_:Stop()

		uv0.timer_ = nil
	end
end

function slot0.OnLogout()
	uv0 = false
	uv1 = nil
	uv2 = nil

	uv3.StopTimer()
end

function slot0.CreatTips(slot0, slot1)
	if uv0 == nil then
		uv0 = Object.Instantiate(Asset.Load("UI/BulletinBoardTips"), manager.ui.dontDestroyCanvas.transform)
		uv1 = RollTipsView.New(uv0)

		uv1:Play(slot0)
	else
		SetActive(uv0, true)
		uv1:Play(slot0)
	end
end

return slot0
