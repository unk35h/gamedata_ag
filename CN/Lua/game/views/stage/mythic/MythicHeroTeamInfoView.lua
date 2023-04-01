slot1 = class("MythicHeroTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.teamID_ = slot0.params_.teamID
	slot0.teamLength_ = slot0.params_.teamLength

	uv0.super.OnEnter(slot0)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, MythicHeroTeamHeadItem)
	slot0.filterView_ = slot0:GetFilterClass().New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot1.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7, slot8 = GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, {
		teamID = slot0.teamID_,
		teamLength = slot0.teamLength_
	}, nil, slot0.teamID_)
	slot9 = {}

	for slot13, slot14 in pairs(slot5) do
		slot9[slot13] = {
			id = slot14,
			trialID = slot8[slot13]
		}
	end

	if slot0:indexof(slot9, slot1) ~= slot0:indexof(slot9, slot2) then
		return true, slot10 < slot11
	end

	if slot1.trialID ~= 0 or slot2.trialID ~= 0 then
		if slot1.trialID ~= 0 and slot2.trialID ~= 0 then
			if slot3 == 0 and slot1.star ~= slot2.star then
				if slot0.curOrder_ == "desc" then
					return true, slot2.star < slot1.star
				else
					return true, slot1.star < slot2.star
				end
			end

			if getHeroPower(slot1.trialID, true) ~= getHeroPower(slot2.trialID, true) then
				if slot4 == "desc" then
					return true, slot13 < slot12
				else
					return true, slot12 < slot13
				end
			else
				return true, slot2.trialID < slot1.trialID
			end
		else
			return true, slot2.trialID < slot1.trialID
		end
	end

	return false, false
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:RefreshTeamTag(slot0.teamID_, slot0.teamLength_)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
end

function slot1.SelectHero(slot0, slot1, slot2)
	slot0.selectID_ = slot1
	slot0.selectTrialID_ = slot2
	slot5 = slot0.heroHeadList_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot1.GetHeroTeam(slot0)
	slot0.heroTeam_, slot0.lockStateList_, slot0.lockHeroList_, slot0.heroTrialList_ = GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, {
		teamID = slot0.teamID_,
		teamLength = slot0.teamLength_
	}, nil, slot0.teamID_)
end

function slot1.GetDefaultHeroData(slot0)
	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot5, slot6 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot6.id) and not table.keyof(slot0.lockHeroList_, slot7) then
				return slot7, 0
			end
		end
	end

	if slot1 == 0 then
		for slot5, slot6 in pairs(slot0.heroDataList_) do
			return slot6.id, 0
		end
	end

	return slot1, 0
end

function slot1.IsInTeam(slot0, slot1)
	for slot6 = 1, #BattleTeamData:GetSingleTeam(slot0.params_.stageType, slot6, nil, slot0.teamID_) do
		if slot2[slot6] == slot1 then
			return true
		end
	end

	return false
end

function slot1.GetTextAndImage(slot0)
	if slot0.lockStateList_[slot0.params_.selectHeroPos] == true then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if table.keyof(slot0.lockHeroList_, slot0.selectID_) or table.keyof(slot0.lockHeroList_, slot0.selectTrialID_) then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if slot0:IsSameHeroInTeam(slot0.selectID_) and not slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectID_ then
			slot0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		slot1 = 0

		for slot5, slot6 in pairs(slot0.heroTeam_) do
			if slot6 ~= 0 then
				slot1 = slot1 + 1
			end
		end

		return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function slot1.OnJoinClick(slot0)
	slot1 = false
	slot2 = slot0.heroTeam_
	slot3 = slot0.heroTrialList_
	slot4 = slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_)

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] and slot4 then
		slot2[slot0.params_.selectHeroPos] = 0
		slot3[slot0.params_.selectHeroPos] = 0
		slot1 = true
	elseif slot4 then
		slot5 = 1

		for slot9, slot10 in pairs(slot0.heroTeam_) do
			if slot10 == slot0.selectID_ then
				slot5 = slot9

				break
			end
		end

		slot2[slot5] = slot0.heroTeam_[slot0.params_.selectHeroPos]
		slot2[slot0.params_.selectHeroPos] = slot2[slot5]
		slot3[slot5] = slot0.heroTrialList_[slot0.params_.selectHeroPos]
		slot3[slot0.params_.selectHeroPos] = slot3[slot5]

		HeroTools.PlayTalk(slot0.selectID_, "team")
	else
		slot2[slot0.params_.selectHeroPos] = slot0.selectID_
		slot3[slot0.params_.selectHeroPos] = slot0.selectTrialID_

		HeroTools.PlayTalk(slot0.selectID_, "team")

		slot1 = true
	end

	if slot0.params_.reorder == nil or slot0.params_.reorder == true then
		if slot0:IsCustomTeamStage() then
			slot6 = 1
			slot7 = {}
			slot8 = {}

			for slot12, slot13 in pairs(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) do
				if slot13[1] then
					slot7[slot12] = slot13[1]
					slot8[slot12] = slot13[2]
				else
					slot7[slot12] = slot2[slot12]
					slot8[slot12] = slot3[slot12]
				end
			end

			for slot12 = 1, 3 do
				if not slot7[slot12] then
					for slot16, slot17 in pairs(slot2) do
						slot18 = table.keyof(slot7, slot17)

						if slot17 ~= 0 and not slot18 then
							slot7[slot12] = slot17
							slot8[slot12] = slot8[slot18]

							break
						end
					end

					slot7[slot12] = slot7[slot12] or 0
					slot8[slot12] = slot8[slot12] or 0
				end
			end

			slot2 = slot7
			slot3 = slot8
		else
			for slot8 = 3, 1, -1 do
				if slot2[slot8] == 0 then
					table.remove(slot2, slot8)
					table.remove(slot3, slot8)
				end
			end

			for slot8 = 1, 3 do
				if not slot2[slot8] then
					slot2[slot8] = 0
					slot3[slot8] = 0
				end
			end
		end
	end

	slot5 = nil

	for slot9 = 1, 3 do
		if slot0.teamID_ ~= slot9 then
			slot14 = {
				teamID = slot0.teamID_,
				teamLength = slot0.teamLength_
			}
			slot15 = nil

			for slot14, slot15 in ipairs(GetLocalHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot14, slot15, slot9)) do
				if slot15 ~= 0 then
					for slot19 = 1, 3 do
						if slot15 == slot2[slot19] then
							slot5 = slot9
						end
					end
				end
			end
		end
	end

	if slot5 then
		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), GetTips("NUM_" .. slot5)),
			OkCallback = function ()
				uv0:ExitFunc(uv1, uv2, uv3)
			end
		})
	else
		slot0:ExitFunc(slot2, slot3, slot1)
	end
end

function slot1.ExitFunc(slot0, slot1, slot2, slot3)
	slot0:ChangeTeam(slot1, slot2, slot3)

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:RemoveTween()
	end

	slot0:Back()
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8 = 1, 3 do
		if slot1[slot8] ~= 0 then
			slot4[#slot4 + 1] = slot1[slot8]
		end
	end

	for slot8 = #slot4 + 1, 3 do
		slot4[slot8] = 0
	end

	slot5, slot6 = BattleTeamData:GetMimirInfo(slot0.params_.stageType, nil, , slot0.teamID_)

	BattleTeamData:SetMultiTeamData(slot0.params_.stageType, nil, slot4, slot2 or {}, ComboSkillTools.GetRecommendSkillID(slot4, true), {
		id = slot5,
		chip = slot6
	}, nil, slot0.teamID_)
end

return slot1
