slot0 = class("PolyhedronLeaderView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronLeaderUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.leaderController = ControllerUtil.GetController(slot0.transform_, "leader")
	slot0.nextController = ControllerUtil.GetController(slot0.transform_, "next")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		slot0 = nil

		gameContext:Go("/heroTeamInfoPolyhedron", {
			selectHeroPos = 1,
			heroTeam = (uv0.leader == 0 or {
				uv0.leader
			}) and {}
		})
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		if uv0.leader == 0 then
			return
		end

		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.leader = PolyhedronData:GetCacheSelectHero()

	if slot0.leader == 0 then
		slot0.leaderController:SetSelectedIndex(0)
		slot0.nextController:SetSelectedIndex(0)
	else
		slot0.leaderController:SetSelectedIndex(1)
		slot0.nextController:SetSelectedIndex(1)

		slot0.m_icon.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot0.leader)
		slot0.m_name.text = HeroCfg[slot0.leader].name
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
