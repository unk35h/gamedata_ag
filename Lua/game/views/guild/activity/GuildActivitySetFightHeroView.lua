slot1 = class("GuildActivitySetFightHeroView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)

	slot1 = slot0.filterView_

	slot1:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		slot4 = uv0.params_.heroId or 0

		if (slot0.id == slot4 and 1 or 0) ~= (slot1.id == slot4 and 1 or 0) then
			return true, slot6 < slot5
		end

		return false, false
	end)
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.energyItem_ = GuildActivityTeamInfoEnergyItemView.New(Object.Instantiate(Asset.Load("UI/GuildActivityUI/items/energy"), slot0.extensionContainer_))
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
end

function slot1.UpdateHeroView(slot0)
	slot2 = slot0.selectID_
	slot0.fightPowerText_.text = getHeroPower(slot2, false)

	slot0.heroAvatarView_:SetSkinId(HeroTools.HeroUsingSkinInfo(slot0.selectID_).id)

	slot3 = HeroCfg[slot2]
	slot0.nameText_.text = slot3.name
	slot0.subNameText_.text = slot3.suffix

	slot0.energyItem_:SetCurrent(slot0:IsHeroInTeam(slot0.selectID_))

	slot4 = GameSetting.activity_club_hero_fatigue_max.value[1]
	slot5 = nil

	slot0.energyItem_:SetData(slot4, GuildActivityData:IsFirstConfigFightRole() and slot4 or table.indexof(slot0.params_.putOffList, slot0.selectID_) and 0 or GuildActivityData:GetHeroFatigue(slot0.selectID_))
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddEventListeners()
	SetActive(slot0.infoBtn_.gameObject, false)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot1.GetHeroTeam(slot0)
end

function slot1.GetRestrictHeroList(slot0, slot1)
	return nil
end

function slot1.OnJoinClick(slot0)
	if slot0.params_.heroId ~= nil and slot0.params_.heroId > 0 then
		if slot0.selectID_ == slot0.params_.heroId then
			if not GuildActivityData:IsFirstConfigFightRole() then
				ShowMessageBox({
					content = GetTips("ACTIVITY_CLUB_REMOVE_TEAM_TIP"),
					OkCallback = function ()
						if uv0.params_.callback then
							uv0.params_.callback(uv0.params_.index, uv0.params_.heroId, 0)
						end

						uv0:Back()
					end,
					CancelCallback = function ()
					end
				})
			else
				if slot0.params_.callback then
					slot0.params_.callback(slot0.params_.index, slot0.params_.heroId, 0)
				end

				slot0:Back()
			end
		elseif not GuildActivityData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function ()
					if uv0.params_.callback then
						uv0.params_.callback(uv0.params_.index, uv0.params_.heroId, uv0.selectID_)
					end

					uv0:Back()
				end,
				CancelCallback = function ()
				end
			})
		else
			if slot0.params_.callback then
				slot0.params_.callback(slot0.params_.index, slot0.params_.heroId, slot0.selectID_)
			end

			slot0:Back()
		end
	else
		if slot0.params_.callback then
			slot0.params_.callback(slot0.params_.index, 0, slot0.selectID_)
		end

		slot0:Back()
	end
end

function slot1.GetTextAndImage(slot0)
	if slot0.params_.heroId ~= nil and slot0.params_.heroId > 0 then
		if slot0.selectID_ == slot0.params_.heroId then
			return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2", true
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0", true
		end
	else
		return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0", true
	end
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return slot1 == slot0.params_.heroId, false, -1
end

function slot1.GetDefaultHeroData(slot0)
	return slot0.heroDataList_[1].id, 0
end

function slot1.GetHeroList(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(HeroData:GetHeroList()) do
		if not slot0:IsHeroInTeam(slot7.id) or slot7.id == slot0.params_.heroId then
			slot2[slot7.id] = slot7
		end
	end

	return HeroTools.Sort(slot2)
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
end

function slot1.IsHeroInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.params_.heroList) do
		if slot7.id == slot1 then
			return true
		end
	end

	return false
end

function slot1.Dispose(slot0)
	if slot0.energyItem_ then
		slot0.energyItem_:Dispose()

		slot0.energyItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
