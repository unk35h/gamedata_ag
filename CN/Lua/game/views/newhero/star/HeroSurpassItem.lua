slot0 = class("HeroSurpassItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = slot2
	slot0.id = HeroStarCfg.all[slot0.index]
	slot0.callBack = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.des = slot0:FindCom(typeof(Text), "text")

	if HeroStarCfg[slot0.id].phase == 0 then
		slot0.des.text = slot1.name
	end
end

function slot0.AddUIListener(slot0)
	slot0.btn_ = slot0:FindCom(typeof(Button), "")

	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.callBack then
			uv0.callBack(uv0.index, true)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	if slot0.id == HeroCfg[slot2].unlock_star then
		slot0.btn_.interactable = false
	else
		slot0.btn_.interactable = true
	end

	if slot1 + 1 > #HeroStarCfg.all then
		slot0.stateController:SetSelectedIndex(0)
	elseif slot0.index == slot5 then
		slot0.stateController:SetSelectedIndex(1)
	elseif slot0.index < slot5 then
		slot0.stateController:SetSelectedIndex(0)
	else
		slot0.stateController:SetSelectedIndex(2)
	end
end

function slot0.SetChoice(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.index and 1 or 0)
end

return slot0
