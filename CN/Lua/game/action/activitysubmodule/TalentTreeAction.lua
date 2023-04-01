slot1 = false
slot2 = nil

return {
	Init = function ()
		TalentTreeData:InitData()

		if uv0 then
			return
		end

		slot0 = manager.net

		slot0:Bind(11051, function (slot0)
			TalentTreeData:SetData(slot0.talent_list)
			uv0.UpdateRedPoint(slot0.activity_id)
		end)

		slot0 = manager.notify

		slot0:RegistListener(CURRENCY_UPDATE, function ()
			for slot4, slot5 in pairs(ActivityData:GetAllActivityData()) do
				if ActivityTools.GetActivityType(slot4) == ActivityTemplateConst.TALENT_TREE then
					uv0.UpdateRedPoint(slot4)
				end
			end
		end)

		uv0 = true
	end,
	UpTalentLevel = function (slot0, slot1)
		uv0 = slot1

		manager.net:SendWithLoadingNew(11052, {
			id = slot0
		}, 11053, uv1.OnUpTalentLevel)
	end,
	OnUpTalentLevel = function (slot0, slot1)
		if isSuccess(slot0.result) then
			TalentTreeData:UpTalent(slot1.id)

			if uv0 then
				CurrencyAction.CurrencyModify(uv0[1], -1 * uv0[2])
			end

			ShowTips("MATRIX_TERMINAL_GIFT_UPGRADE_SUCCESS")
			manager.notify:CallUpdateFunc(TALENT_LEVEL_UP, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot1 = TalentTreeData:GetTalentList()
		isOn = false

		for slot6, slot7 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[slot0]) do
			if TalentTreeTools.IsCanUp(slot7) then
				isOn = true
			end
		end

		manager.redPoint:setTip(RedPointConst.TALENT_TREE .. slot0, isOn and 1 or 0)
	end
}
