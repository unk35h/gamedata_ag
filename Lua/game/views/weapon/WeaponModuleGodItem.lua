slot0 = class("WeaponModuleGodItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statucontroller_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.selectcontroller_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.selectCallBack_ then
			uv0.selectCallBack_(uv0.index_)
		end
	end)
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1

	if slot0.index_ == slot2 then
		slot0.selectcontroller_:SetSelectedState("true")
	else
		slot0.selectcontroller_:SetSelectedState("false")
	end

	slot4 = HeroAstrolabeCfg[slot3]
	slot0.nameText_.text = slot4.suit_name .. "·" .. slot4.name
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.selectCallBack_ = nil
end

return slot0
