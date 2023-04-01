slot0 = class("DormRecommendSmallItem", ReduxView)

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

function slot0.RefreshUI(slot0, slot1, slot2)
	if slot1.type == 1 then
		for slot7, slot8 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot8[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot8[3])
			end
		end
	elseif slot3 == 2 then
		for slot7, slot8 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if slot8[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/CampItem", slot8[3])
			end
		end
	elseif slot3 == 3 then
		for slot7, slot8 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
			if slot8[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot8[3])
			end
		end
	elseif slot3 == 4 then
		for slot7, slot8 in ipairs(GameDisplayCfg.hero_mechanism_type_tag.value) do
			if slot8[1] == slot1.tag then
				slot0.recIcon_.sprite = getSprite("Atlas/Hero", slot8[3])
			end
		end
	end

	for slot9, slot10 in ipairs(CanteenData:GetEntrustByPos(CanteenData:GetCurDispatchTask().pos).tags) do
		if slot10.type == slot3 and slot10.tag == slot1.tag then
			slot0.statusController_:SetSelectedState("lightup")

			return
		end
	end

	slot0.statusController_:SetSelectedState("normal")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
