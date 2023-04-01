return {
	AddProposal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(13036, {
			hero_id = slot0,
			proposal_name = slot1
		}, 13037, uv0.OnAddProposal)
	end,
	OnAddProposal = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ProposalData:AddProposal(slot1.hero_id, slot1.proposal_name, slot0.proposal_id)
			manager.notify:CallUpdateFunc(ADD_PROPOSAL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	AddProposalCommon = function (slot0, slot1)
		manager.net:SendWithLoadingNew(13042, {
			equip = slot0,
			proposal_name = slot1
		}, 13043, uv0.OnAddProposalCommon)
	end,
	OnAddProposalCommon = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ProposalData:AddProposalCommon(slot1.equip, slot1.proposal_name, slot0.proposal_id)
			manager.notify:CallUpdateFunc(ADD_PROPOSAL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	DeleteProposal = function (slot0)
		manager.net:SendWithLoadingNew(13040, {
			proposal_id = slot0
		}, 13041, uv0.OnDeleteProposal)
	end,
	OnDeleteProposal = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ProposalData:DeleteProposal(slot1.proposal_id)
			manager.notify:CallUpdateFunc(DELETE_PROPOSAL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ModifyProposal = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(13038, {
			hero_id = 0,
			proposal_name = slot1,
			proposal_id = slot2
		}, 13039, uv0.OnModifyProposal)
	end,
	OnModifyProposal = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ProposalData:ModifyProposal(slot1.hero_id, slot1.proposal_name, slot1.proposal_id)
			manager.notify:CallUpdateFunc(MODIFY_PROPOSAL, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end
}
