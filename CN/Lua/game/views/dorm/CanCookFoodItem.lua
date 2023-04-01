slot0 = class("CanCookFoodItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.listFlag = false
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cookbtnBtn_, nil, function ()
		if uv0.chooseFoodFunc then
			uv0.chooseFoodFunc(uv0.ID_, uv0.Index_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.ID_ = slot1.uid
	slot0.Index_ = slot1.index
	slot0.nameText_.text = DormFoodConfig[slot1.uid].name
	slot0.taste1Text_.text = DormData:SwitchTaste(DormFoodConfig[slot1.uid].tasteType[1])
	slot0.taste2Text_.text = DormData:SwitchTaste(DormFoodConfig[slot1.uid].tasteType[2])
	slot0.costText_.text = DormFoodConfig[slot1.uid].cost
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.chooseFoodFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
