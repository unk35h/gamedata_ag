slot0 = class("ChooseFoodMaterialItem", ReduxView)

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

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.nameText_.text = ItemCfg[slot1].name
	slot4 = {}

	for slot8, slot9 in ipairs(BackHomeCanteenFoodCfg[slot2].ingredient_list) do
		if slot9[1] == slot1 then
			slot4 = slot9[2]

			break
		end
	end

	slot5 = slot4
	slot6 = CanteenData:GetCateenIngredient()[slot1]
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
