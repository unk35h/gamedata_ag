slot0 = class("DormRecommendBigItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	if slot1.type == 1 then
		for slot6, slot7 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot7[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot7[3])
			end
		end
	elseif slot2 == 2 then
		for slot6, slot7 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if slot7[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/CampItem", slot7[3])
			end
		end
	elseif slot2 == 3 then
		for slot6, slot7 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
			if slot7[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot7[3])
			end
		end
	elseif slot2 == 4 then
		for slot6, slot7 in ipairs(GameDisplayCfg.hero_mechanism_type_tag.value) do
			if slot7[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot7[3])
			end
		end
	end

	slot4 = false

	for slot8, slot9 in ipairs(CanteenData:GetDispatchCharacterList()) do
		if CanteenTools:CheckHeroConcertTag(slot9, slot1.type, slot1.tag) then
			slot4 = true

			break
		end
	end

	if slot4 then
		slot0.statusController_:SetSelectedState("lightup")
	else
		slot0.statusController_:SetSelectedState("normal")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
