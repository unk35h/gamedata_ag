slot0 = class("MythicDifficultyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicDiffcultyUI"
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

	slot0.difficultyList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_difficultyList, MythicDifficultyItem)
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.rewardIndexItem), slot0.m_rewardList, CommonItem)
	slot0.isFinalController_ = ControllerUtil.GetController(slot0.transform_, "isfinal")
	slot0.isFinal_ = false
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_sureBtn, nil, function ()
		slot0 = 0
		slot1 = 0

		if uv0.isFinal_ then
			slot0 = MythicData:GetFinalId()
			slot1 = MythicData:GetDifficulty()
		else
			slot0 = MythicCfg.all[uv0.index]
			slot1 = MythicData:GetDifficulty()
		end

		if slot0 == slot1 then
			uv0:Back()

			return
		end

		if slot1 == 0 or MythicData:GetPartitionCount() == 0 and MythicData:GetStarCount() == 0 and MythicData:GetFinalRewardNotGet() == false or _G.SkipTip.MythicDifficultyView then
			MythicAction.QueryChangeDifficulty(slot0)
		else
			ShowMessageBox({
				content = GetTips("MYTHIC_CHANGE_DIFFICULTY"),
				OkCallback = function ()
					MythicAction.QueryChangeDifficulty(uv0)
				end,
				ToggleCallback = function (slot0)
					_G.SkipTip.MythicDifficultyView = slot0
				end
			})
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.selectDifficulty = MythicData:GetDifficulty() == 0 and MythicData:GetMaxDifficulty() or slot1
	slot0.index = table.indexof(MythicCfg.all, slot0.selectDifficulty) or #MythicCfg.all + 1

	if slot0.index > #MythicCfg.all then
		slot0.isFinal_ = true
	else
		slot0.isFinal_ = false
	end

	slot0.difficultyList_:StartScroll(#MythicCfg.all + 1, slot0.index, true)
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0)
	if slot0.isFinal_ then
		slot0.isFinalController_:SetSelectedState("true")

		slot0.m_levelLab.text = (GameDisplayCfg.mythic_final_level.value[1] or 0) .. "-" .. (slot1[2] or 0)
		slot0.m_desLab.text = GetTips("MYTHIC_FINAL_TIPS")

		slot0.rewardList_:StartScroll(#GameDisplayCfg.mythic_final_reward.value)
	else
		slot0.isFinalController_:SetSelectedState("false")

		if not MythicCfg.all[slot0.index] then
			return
		end

		slot0.m_difficultyLab.text = NumberTools.IntToRomam(slot1)
		slot0.m_levelLab.text = (MythicCfg[slot1].recommend_level[1] or 0) .. "-" .. (slot4[2] or 0)
		slot0.m_desLab.text = slot2.desc
		slot0.preview_reward_list = slot2.preview_reward_list

		slot0.rewardList_:StartScroll(#slot0.preview_reward_list)
	end
end

function slot0.OnItemClick(slot0, slot1)
	slot0.index = slot1

	if slot0.index > #MythicCfg.all then
		slot0.isFinal_ = true
	else
		slot0.isFinal_ = false
	end

	for slot6, slot7 in pairs(slot0.difficultyList_:GetItemList()) do
		slot7:SetChoice(slot0.index)
	end

	slot0:Refresh()
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot1 > #MythicCfg.all then
		slot2:RefreshData(slot1)
	else
		slot2:RegistCallBack(function (slot0)
			uv0:OnItemClick(slot0)
		end)
		slot2:RefreshData(slot1, MythicCfg[MythicCfg.all[slot1]])
	end

	slot2:SetChoice(slot0.index)
end

function slot0.rewardIndexItem(slot0, slot1, slot2)
	slot3 = {}

	if slot0.isFinal_ then
		slot2:RefreshData(formatReward(GameDisplayCfg.mythic_final_reward.value[slot1]))
	else
		slot2:RefreshData(formatReward(slot0.preview_reward_list[slot1]))
	end

	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.Dispose(slot0)
	slot0.difficultyList_:Dispose()
	slot0.rewardList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnMyticUpdate(slot0)
	slot0.difficultyList_:Refresh()
end

return slot0
