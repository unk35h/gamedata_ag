slot0 = singletonClass("proposalData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.InitProposal(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = {
			proposal_id = slot6.id,
			proposal_name = slot6.name,
			equip_list = {}
		}

		for slot10, slot11 in ipairs(slot6.equip) do
			uv0[slot6.id].equip_list[slot10] = {
				pos = slot11.pos,
				equip_id = slot11.equip_id
			}

			if slot11.equip_id ~= 0 then
				if not uv1[slot11.equip_id] then
					uv1[slot11.equip_id] = 1
				else
					uv1[slot11.equip_id] = uv1[slot11.equip_id] + 1
				end
			end
		end
	end
end

function slot0.IsProposalMax(slot0)
	slot1 = GameSetting.equip_proposal_num_max.value[1]
	slot2 = 0

	for slot6, slot7 in pairs(uv0) do
		slot2 = slot2 + 1
	end

	return slot1 <= slot2
end

function slot0.HaveProposal(slot0, slot1)
	slot2 = uv0.Tools.SetEquipListFormat(slot1)

	for slot6, slot7 in pairs(uv1) do
		if table.equal(slot7.equip_list, slot2, "all") then
			return true
		end
	end

	return false
end

function slot0.GetProposalByID(slot0, slot1)
	return uv0[slot1]
end

function slot0.ModifyProposal(slot0, slot1, slot2, slot3)
	if not uv0[slot3] then
		error("似乎发生了错误")
	end

	uv0[slot3].proposal_name = slot2
end

function slot0.AddProposal(slot0, slot1, slot2, slot3)
	uv0[slot3] = {
		proposal_id = slot3,
		proposal_name = slot2,
		equip_list = {}
	}

	for slot8, slot9 in pairs(HeroTools.GetHeroEquipS(slot1)) do
		uv0[slot3].equip_list[slot8] = {
			pos = slot9.pos,
			equip_id = slot9.equip_id
		}

		if slot9.equip_id ~= 0 then
			if not uv1[slot9.equip_id] then
				uv1[slot9.equip_id] = 1
			else
				uv1[slot9.equip_id] = uv1[slot9.equip_id] + 1
			end
		end
	end
end

function slot0.AddProposalCommon(slot0, slot1, slot2, slot3)
	uv0[slot3] = {
		proposal_id = slot3,
		proposal_name = slot2,
		equip_list = {}
	}

	for slot7, slot8 in pairs(uv1.Tools.SetEquipListFormat(slot1)) do
		uv0[slot3].equip_list[slot8.pos] = {
			pos = slot8.pos,
			equip_id = slot8.equip_id
		}

		if slot8.equip_id ~= 0 then
			if not uv2[slot8.equip_id] then
				uv2[slot8.equip_id] = 1
			else
				uv2[slot8.equip_id] = uv2[slot8.equip_id] + 1
			end
		end
	end
end

function slot0.DeleteProposal(slot0, slot1)
	for slot6, slot7 in pairs(uv0[slot1].equip_list) do
		if slot7.equip_id ~= 0 then
			uv1[slot7.equip_id] = uv1[slot7.equip_id] - 1

			if uv1[slot7.equip_id] == 0 then
				uv1[slot7.equip_id] = nil
			end
		end
	end

	uv0[slot1] = nil
end

function slot0.GetProposalData(slot0)
	return uv0
end

function slot0.GetEquipMap(slot0)
	return uv0
end

slot0.Tools = {
	SetEquipListFormat = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot6.pos] = {
				equip_id = slot6.equip_id,
				pos = slot6.pos
			}
		end

		for slot5 = 1, 6 do
			if not slot1[slot5] then
				slot1[slot5] = {
					equip_id = 0,
					pos = slot5
				}
			end
		end

		return slot1
	end
}

function slot0.RemoveProposalByEquip(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		for slot10, slot11 in ipairs(slot6.equip_list) do
			if slot11.equip_id ~= 0 and table.keyof(slot1, slot11.equip_id) then
				slot6.proposal_id = nil
				uv1[slot11.equip_id] = uv1[slot11.equip_id] - 1
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(uv0) do
		if slot7.proposal_id ~= nil then
			slot2[#slot2 + 1] = deepClone(slot7)
			slot2[#slot2].proposal_id = #slot2
		end
	end

	uv0 = slot2
end

return slot0
