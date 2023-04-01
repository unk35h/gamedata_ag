slot1 = class("NewHeroAstrolabePage", import("game.views.newHero.NewHeroPageBase"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.isHaveController_ = ControllerUtil.GetController(slot0.transform_, "ishave")
	slot0.isForeignController_ = ControllerUtil.GetController(slot0.transform_, "isforeign")

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.changebtn_, nil, function ()
		uv0:Go("/heroChipView", {
			HeroId = uv0.heroInfo_.id
		})
	end)
end

function slot1.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp

	if slot1 and slot1.isPolyhedron then
		slot0.extra_ = nil
	end
end

function slot1.OnTop(slot0)
	slot0:UpdateNotice()
end

function slot1.UpdateNotice(slot0)
	manager.redPoint:bindUIandKey(slot0.redpointTrans_, string.format("%s", slot0.heroInfo_.id))
end

function slot1.UpdateView(slot0)
	if slot0.extra_ then
		slot0.isForeignController_:SetSelectedState("true")

		if slot0.heroInfo_.using_hero_chip and slot1[1] and slot1[1] > 0 then
			slot0.isHaveController_:SetSelectedState("true")

			slot2 = ChipCfg[slot1[1]]
			slot0.skillimage_.sprite = getSpriteViaConfig("ChipSkillIcon", slot2.picture_id)
			slot0.skillname_.text = slot2.suit_name
			slot0.skilltext_.text = slot2.desc
		else
			slot0.isHaveController_:SetSelectedState("false")
		end
	else
		slot0.isForeignController_:SetSelectedState("false")

		if ChipData:GetEnableHeroChipIdByHeroId(slot0.heroInfo_.id) and slot1[1] > 0 then
			slot0.isHaveController_:SetSelectedState("true")

			slot2 = ChipCfg[slot1[1]]
			slot0.skillimage_.sprite = getSpriteViaConfig("ChipSkillIcon", slot2.picture_id)
			slot0.skillname_.text = slot2.suit_name
			slot0.skilltext_.text = slot2.desc
		else
			slot0.isHaveController_:SetSelectedState("false")
		end

		slot0:UpdateNotice()
	end
end

function slot1.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.redpointTrans_)
end

function slot1.SetHeroInfo(slot0, slot1)
	if slot0.extra_ then
		if slot0.isForeign_ then
			slot0.heroInfo_ = ForeignInfoData:GetHeroInfo(slot1.id)
		end
	else
		slot0.heroInfo_ = HeroData:GetHeroData(slot1.id)
	end

	slot0:UpdateView()
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot1
