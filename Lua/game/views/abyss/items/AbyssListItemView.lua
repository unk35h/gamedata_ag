slot0 = class("AbyssListItemView", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.status2Controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status2")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.onClick_ ~= nil then
			uv0.onClick_(uv0.id_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.onClick_ = slot3
	slot0.id_ = slot2
	slot0.cfg_ = AbyssCfg[slot2]

	slot0:UpdateView()
end

function slot0.SetSelect(slot0, slot1)
	slot0.statusController_:SetSelectedState(slot1 and "Select" or "normal")
end

function slot0.UpdateView(slot0)
	slot0.scoreLabel_.text = AbyssData:GetLayerScore(slot0.id_)
	slot0.layerLabel_.text = string.format(GetTips("ABYSS_LAYER_LABEL"), slot0.index_)

	if AbyssData:GetLayerStatus(slot0.id_) == 0 then
		slot0.status2Controller_:SetSelectedState("lock")
	elseif slot1 == 1 then
		slot0.status2Controller_:SetSelectedState("normal")
	elseif slot1 == 2 then
		slot0.status2Controller_:SetSelectedState("Challenge")
	else
		slot0.status2Controller_:SetSelectedState("Select")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
