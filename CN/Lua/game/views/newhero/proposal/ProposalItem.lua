slot0 = class("EquipProposalItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "toggle")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("", nil, function ()
		uv0.func()
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.label1Text_.text = slot1.proposal_name
	slot0.label2Text_.text = slot1.proposal_name
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 then
		slot0.controller_:SetSelectedState("on")
	else
		slot0.controller_:SetSelectedState("off")
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.func = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
