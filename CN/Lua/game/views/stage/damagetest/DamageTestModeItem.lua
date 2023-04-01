slot0 = class("DamageTestModeItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "chooseItem")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.index_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0:SetSelectMode(slot0.index_ == slot1)
end

function slot0.SetSelectMode(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState("on")
	else
		slot0.selectController_:SetSelectedState("off")
	end
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

return slot0
