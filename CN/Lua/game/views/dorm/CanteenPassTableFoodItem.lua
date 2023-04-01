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
	slot0:AddUIListener()
end

function slot0.RefreshItem(slot0, slot1)
	slot0.foodEid = slot1
	slot2 = CanteenAIFunction:GetEntityData(slot1)
	slot0.foodCfgID = slot2.cfgID
	slot0.nameText_.text = string.format("<color=#%s>%s</color>", BackHomeCateenFlavor[slot2.taste].color, BackHomeCateenFlavor[slot2.taste].flavor)
	slot0.iconImg_.sprite = getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[slot0.foodCfgID].icon)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.fooditemBtn_, nil, function ()
		if uv0.btnCallBack then
			uv0.btnCallBack(uv0.foodEid)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.btnCallBack = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
