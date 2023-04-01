return {
	SetButtonEnable = function (slot0, slot1)
		if ControllerUtil.GetController(slot0.gameObject.transform, "enabled") ~= nil then
			slot2:SetSelectedState(slot1 and "true" or "false")
		end

		slot0.GetComponent(slot0, typeof(Button)).enabled = slot1
	end
}
