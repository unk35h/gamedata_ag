slot0 = class("todayMenuItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.listFlag = false

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setdownBtn_, nil, function ()
		JumpTools.OpenPageByJump("/popFoodDownView", {
			foodID = uv0.ID_
		})
	end)
	slot0:AddBtnListener(slot0.shelvesbtnBtn_, nil, function ()
		CanteenAction:SendSignFoodInfo(uv0.ID_, 0)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.ID_ = slot1
	slot0.titleText_.text = BackHomeCanteenFoodCfg[slot1].name
	slot3 = BackHomeCanteenFoodCfg[slot1].ingredient_list
	slot0.foodiconImg_.sprite = CanteenTools.GetFoodSprite(slot0.ID_)
	slot0.awardnumText_.text = CanteenData:GetSignFoodInfo(slot1).soldIncome or 0
	slot0.timeText_.text = DormTools:SecondSwitchTime(CanteenData:GetSignFoodTime(slot0.ID_))
	slot5 = ""
	slot6 = GetTips("CANTEEN_FOOD_COST")

	for slot10, slot11 in ipairs(slot3) do
		slot12 = ItemCfg[slot11[1]].name
		slot5 = CanteenData:GetCateenIngredient()[slot11[1]] < slot11[2] and slot5 .. string.format("<color='#FF0000'>%s%d/%d</color>,", slot12, slot14, slot13) or slot5 .. string.format("<color='#FF0000'>%s%d/%d</color>,", slot12, slot14, slot13) .. string.format("%s%d/%d,", slot12, slot14, slot13)
	end

	slot0.materialtextText_.text = string.sub(string.format(slot6, slot5), 1, -2)
	slot7 = CanteenData:GetSignFoodInfo(slot0.ID_)
	slot0.soldNumText_.text = slot7.soldNum
	slot0.sellNumText_.text = "/" .. slot7.sellNum

	if slot7.sellNum == slot7.soldNum then
		slot0.canvasGroup.alpha = GameDisplayCfg.canteen_canteen_food_item_diaphaneity.value[1]

		slot0.stateController:SetSelectedState("sellout")
	else
		slot0.canvasGroup.alpha = 1

		slot0.stateController:SetSelectedState("normal")
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
