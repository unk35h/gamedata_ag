slot0 = class("CookFoodItem", ReduxView)

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

	slot0.itemController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buttonBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.uid_)
		end
	end)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.uid_ = slot1.id

	if slot1.type == DormEnum.UniversalUIType.FoodName then
		if slot1.id == slot2 then
			slot0.itemController:SetSelectedState("choose")
		else
			slot0.itemController:SetSelectedState("unchoose")
		end

		slot0.nameText_.text = BackHomeCanteenFoodCfg[slot0.uid_].name
	elseif slot1.type == DormEnum.UniversalUIType.TasteName then
		if slot1.id == slot2 then
			slot0.itemController:SetSelectedState("choose")
		else
			slot0.itemController:SetSelectedState("unchoose")
		end

		slot0.nameText_.text = BackHomeCateenFlavor[slot1.id].flavor
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
