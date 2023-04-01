slot0 = class("polyhedronBattleHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.SetData(slot0, slot1, slot2)
	if slot2 == 0 then
		slot0.stateController:SetSelectedIndex(4)
	else
		slot3 = slot1:GetLeaderHeroId()

		if slot1:GetHeroPolyData(slot2):IsDead() then
			slot0.stateController:SetSelectedIndex(2)
		elseif slot3 == slot2 then
			slot0.stateController:SetSelectedIndex(1)
		else
			slot0.stateController:SetSelectedIndex(0)
		end

		slot0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", slot2)
	end
end

return slot0
