slot1 = manager.net

slot1:Bind(61091, function (slot0)
	PaperCutData:SetData(slot0)
end)

return {
	RequireReceive = function (slot0, slot1)
		slot2 = manager.net

		slot2:SendWithLoadingNew(61088, {
			id = slot0
		}, 61089, function (slot0)
			uv0(slot0)
		end)
	end,
	RequireComplete = function (slot0, slot1, slot2)
		slot3 = manager.net

		slot3:SendWithLoadingNew(61086, {
			activity_id = slot0,
			score = slot1
		}, 61087, function (slot0)
			if isSuccess(slot0.result) then
				PaperCutData:SetScore(uv0, uv1)

				if uv2 ~= nil then
					uv2()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	Init = function (slot0)
		if #ActivityData:GetActivityData(slot0).subActivityIdList > 0 then
			slot2 = {}
			slot3 = {}

			for slot7, slot8 in ipairs(slot1) do
				PaperCutCfg[slot8].main_activity_id = slot0

				if ActivityPointRewardCfg.get_id_list_by_activity_id[slot8] ~= nil then
					for slot13, slot14 in ipairs(slot9) do
						PaperCutCfg[ActivityPointRewardCfg[slot14].activity_id].task_id = slot14
					end
				end

				slot2[#slot2 + 1] = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, slot0, slot8)
				slot3[#slot3 + 1] = string.format("%s_%s_%s_Reward", RedPointConst.PAPER_CUT, slot0, slot8)
			end

			slot4 = string.format("%s_%s_Select", RedPointConst.PAPER_CUT, slot0)
			slot5 = string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, slot0)

			manager.redPoint:addGroup(slot4, slot2)
			manager.redPoint:addGroup(slot5, slot3)
			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.PAPER_CUT, slot0), {
				slot4,
				slot5
			})
		end
	end
}
