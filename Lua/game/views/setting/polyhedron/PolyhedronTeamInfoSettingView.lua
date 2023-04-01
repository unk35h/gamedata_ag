slot0 = class("PolyhedronTeamInfoSettingView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
	slot0:RefreshSettingUI()

	slot0.handler_ = handler(slot0, slot0.RefreshSettingUI)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, slot0.handler_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fightHeroList = LuaList.New(handler(slot0, slot0.IndexFightHeroItem), slot0.m_fightHeroList, PolyhedronTeamInfoSettingHead)
	slot0.heroList = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.m_heroList, PolyhedronTeamInfoSettingHead)
	slot0.comboController_ = ControllerUtil.GetController(slot0.m_comboSkillBtn.transform, "name")
	slot0.campController_ = ControllerUtil.GetController(slot0.m_campAddBtn.transform, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_campAddBtn, nil, function ()
		JumpTools.OpenPageByJump("polyhedronCampAddPop", {
			heroIdList = uv0.fightHeroArray
		})
	end)
	slot0:AddBtnListener(slot0.m_comboSkillBtn, nil, function ()
		JumpTools.OpenPageByJump("comboSkillSelect", {
			stageID = 0,
			stageType = BattleConst.STAGE_TYPE_NEW.POLYHEDRON,
			activityID = PolyhedronData:GetActivityID(),
			heroList = uv0.fightHeroArray,
			trialList = {},
			comboSkillID = uv0:GetComboSkillID()
		})
	end)
end

function slot0.GetComboSkillID(slot0)
	return BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID())
end

function slot0.RefreshSettingUI(slot0)
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.fightHeroArray = slot0.polyhedronInfo:GetFightHeroList()
	slot0.heroArray = {}

	for slot5, slot6 in ipairs(slot0.polyhedronInfo:GetHeroList()) do
		if not table.indexof(slot0.fightHeroArray, slot6) then
			table.insert(slot0.heroArray, slot6)
		end
	end

	slot0.fightHeroList:StartScroll(3)
	slot0.heroList:StartScroll(#slot0.heroArray)
	slot0.comboController_:SetSelectedIndex(slot0:GetComboSkillID() ~= 0 and 1 or 0)

	slot3, slot4, slot5 = PolyhedronTools.GetRaceEffect(slot0.fightHeroArray)

	slot0.campController_:SetSelectedIndex(slot4 and 1 or 0)
end

function slot0.IndexFightHeroItem(slot0, slot1, slot2)
	slot2:SetFightData(slot0.polyhedronInfo, slot0.fightHeroArray[slot1])
	slot2:RegistCallBack(function (slot0)
		uv0:FightHeroClick(slot0)
	end)
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot2:SetData(slot0.polyhedronInfo, slot0.heroArray[slot1])
	slot2:RegistCallBack(function (slot0)
		uv0:HeroClick(slot0)
	end)
end

function slot0.FightHeroClick(slot0, slot1)
	if slot0.polyhedronInfo:GetLeaderHeroId() == slot1 or slot1 == 0 then
		return
	end

	if table.indexof(clone(slot0.fightHeroArray), slot1) then
		table.remove(slot2, slot3)
		PolyhedronAction.QuerySwitchTeamHero(slot2)
	end
end

function slot0.HeroClick(slot0, slot1)
	slot2 = slot0.polyhedronInfo:GetHeroPolyData(slot1)

	if #slot0.fightHeroArray >= 3 then
		ShowTips("POLYHEDRON_TEAM_SET_FULL")

		return
	end

	if slot2:IsDead() then
		ShowTips("POLYHEDRON_TEAM_SET_DEAD")

		return
	end

	slot3 = clone(slot0.fightHeroArray)

	table.insert(slot3, slot1)
	PolyhedronAction.QuerySwitchTeamHero(slot3)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil

	ComboSkillData:SetNeedRefresh(true)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, slot0.handler_)

	slot0.handler_ = nil
end

function slot0.OnPolyhedronSwitchHero(slot0)
	slot0:RefreshSettingUI()
end

return slot0
