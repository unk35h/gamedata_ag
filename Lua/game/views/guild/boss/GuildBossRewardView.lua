slot0 = class("GuildBossRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/ClubBossReward"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bonusList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, GuildBossBonusItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.bonusDataList_[slot1], math.max(GuildData:GetCurrentBossRemainHp(), 0))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_BONUS_GET, function ()
		uv0:InitData()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.InitData(slot0)
	slot2 = GuildData
	slot0.bonusDataList_ = ClubBossCfg[slot2:GetBossDifficulty()].reward

	table.sort(slot0.bonusDataList_, function (slot0, slot1)
		return slot0[1] < slot1[1]
	end)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0:InitData()
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.bonusList_:StartScroll(#slot0.bonusDataList_)

	slot1 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	slot2 = GuildData:GetCurrentBossRemainHp()
	slot0.progressImage_.fillAmount = slot2 / slot1
	slot0.hpLabel_.text = slot2 .. "/" .. slot1
	slot0.progressLabel_.text = string.format("%d%%", math.ceil(100 * slot2 / slot1))
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.bonusList_ then
		slot0.bonusList_:Dispose()

		slot0.bonusList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
