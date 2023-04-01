slot0 = class("DormRecommendClassItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.listFlag = false

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemController = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setupBtn_, nil, function ()
		if uv0.changeListFun then
			uv0.changeListFun(uv0.ID_, uv0.transform_)
		else
			print("餐品食材不足")
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = BackHomeCanteenFoodCfg[slot1]
	slot0.ID_ = slot3.id
	slot0.priceText_.text = slot3.sell
	slot0.titleText_.text = slot3.name

	if slot2 == "foodScroll" then
		slot0.canCookNum = CanteenData:CalculateFoodCanCookNum(slot1)

		if slot0.canCookNum <= 0 then
			slot0.itemController:SetSelectedState("uncook")

			return
		end

		slot6 = CanteenData
		slot8 = slot6

		for slot7, slot8 in ipairs(slot6.GetChooseFoodList(slot8)) do
			if slot1 == slot8 then
				slot0.itemController:SetSelectedState("ison")

				return
			end
		end

		slot0.itemController:SetSelectedState("down")
	elseif slot2 == "chooseItemScroll" then
		slot0.itemController:SetSelectedState("on")

		return
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
