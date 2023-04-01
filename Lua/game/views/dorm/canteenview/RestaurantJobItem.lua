slot0 = class("RestaurantJobItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.fatigueController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "fatigue")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.refreshbtnBtn_, nil, function ()
		if uv0.changeHero then
			uv0.changeHero(uv0.heroID, uv0.jobID)
		end
	end)
	slot0:AddBtnListenerScale(slot0.clickBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.jobID)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.jobID = slot1.jobID

	if slot0.jobID then
		if slot0.jobID == 1 then
			slot0.jobText_.text = GetTips("DORM_CANTEEN_COOK")
		elseif slot0.jobID == 2 then
			slot0.jobText_.text = GetTips("DORM_CANTEEN_WAITER")
		elseif slot0.jobID == 3 then
			slot0.jobText_.text = GetTips("DORM_CANTEEN_CASHIER")
		end

		if not slot1.heroID then
			slot0.stateController_:SetSelectedState("no")
			slot0.fatigueController_:SetSelectedState("full")

			return
		end

		slot0.heroID = slot1.heroID

		if slot0.jobID == slot2 then
			slot0.stateController_:SetSelectedState("select")
		else
			slot0.stateController_:SetSelectedState("normal")
		end

		if DormData:GetHeroFatigue(slot0.heroID) < GameDisplayCfg.canteen_fatigue_red_warning.value[1] then
			slot0.fatigueController_:SetSelectedState("lack")
		else
			slot0.fatigueController_:SetSelectedState("full")
		end

		slot0.iconImg_.sprite = HeroTools.GetBackHomeFullModelFowardSprite(slot0.heroID)
		slot0.nameText_.text = HeroCfg[slot0.heroID].suffix
	else
		print("未传入职业类型")
	end
end

function slot0.ChangeJobCallBack(slot0, slot1)
	if slot1 then
		slot0.changeHero = slot1
	end
end

function slot0.ClickItemCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
