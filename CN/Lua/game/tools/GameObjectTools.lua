slot1 = 1920
slot2 = 1080

return {
	ToggleTextInverse = function (slot0, slot1, slot2)
		slot3 = slot0:FindCom(typeof(Text), "" .. slot2, slot1)
		slot3.color = Color(math.abs(255 - slot3.color.r), math.abs(255 - slot3.color.g), math.abs(255 - slot3.color.b), slot3.color.a)
	end,
	GetOrAddComponent = function (slot0, slot1)
		if slot0.GetComponent(slot0, slot1) ~= nil then
			return slot2
		else
			return slot0.AddComponent(slot0, slot1)
		end
	end,
	GetAdaptedLocalPosition = function (slot0, slot1)
		slot2 = Vector3(slot1.x, slot1.y, slot1.z)
		slot5 = manager.ui:GetCanvasSize()

		if slot0:GetComponent("RectTransform").parent:GetComponent("RectTransform").anchorMin.x == 0 and slot4.anchorMin.y == 0 and slot4.anchorMax.x == 1 and slot4.anchorMax.y == 1 and slot4.sizeDelta.x == 0 and slot4.sizeDelta.y == 0 and slot4.anchoredPosition.x == 0 and slot4.anchoredPosition.y == 0 then
			if slot3.anchorMin.x == slot3.anchorMax.x then
				slot2.x = uv0 * (0.5 - slot3.anchorMin.x) + slot2.x - slot5.x * (0.5 - slot3.anchorMin.x)
			end

			if slot3.anchorMin.y == slot3.anchorMax.y then
				slot2.y = uv1 * (0.5 - slot3.anchorMin.y) + slot2.y - slot5.y * (0.5 - slot3.anchorMin.y)
			end
		end

		return slot2
	end
}
