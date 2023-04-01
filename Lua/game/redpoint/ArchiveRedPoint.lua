return {
	IsHeartLinkUnlock = function (slot0)
		slot1 = nil

		if table.indexof(GameDisplayCfg.heart_chain_missing.value, slot0) then
			return nil
		end

		slot2 = HeroRecordCfg[slot0]

		for slot6 = 1, 100 do
			if not slot2["heart_chain" .. slot6] then
				break
			end

			if slot2["heart_chain" .. slot6] == "" then
				-- Nothing
			else
				slot9 = ArchiveData:IsHeartRead(slot0, slot6)

				if IsConditionAchieved(GameSetting.heart_chain_unlock_condition.value[slot6], {
					heroId = slot0
				}) and not slot9 then
					slot1 = slot6
				end
			end
		end

		return slot1
	end,
	GetRedPointData = function (slot0, slot1)
		slot2 = nil

		if slot0 == "heartLink" then
			slot2 = getData("heartlinkIsClick", tostring(slot1))
		elseif slot0 == "archive" then
			slot2 = getData("archiveIsClick", tostring(slot1))
		else
			error("type错误")
		end

		return slot2
	end,
	SetRedPointData = function (slot0, slot1)
		slot2 = uv0.IsHeartLinkUnlock(slot1)

		if slot0 == "heartLink" then
			saveData("heartlinkIsClick", tostring(slot1), slot2)
		elseif slot0 == "archive" then
			saveData("archiveIsClick", tostring(slot1), slot2)
		else
			error("type错误")
		end
	end,
	ShowHeartLinkRedPoint = function (slot0)
		slot1 = uv0.IsHeartLinkUnlock(slot0)

		if not uv0.GetRedPointData("heartLink", slot0) and slot1 then
			return true
		end

		if slot2 and slot1 and slot2 < slot1 then
			return true
		end

		return false
	end,
	ShowArchiveRedPoint = function (slot0)
		slot1 = uv0.IsHeartLinkUnlock(slot0)

		if not uv0.GetRedPointData("archive", slot0) and slot1 then
			return true
		end

		if slot2 and slot1 and slot2 < slot1 then
			return true
		end

		return false
	end
}
