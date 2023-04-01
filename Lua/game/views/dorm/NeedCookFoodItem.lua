slot0 = class("NeedCookFoodItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.itemController = ControllerUtil.GetController(slot0.transform_, "food")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = BackHomeCanteenFoodCfg[slot1]

	if CanteenData:GetSignFoodCanCookNum(slot1) > 0 then
		slot0.itemController:SetSelectedState("on")

		slot0.foodtextText_.text = slot2.name
	else
		slot0.itemController:SetSelectedState("off")

		slot0.foodnameText_.text = slot2.name
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
