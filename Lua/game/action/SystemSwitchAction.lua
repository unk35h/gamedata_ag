slot1 = manager.net

slot1:Bind(12041, function (slot0)
	SystemSwitchData:SetData(slot0)
	WarChessAction.UpdateWarChessRedPoint()
end)

slot1 = manager.net

slot1:Bind(12043, function (slot0)
	SystemSwitchData:UpdateData(slot0)
	manager.notify:Invoke(SYSTEM_SWITCH_UPDATE)
end)

return {}
