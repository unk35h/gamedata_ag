slot0 = class("SoloChallengeBossInfoView", ReduxView)

function slot0.UIName(slot0)
	if ActivityTools.GetActivityTheme(slot0.params_.activityID) == ActivityConst.THEME.TYR then
		return "UI/VersionUI/DarkFlameUI/DFSoloChallengeUI/DFSoloChallengeBossInfoUI"
	else
		return "UI/MardukUI/SoloChallenge/MardukSoloChallengeBoss"
	end
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.itemList_ = {}
	slot0.skillList_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = CollectMonsterCfg[slot0.id_]
	slot0.nameText_.text = slot1.name
	slot0.raceText_.text = GetTips("RACE_TYPE_" .. slot1.race)
	slot0.icon_.sprite = getSpriteWithoutAtlas(string.format("Textures/MardukUI/boss/solo582x648/%s", slot1.id))
	slot0.riskText_.text = NumberTools.IntToRomam(slot1.type + 1)

	slot0:UpdateData()
	slot0:RefreshSkill()
end

function slot0.RefreshSkill(slot0)
	for slot4 = 1, 6 do
		slot0:UpdateItem(slot4, slot0.skillList_[slot4])
	end

	for slot4 = 1, 6 do
		if string.len(slot0.skillList_[slot4].name) == 0 then
			slot0.itemList_[slot4]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.UpdateItem(slot0, slot1, slot2)
	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = SoloChallengeBossInfoItem.New(Object.Instantiate(slot0.itemGo_, slot0.contentTrs_))
	end

	slot0.itemList_[slot1]:RefreshUI(slot2)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.id_ = slot0.params_.bossID

	slot0:RefreshUI()
end

function slot0.UpdateData(slot0)
	slot0.skillList_ = {}

	for slot4 = 1, 6 do
		slot0.skillList_[slot4] = {
			isLock = false,
			name = CollectMonsterCfg[slot0.id_]["skill" .. slot4],
			info = CollectMonsterCfg[slot0.id_]["skill_desc" .. slot4]
		}
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
