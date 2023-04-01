slot0 = class("WeaponBreakView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Weapon/WeaponBreakSuccess"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshBreakSuccess(slot0.params_.heroID, slot0.params_.breakthrough)
end

function slot0.OnExit(slot0)
end

function slot0.RefreshBreakSuccess(slot0, slot1, slot2)
	slot3 = GameSetting.weapon_exp_limit.value[slot2 + 1]
	slot5, slot0.crioriText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot2 + 1])
	slot0.crinameText_.text, slot0.criafterText_.text = SkillTools.GetAttr(HeroCfg[slot1].weapon_break_attribute[slot2 + 2])
	slot0.desctextText_.text = GameSetting.weapon_exp_limit.value[slot2 + 2]
	slot0.atkoriText_.text = string.format("%d", WeaponTools.WeaponAtk(slot3, slot2))
	slot0.atkafterText_.text = string.format("%d", WeaponTools.WeaponAtk(slot3, slot2 + 1))
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
