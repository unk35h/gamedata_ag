slot0 = class("RestaurantCookConditionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.conditionController = ControllerUtil.GetController(slot0.tickTrs_, "state")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0.stateController:SetSelectedState("skill")

		if not slot1 then
			slot0.skillText_.text = ""

			return
		end

		if BackHomeHeroSkillCfg[slot1] then
			slot0.skillText_.text = DormSkillData:GetSkillDesc(slot1)
		else
			print("传入技能id错误")
		end
	elseif slot2 == 2 then
		slot0.stateController:SetSelectedState("condition")

		if not slot1 then
			slot0.conditionText_.text = ""

			return
		end

		if ConditionCfg[slot1] then
			slot0.conditionText_.text = CanteenTools:GetConditionDes(slot1)

			if CanteenTools:CheckConditionAccord(slot1) then
				slot0.conditionController:SetSelectedState("true")
			else
				slot0.conditionController:SetSelectedState("false")

				if slot0.conFunc then
					slot0.conFunc(false)
				else
					print("未注册升级条件方法")
				end
			end
		end
	end
end

function slot0.UpdataCondition(slot0, slot1)
	if slot1 then
		slot0.conFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
