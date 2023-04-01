slot1 = manager.net

slot1:Bind(51001, function (slot0)
	HistoryData:InitData(slot0)
	manager.notify:Invoke(HISTORY_UPDATE)
end)

return {}
