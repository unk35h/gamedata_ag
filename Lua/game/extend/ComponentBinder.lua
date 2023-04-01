slot0 = singletonClass("ComponentBinder")

function slot0.BindCfgUI(slot0, slot1, slot2)
	if slot2:GetComponent("ComponentCfger") then
		slot5 = slot3:GetComponentValues()

		for slot9 = 0, slot3:GetLuaNames().Length - 1 do
			slot1[slot4[slot9]] = slot5[slot9]
		end

		slot1.guideComponents = {}
		slot7 = slot3:GetGuideComponentValues()

		for slot11 = 0, slot3:GetGuideLuaNames().Length - 1 do
			slot1.guideComponents[slot6[slot11]] = slot7[slot11]
		end
	end
end

return slot0
