slot1 = class("MatrixHeroSkillUpgradeView", import("game.views.newHero.skill.HeroSkillUpgradeView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)
	SetActive(slot0.costPanelGo_, false)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot1.OnEnter(slot0)
	slot0.params_.extra = {}

	uv0.super.OnEnter(slot0)
end

function slot1.GetRealSkillId(slot0)
	return SkillTools.GetRealSkillIdByWeaponServantId(slot0.params_.heroId, slot0.params_.servantId, slot0.params_.skillId)
end

function slot1.GetSkillLv(slot0)
	return slot0.params_.lv
end

function slot1.GetHeroData(slot0)
	slot1, slot2 = GetVirtualData(slot0.params_.standardId)

	return slot1
end

return slot1
