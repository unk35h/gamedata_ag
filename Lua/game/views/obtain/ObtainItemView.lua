slot0 = class("ObtainItemView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.starControllerTrs_, "star")
	slot0.effect_ = slot0:FindCom("Effect_distortion_add", "", slot0.rareEffect_)
end

function slot0.SetInfo(slot0, slot1)
	if not ItemCfg[slot1] then
		return
	end

	slot0.iconImage_.sprite = ItemTools.getItemSprite(slot1)
	slot0.itemName_.text = slot2.name
	slot3 = math.min(slot2.display_rare, 5)

	slot0.starController_:SetSelectedIndex(slot3)

	if slot3 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot3 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	slot4 = slot2.display_rare or 0
	slot5 = nil
	slot5 = (slot4 > 3 or Color.New(0.2588235, 0.6078432, 1)) and (slot4 ~= 4 or Color.New(0.9333333, 0, 1)) and Color.New(1, 0.7411765, 0.1764706)
	slot0.nameBg_.color = slot5
	slot0.effect_._MainColor = slot5
end

function slot0.GetTimeLineEndTime(slot0)
	return 0.8
end

return slot0
