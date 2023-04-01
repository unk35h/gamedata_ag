slot0 = class("ObtainWeaponView", ObtainBaseView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.starControllerTrs_, "star")
	slot0.AdaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.weaponImg_.transform)
end

function slot0.Show(slot0, slot1)
	slot0.item = slot1
	slot2 = slot1.id

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	if slot1.draw_rebate and slot1.draw_rebate ~= 0 then
		SetActive(slot0.rebateGo_, true)

		slot0.rebateLab_.text = "x" .. slot1.draw_rebate
	else
		SetActive(slot0.rebateGo_, false)
	end

	if slot0.playableDirector_ then
		slot0.playableDirector_:Evaluate()
		slot0.playableDirector_:Play()
	end

	slot0:SetInfo(slot2)
end

function slot0.SetInfo(slot0, slot1)
	slot3 = WeaponServantCfg[slot1]

	if not ItemCfg[slot1] or not slot3 then
		return
	end

	slot0.weaponImg_.sprite = AssetEx.LoadSprite("Textures/WeaponServant/Portrait/" .. slot1)

	slot0.AdaptImg_:AdaptImg()

	slot0.nameText_.text = slot2.name
	slot0.camp_.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[slot3.race].icon)
	slot5 = math.min(slot2.display_rare, 5)

	slot0.starController_:SetSelectedIndex(slot5)

	if slot5 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif slot5 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end
end

function slot0.GetTimeLineEndTime(slot0)
	return 2.5
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)

	slot0.weaponImg_.sprite = nil
end

return slot0
