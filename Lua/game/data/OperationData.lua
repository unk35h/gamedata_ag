slot0 = singletonClass("OperationData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.InitOperationOpenList(slot0, slot1)
	uv0 = cleanProtoTable(slot1.id_list)
end

function slot0.InitFollowOpenList(slot0, slot1)
	uv0 = {}

	for slot6, slot7 in ipairs(slot1.media_list) do
		table.insert(uv0, slot7)
	end
end

function slot0.GetOperationOpenList(slot0)
	return uv0
end

function slot0.IsOperationOpen(slot0, slot1)
	if not table.keyof(uv0, slot1) then
		return true
	end

	return false
end

function slot0.IsFollowOpen(slot0, slot1)
	return not not table.keyof(uv0, slot1)
end

function slot0.SetFunctionStopIdList(slot0, slot1)
	uv0 = slot1

	manager.notify:Invoke(OPERATION_STOP_UPDATE, {})
end

function slot0.IsFunctionStoped(slot0, slot1)
	if table.indexof(uv0, slot1) then
		return true
	end

	return false
end

return slot0
