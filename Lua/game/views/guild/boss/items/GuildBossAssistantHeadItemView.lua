slot0 = class("GuildBossAssistantHeadItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockedController_ = ControllerUtil.GetController(slot0.headGo_.transform, "locked")
	slot0.campController_ = ControllerUtil.GetController(slot0.headGo_.transform, "camp")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.headGo_.transform, "grade")
	slot0.sizeController_ = ControllerUtil.GetController(slot0.headGo_.transform, "size")
	slot0.hpController_ = ControllerUtil.GetController(slot0.headGo_.transform, "hp")
	slot0.selectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selected")
	slot0.positionController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "position")
	slot0.loveCon_ = ControllerUtil.GetController(slot0.headGo_.transform, "love")

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.headGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_()
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1
	slot0.heroCfg_ = HeroCfg[slot0.data_.assist_hero_id]

	slot0:UpdateView()
end

function slot0.SetTeamMark(slot0, slot1, slot2)
	SetActive(slot0.teamMark_, slot1)

	if slot1 then
		slot0.teamMarkText_.text = slot2
	end
end

function slot0.GetHeroId(slot0)
	return slot0.data_.assist_hero_id
end

function slot0.GetOwnerId(slot0)
	return slot0.data_.member_id
end

function slot0.UpdateView(slot0)
	if slot0.data_.assist_hero_skin == 0 then
		slot1 = slot0.data_.assist_hero_id
	end

	slot0.nickLabel_.text = slot0.data_.nick
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot1)

	slot0.headIcon_:SetNativeSize()
	slot0.campController_:SetSelectedState(slot0.heroCfg_.race)
	slot0.gradeController_:SetSelectedState(HeroStarCfg[slot0.data_.hero_rare].star)

	slot0.levelText_.text = slot0.data_.hero_level
	slot0.fightPowerLabel_.text = slot0.data_.fight_capacity

	slot0.positionController_:SetSelectedState(tostring(slot0.data_.member_post))
	slot0.loveCon_:SetSelectedState("off")
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil
	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
