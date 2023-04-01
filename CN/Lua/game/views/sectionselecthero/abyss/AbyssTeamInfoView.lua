slot1 = class("AbyssTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.LockSorter))
end

function slot1.OnEnter(slot0)
	slot0.abandonList_ = AbyssData:GetAbandonHeroList()
	slot0.lockList_ = AbyssData:GetLockedHeroList(slot0.params_.layerId)

	uv0.super.OnEnter(slot0)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	slot3 = slot0.heroDataList_[slot1].id
	slot5, slot6, slot7 = slot0:IsInTeam(slot3, slot0.heroDataList_[slot1].trialID)
	slot8 = AbyssData:IsHeroInLockList(slot3, slot0.lockList_)

	if AbyssData:IsHeroInLockList(slot3, slot0.abandonList_) > 0 then
		slot2:SetHeroLock(true)
		slot2:SetHeroLockType("abyss_abandon")
	elseif slot8 > 0 then
		slot2:SetHeroLock(true)
		slot2:SetHeroLockType("abyss_lock")
	else
		slot2:SetHeroLock(false)
	end

	slot2.lockImage_:SetNativeSize()
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot2.lockContainer_)
	slot2:SetInTeamFlag(slot5)
end

function slot1.LockSorter(slot0, slot1, slot2, slot3, slot4)
	slot5 = AbyssData:IsHeroInLockList(slot1.id, slot0.lockList_) > 0 and 1 or 0
	slot6 = AbyssData:IsHeroInLockList(slot2.id, slot0.lockList_) > 0 and 1 or 0

	if (AbyssData:IsHeroInAbandonList(slot1.id, slot0.abandonList_) > 0 and 1 or 0) ~= (AbyssData:IsHeroInAbandonList(slot2.id, slot0.abandonList_) > 0 and 1 or 0) then
		return true, slot7 < slot8
	end

	if slot5 ~= slot6 then
		return true, slot5 < slot6
	end
end

function slot1.ChangeTeam(slot0, slot1, slot2, slot3)
	AbyssData:SetHeroTeam(slot0.params_.stageID, slot1)
	ComboSkillData:SetNeedRefresh(slot3)
end

function slot1.GetTextAndImage(slot0)
	if AbyssData:IsHeroInAbandonList(slot0.selectID_, slot0.abandonList_) > 0 then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if AbyssData:IsHeroInLockList(slot0.selectID_, slot0.lockList_) > 0 then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	return uv0.super.GetTextAndImage(slot0)
end

function slot1.GetHeroTeam(slot0)
	slot0.heroTeam_ = AbyssData:GetCanUseCachedHero(slot0.params_.stageID, slot0.params_.layerId)
	slot0.lockStateList_ = {
		false,
		false,
		false
	}
	slot0.lockHeroList_ = {}
	slot0.heroTrialList_ = {
		0,
		0,
		0
	}
end

return slot1
