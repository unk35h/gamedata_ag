slot0 = class("PolyhedronTeamInfoSettingHead", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.emptyController = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.heroHead = NewHeroHead.New(slot0.m_head)

	slot0.heroHead:SetRedPointEnable(false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id = slot2
	slot4 = slot1:GetTeamateRebornMaxColdDown()

	if slot1:GetHeroPolyData(slot2):IsDead() then
		slot0.stateController:SetSelectedIndex(1)

		slot0.m_coldNum.text = slot4 - slot3.reborn_cold_down
	else
		slot0.stateController:SetSelectedIndex(0)
	end

	slot0.heroHead:SetHeroId(slot2, {
		isPolyhedron = true
	})
	slot0.heroHead.lockedController_:SetSelectedState("false")

	slot0.heroHead.levelText_.text = tostring(slot0.heroHead.heroInfo_.level or 1)

	slot0.heroHead.gradeController_:SetSelectedState(HeroStarCfg[slot0.heroHead.heroInfo_.star].star)
end

function slot0.SetFightData(slot0, slot1, slot2)
	slot0.id = slot2
	slot3 = slot1:GetHeroPolyData(slot2)
	slot4 = slot1:GetTeamateRebornMaxColdDown()

	if slot2 == nil or slot2 == 0 then
		slot0.emptyController:SetSelectedIndex(1)

		return
	else
		slot0.emptyController:SetSelectedIndex(0)
	end

	if slot3:IsDead() then
		slot0.m_coldNum.text = slot4 - slot3.reborn_cold_down

		slot0.stateController:SetSelectedIndex(4)
	elseif slot1:GetLeaderHeroId() == slot2 then
		slot0.stateController:SetSelectedIndex(2)
	else
		slot0.stateController:SetSelectedIndex(3)
	end

	slot0.heroHead:SetHeroId(slot2, {
		isPolyhedron = true
	})
	slot0.heroHead.lockedController_:SetSelectedState("false")

	slot0.heroHead.levelText_.text = tostring(slot0.heroHead.heroInfo_.level or 1)

	slot0.heroHead.gradeController_:SetSelectedState(HeroStarCfg[slot0.heroHead.heroInfo_.star].star)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	slot0.heroHead:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
