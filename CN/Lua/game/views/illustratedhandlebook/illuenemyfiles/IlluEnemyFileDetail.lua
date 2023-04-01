slot0 = class("IlluEnemyFileDetail", ReduxView)

function slot0.UIName(slot0)
	return "UI/IllustratedHandbook/IlluEnemyDetailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.itemList_ = {}
	slot0.conList_ = {}
	slot0.infoList_ = {}
	slot0.skillList_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.enemyAvatarView_ = EnemyAvatarView.New(slot0, slot0.displayGo_)
	slot0.riskCon_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.dataTgl_, function (slot0)
		if slot0 then
			uv0:RefreshInfo()
		end
	end)
	slot0:AddToggleListener(slot0.skillTgl_, function (slot0)
		if slot0 then
			uv0:RefreshSkill()
		end
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = CollectMonsterCfg[slot0.id_]
	slot0.nameText_.text = slot1.name
	slot0.raceText_.text = GetTips("RACE_TYPE_" .. slot1.race)
	slot0.descText_.text = slot1.desc

	slot0.riskCon_:SetSelectedState(slot1.type)
	slot0:UpdateData()

	if slot0.dataTgl_.isOn then
		slot0:RefreshInfo()
	else
		slot0.dataTgl_.isOn = true
	end
end

function slot0.RefreshInfo(slot0)
	for slot4 = 1, 3 do
		slot0:UpdateItem(slot4, slot0.infoList_[slot4])
	end

	for slot4 = 4, #slot0.itemList_ do
		slot0.itemList_[slot4]:Hide()
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
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
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.UpdateItem(slot0, slot1, slot2)
	if not slot0.itemList_[slot1] then
		slot0.itemList_[slot1] = IlluEnemyFileDetailItem.New(Object.Instantiate(slot0.itemGo_, slot0.contentTrs_))
	end

	slot0.itemList_[slot1]:RefreshUI(slot2)
end

function slot0.OnEnter(slot0)
	slot0:ShowDefaultBar()
	manager.ui:SetMainCamera("bossChallenge")

	slot0.id_ = slot0.params_.id

	slot0.enemyAvatarView_:OnEnter()
	slot0.enemyAvatarView_:SetBossID(slot0.id_)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	slot0.enemyAvatarView_:OnExit()
end

function slot0.UpdateData(slot0)
	slot0.infoList_ = {}
	slot0.skillList_ = {}

	for slot4 = 1, 3 do
		slot0.infoList_[slot4] = {
			isLock = false,
			name = string.format(GetTips("MONSTER_INFORMATION") .. slot4),
			info = CollectMonsterCfg[slot0.id_]["information" .. slot4]
		}
	end

	for slot4 = 1, 6 do
		slot0.skillList_[slot4] = {
			isLock = false,
			name = CollectMonsterCfg[slot0.id_]["skill" .. slot4],
			info = CollectMonsterCfg[slot0.id_]["skill_desc" .. slot4]
		}
	end
end

function slot0.Dispose(slot0)
	slot0.enemyAvatarView_:Dispose()

	slot0.enemyAvatarView_ = nil

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
