slot0 = class("TeachStageSwitchBtn", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.switchType_ = slot2

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.InitUI(slot0)
	slot0.btn_ = slot0:FindCom(typeof(CToggle), "")
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.btn_, function (slot0)
		if slot0 then
			BattleTeachData:SetSwitchType(uv0.switchType_)
			uv0:Go("teachStage", {
				switchType = uv0.switchType_
			})
			manager.notify:CallUpdateFunc(CLICK_TEACH_BTN)
		end
	end)
end

function slot0.IsOn(slot0)
	slot0.btn_.isOn = true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.btn_ = nil
	slot0.switchType_ = nil
	slot0.btn_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
