slot0 = class("FoodMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshItem(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1[1]
	slot0.num = slot1[2]
	slot0.textText_.text = ItemCfg[slot0.id].name
	slot0.costNumText_.text = slot0.num

	if slot4 == DormEnum.FoodSellType.SignFood then
		slot0.hadNumText_.text = ""
	else
		slot0.hadNumText_.text = "/" .. CanteenData:GetCateenIngredientNum(slot0.id)
	end

	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.id)

	if slot2 then
		slot6 = 0

		for slot10, slot11 in ipairs(BackHomeCanteenFoodCfg[slot2].ingredient_list) do
			if slot11[1] == slot0.id then
				slot6 = slot11[2]
			end
		end

		slot0.costNumText_.text = slot6 * slot3
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.btnCallBack = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
