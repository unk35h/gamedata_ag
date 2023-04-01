slot0 = class("CanteenSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot4 = 0

	if slot3 == 1 then
		slot4 = GameSetting.dorm_hero_skill_unlock.value[1]
	elseif slot3 == 2 then
		slot4 = GameSetting.dorm_hero_skill_unlock.value[2]
	end

	slot0.lockController:SetSelectedState("unlock")

	slot0.iconskillImg_.sprite = CanteenTools.GetCanteenSkillSprite(slot1)
	slot0.skillDec_.text = DormSkillData:GetSkillDesc(slot1)
	slot0.skillName_.text = BackHomeHeroSkillCfg[slot1].name

	if slot2 < slot4 then
		slot0.lockController:SetSelectedState("lock")

		slot0.unLockConText_.text = string.format(GetTips("DORM_CANTEEN_UNLOCK"), slot4)

		return
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
