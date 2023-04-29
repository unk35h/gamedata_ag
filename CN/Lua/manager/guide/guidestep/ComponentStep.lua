slot0 = class("ComponentStep", BaseStep)

function slot0.Init(slot0, slot1)
	slot2 = GuideStepCfg[slot0._stepId]
	slot0._guideComponentCfg = slot2.guide_component
	slot0._maskComponentCfg = slot2.mask_component

	if slot2.mask_scale == "" then
		slot0._maskScale = Vector3.New(1, 1, 1)
	else
		slot0._maskScale = Vector3.New(slot2.mask_scale[1] or 1, slot2.mask_scale[2] or 1, 1)
	end

	slot0._talkContent = slot2.talk_content
	slot0._talkAnchors = slot2.talk_anchors
	slot0._talkPosition = slot2.talk_position == "" and {} or slot2.talk_position
	slot0._talkAdapt = slot2.talk_adapt
end

function slot0.OnStepEnd(slot0)
	uv0.super.OnStepEnd(slot0)

	slot0._component = nil
end

function slot0.Check(slot0)
	return slot0:Component() ~= nil
end

function slot0.GetShowMask(slot0)
	return true
end

function slot0.Play(slot0)
	manager.guide.view:Init()

	slot2, slot3 = slot0._guide:GetNarratorInfo()

	manager.guide.view:ShowTalk(slot0._talkContent, slot0._talkAnchors, slot0._talkPosition, slot2, slot3, slot0._talkAdapt)
	manager.guide.view:ShowHoldMask(slot0:AnalyzeComponentCfg(slot0._maskComponentCfg) and slot4.gameObject or slot0:Component().gameObject, slot0._maskScale)
end

function slot0.Component(slot0)
	if slot0._component == nil then
		slot0._component = slot0:AnalyzeComponentCfg(slot0._guideComponentCfg)
	end

	return slot0._component
end

function slot0.AnalyzeComponentCfg(slot0, slot1)
	if slot1 == "" or #slot1 == 0 then
		return nil
	end

	slot3 = string.split(slot1[1], "_")
	slot5 = slot3[2] and slot3[2] == "getcom"

	if slot3[1] == "common" then
		slot8 = slot1[4]

		if slot0:GetViewComponent(slot1[2], slot1[3]) and slot5 then
			return slot9:GetComponent(slot8)
		end

		return slot9
	elseif slot4 == "child" then
		slot8 = slot1[4]
		slot9 = slot1[5]

		if slot0:GetViewComponent(slot1[2], slot1[3]) then
			if slot10.transform:Find(slot8) and slot5 then
				return slot11:GetComponent(slot9)
			end

			return slot11
		end
	elseif slot4 == "listIndex" then
		slot8 = slot1[4]
		slot9 = slot1[5]
		slot10 = slot1[6]

		if slot0:GetViewComponent(slot1[2], slot1[3]) and slot11:GetItemList() and slot12[slot8] then
			if slot0:GetComponentPath(slot12[slot8], slot9) and slot5 then
				return slot13:GetComponent(slot10)
			end

			return slot13
		end
	elseif slot4 == "windowBar" then
		if manager.windowBar:GetIsShow() then
			return manager.windowBar[slot1[2]]
		end

		return nil
	elseif slot4 == "windowBarCurrency" then
		if manager.windowBar:GetIsShow() then
			slot8 = slot1[3]
			slot9 = slot1[4]

			if manager.windowBar.barGo_[slot1[2]] then
				if slot0:GetComponentPath(slot7, slot8) and slot5 then
					return slot10:GetComponent(slot9)
				end

				return slot10
			end
		end

		return nil
	elseif slot4 == "messageBox" then
		if manager.messageBox:GetItemList() then
			for slot10, slot11 in pairs(slot6) do
				if not slot11:IsFree() then
					return slot11[slot1[2]]
				end
			end
		end

		return nil
	elseif slot4 == "treeGroup" then
		slot8 = slot1[4]

		if slot0:GetViewComponent(slot1[2], slot1[3]) and slot9:GetGroupGameObjectById(slot8) and slot10:GetComponent("UITreeGroup") then
			return slot11.toggle
		end
	elseif slot4 == "treeItem" then
		slot8 = slot1[4]
		slot9 = slot1[5]

		if slot0:GetViewComponent(slot1[2], slot1[3]) and slot10:GetItemGameObjectById(slot8, slot9) and slot11:GetComponent("UITreeItem") then
			return slot12.toggle
		end
	else
		error("guide unknown way to get component" .. slot4)
	end
end

function slot0.GetViewComponent(slot0, slot1, slot2)
	if gameContext:GetOpenPageHandler(slot1) then
		return slot0:GetComponentPath(slot3, slot2)
	end

	return nil
end

function slot0.GetComponentPath(slot0, slot1, slot2)
	slot3 = #slot2
	slot4 = 1
	slot5 = nil

	while slot4 <= slot3 do
		slot6 = slot2[slot4]
		slot7 = nil

		if (slot4 ~= 1 or slot1[slot6]) and slot5[slot6] then
			slot5 = slot7
			slot4 = slot4 + 1
		else
			return nil
		end
	end

	return slot5
end

return slot0
