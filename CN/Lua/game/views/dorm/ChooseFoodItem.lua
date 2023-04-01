slot0 = class("ChooseFoodItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setupBtn_, nil, function ()
		if uv0.changeListFun then
			if uv0.flag then
				uv0.changeListFun(uv0.ID_, uv0.transform_)
			else
				ShowTips(GetTips("DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH"))
			end
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = BackHomeCanteenFoodCfg[slot1]
	slot0.ID_ = slot2.id
	slot0.titleText_.text = slot2.name
	slot0.priceText_.text = CanteenData:GetFoodUnitCost(slot2.id)
	slot0.iconImg_.sprite = CanteenTools.GetFoodSprite(slot0.ID_)
	slot4 = ""
	slot0.flag = true
	slot5 = GetTips("CANTEEN_FOOD_COST")

	for slot9, slot10 in ipairs(BackHomeCanteenFoodCfg[slot1].ingredient_list) do
		slot11 = ItemCfg[slot10[1]].name

		if CanteenData:GetCateenIngredientNum(slot10[1]) < slot10[2] then
			slot0.flag = false
			slot4 = slot4 .. string.format("<color='#FF0000'>%s%d/%d</color>,", slot11, slot13, slot12)
		else
			slot4 = slot4 .. string.format("%s%d/%d,", slot11, slot13, slot12)
		end
	end

	slot0.materialtextText_.text = string.sub(string.format(slot5, slot4), 1, -2)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.RegisterLackCallBack(slot0, slot1)
	slot0.lackBtnFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
