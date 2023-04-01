slot1 = manager.net

slot1:Bind(11055, function (slot0)
	SkinTrialData:InitData(slot0)
	manager.notify:Invoke(SKIN_TRIAL_UPDATE)
end)

return {
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			if ActivitySkinTrialCfg.get_id_list_by_activity_id[slot0] ~= nil then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot0), 0)
			elseif ActivityData:GetActivityData(slot0).subActivityIdList ~= nil then
				for slot5, slot6 in ipairs(slot1) do
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot6), 0)
				end
			end
		end
	end
}
