slot0 = class("BirtndaySettingItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.text_.text = slot1
	slot0.bigText_.text = slot1

	slot0.controller:SetSelectedState(slot1 == slot2 and "on" or "off")
end

return slot0
