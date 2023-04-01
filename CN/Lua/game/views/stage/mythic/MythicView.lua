slot0 = class("MythicNewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Mythic/MythicUI"
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

	slot0._affixHero = {}
	slot0._affixMonster = {}
	slot4 = "isStar"
	slot0.isStarController = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.stageControllers = {}
	slot0.selectControllers = {}

	for slot4 = 1, 3 do
		slot5 = slot0["m_stage" .. slot4]
		slot0.stageControllers[slot4] = ControllerUtil.GetController(slot5.transform, "stage")
		slot0.selectControllers[slot4] = ControllerUtil.GetController(slot5.transform, "select")
	end

	slot0.mainController = ControllerUtil.GetController(slot0.m_stageMain.transform, "stage")
	slot0.mainSelectController = ControllerUtil.GetController(slot0.m_stageMain.transform, "select")
	slot0.heroAffixController = ControllerUtil.GetController(slot0.m_heroAffixController, "affix")
	slot0.mosterAffixController = ControllerUtil.GetController(slot0.m_mosterAffixController, "affix")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_shopBtn, nil, function ()
		uv0:CloseSectionInfo()
		JumpTools.GoToSystem("/shop", {
			shopId = 3,
			showShops = {
				3
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.m_refreshBtn, nil, function ()
		uv0:CloseSectionInfo()
		uv0:Go("popCostItem", {
			costCount = 1,
			costId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = handler(uv0, uv0.PopCostCallBack)
		})
	end)
	slot0:AddBtnListener(slot0.m_stageMain, nil, function ()
		if MythicData:GetDifficultyData(uv0.difficulty) then
			uv0:OpenSectionInfoView(slot0.main_partition, true, 0)
		end
	end)

	slot4 = slot0.m_stageMain_ball

	slot0:AddBtnListener(slot4, nil, function ()
		if MythicData:GetDifficultyData(uv0.difficulty) then
			uv0:OpenSectionInfoView(slot0.main_partition, true, 0)
		end
	end)

	for slot4 = 1, 3 do
		if slot0["m_stage" .. slot4] then
			slot0:AddBtnListener(slot5, nil, function ()
				if MythicData:GetDifficultyData(uv0.difficulty) and slot0.sub_partition_list[uv1] then
					uv0:OpenSectionInfoView(slot0.sub_partition_list[uv1], false, uv1)
				end
			end)
		end
	end

	slot0:AddBtnListener(slot0.m_difficultyBtn, nil, function ()
		uv0:CloseSectionInfo()

		if MythicData:GetStarRewardCount() == 0 then
			JumpTools.OpenPageByJump("mythicDifficulty")
		end
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		uv0:CloseSectionInfo()
		JumpTools.OpenPageByJump("mythicSectionReward", {
			difficulty = uv0.difficulty
		})
	end)
	slot0:AddBtnListener(slot0.m_btnMask, nil, function ()
		uv0:CloseSectionInfo()
	end)
end

function slot0.PopCostCallBack(slot0)
	if MythicData:GetStarCount() == 0 then
		ShowMessageBox({
			content = GetTips("ERROR_MYTHIC_REFRESH"),
			OkCallback = function ()
				CommonAction.TryToUseItem({
					{
						num = 1,
						item_id = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
						use_list = {}
					}
				})
			end
		})
	else
		for slot5 = 1, MythicData:GetStarCount() do
			if not MythicData:GetStarRewardState(slot5) then
				ShowTips("ERROR_BATTLE_MYTHIC_REWARD_NO_RECEIVED")

				return
			end
		end

		CommonAction.TryToUseItem({
			{
				num = 1,
				item_id = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
				use_list = {}
			}
		})
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MYTHIC_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function ()
		if uv0:IsOpenRoute("mythicSectionInfo") then
			uv0:CloseSectionInfo()
		else
			JumpTools.Back()
		end
	end)
	slot0:CheckDifficultyChange()

	if not slot0:IsOpenRoute("mythicSectionInfo") then
		slot0:OnMyticContentShow(false)
	end

	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.RefreshMaterial))
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)

	slot0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStr(MythicData:GetNextRefreshTime()))
	slot0.updateTimer_ = Timer.New(function ()
		uv0.cdText_.text = string.format(GetTips("TIME_DISPLAY_9"), "" .. manager.time:GetLostTimeStr(MythicData:GetNextRefreshTime()))
	end, 1, -1)

	slot0.updateTimer_:Start()
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, RedPointConst.MYTHIC_TIMES_AWARD)
	slot0:HideAffixInfo()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.CheckDifficultyChange(slot0)
	if MythicData:GetIsNewDifficulty() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_NEW_LEVEL_UNLOCK"),
			OkCallback = function ()
				MythicAction:QueryMythicRead()
				uv0:CheckMail()
			end
		})
	else
		slot0:CheckMail()
	end
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(3) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(3)

				if MythicData:IsShowDifficultySelectView() then
					TimeTools.StartAfterSeconds(0.033, function ()
						JumpTools.OpenPageByJump("mythicDifficulty")
					end, {})
				end
			end
		})
	elseif MythicData:IsShowDifficultySelectView() then
		TimeTools.StartAfterSeconds(0.033, function ()
			JumpTools.OpenPageByJump("mythicDifficulty")
		end, {})
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0.curDifficulty = MythicData:GetDifficulty()
	slot0.difficulty = slot0.curDifficulty

	slot0:RefreshMaterial()

	if slot0.difficulty == 0 then
		return
	end

	if MythicData:GetStarRewardCount() == 0 then
		slot0.isStarController:SetSelectedIndex(0)
	else
		slot0.isStarController:SetSelectedIndex(1)
	end

	slot0.m_romamLab.text = NumberTools.IntToRomam(slot0.difficulty)

	slot0:RefreshAffixItems(MythicData:GetAllHeroAffix(), true, slot0._affixHeroParent, slot0._affixHero, slot0.heroAffixController)
	slot0:RefreshAffixItems(MythicData:GetMonsterAffix(), false, slot0._affixMonsterParent, slot0._affixMonster, slot0.mosterAffixController)

	if MythicData:GetDifficultyData(slot0.difficulty) then
		if MythicData:GetIsFirstClear(slot2.main_partition.partition) then
			slot0.mainController:SetSelectedIndex(0)
		else
			slot0.mainController:SetSelectedIndex(1)
		end

		for slot8 = 1, 3 do
			if slot0.stageControllers[slot8] and slot2 and slot2.sub_partition_list[slot8] then
				if MythicData:GetIsFirstClear(slot2.sub_partition_list[slot8].partition) then
					slot9:SetSelectedIndex(0)
				else
					slot9:SetSelectedIndex(1)
				end
			end
		end
	end

	if not slot0:IsOpenRoute("mythicSectionInfo") then
		for slot6, slot7 in ipairs(slot0.selectControllers) do
			slot7:SetSelectedIndex(0)
		end

		slot0.mainSelectController:SetSelectedIndex(0)
	end
end

function slot0.RefreshMaterial(slot0)
	slot0.m_refreshCountText.text = "x1"

	if ItemTools.getItemNum(MaterialConst.MYTHIC_REFRESH_ITEM_ID) > 0 then
		SetActive(slot0.m_refreshBtn.gameObject, true)
	else
		SetActive(slot0.m_refreshBtn.gameObject, false)
	end
end

function slot0.RefreshAffixItems(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {}
	slot7 = 0
	slot8 = math.min(#(slot1 or {}), 3)
	slot9 = MythicCfg[slot0.difficulty] and MythicCfg[slot0.difficulty].sub_partition_list or {}

	for slot13, slot14 in ipairs(slot1) do
		slot15 = clone(slot14)

		if slot2 then
			if slot9[slot13] and MythicData:GetIsFirstClear(slot9[slot13]) then
				slot15.lock = true
			else
				slot15.lock = false
			end
		else
			slot15.lock = false
		end

		if slot14[3] == 3 then
			table.insert(slot6, 1, slot15)
		else
			slot7 = slot7 + 1

			table.insert(slot6, slot15)
		end
	end

	slot14 = "_"
	slot13 = slot8 .. slot14 .. slot7

	slot5:SetSelectedState(slot13)

	for slot13, slot14 in ipairs(slot6) do
		if slot4[slot13] == nil then
			slot4[slot13] = MythicAffixItem.New(slot0._affixItem, slot3, slot14)
		end

		slot15 = slot4[slot13]

		slot15:SetData(slot14)

		slot15 = slot4[slot13].transform_
		slot15 = slot15:GetComponent(typeof(Button))
		slot16 = slot15.onClick

		slot16:RemoveAllListeners()
		slot0:AddBtnListener(slot15, nil, function ()
			uv0:ShowAffixInfo(uv1[uv2].transform_, uv3)
		end)
	end

	for slot13 = #slot6 + 1, #slot4 do
		slot4[slot13]:Show(false)
	end
end

function slot0.OpenSectionInfoView(slot0, slot1, slot2, slot3)
	MythicData:SetIsNew(false)
	slot0:OnMyticContentShow(true)

	slot10 = "mythicSectionInfo"
	slot11 = {
		stageID = slot1.stage_id,
		partition = slot1.partition,
		difficulty = slot0.difficulty,
		isMain = slot2,
		affix = MythicData:GetAllHeroAffix()[slot3]
	}

	slot0:Go(slot10, slot11)

	for slot10, slot11 in ipairs(slot0.selectControllers) do
		slot11:SetSelectedIndex(0)
	end

	slot0.mainSelectController:SetSelectedIndex(0)

	if slot2 then
		slot0.mainSelectController:SetSelectedIndex(1)
	else
		slot0.selectControllers[slot3]:SetSelectedIndex(1)
	end
end

function slot0.OnMyticUpdate(slot0)
	slot0:RefreshUI()

	if MythicData:GetDifficulty() == 0 then
		JumpTools.OpenPageByJump("/mythic/mythicDifficulty", nil)
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if #slot2.use_item_list > 0 then
			MaterialAction.MaterialModify(slot2.use_item_list[1].item_id, -1 * slot2.use_item_list[1].num, slot2.use_item_list[1].time_valid)
		end

		MythicAction.QueryMythicInfo()
	else
		ShowTips(slot1.result)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()

	for slot4, slot5 in pairs(slot0._affixHero) do
		slot5:Dispose()
	end

	slot0._affixHero = {}

	for slot4, slot5 in pairs(slot0._affixMonster) do
		slot5:Dispose()
	end

	slot0._affixMonster = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnMyticContentShow(slot0, slot1)
	if slot1 then
		slot0:RemoveTween()

		slot3 = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, -300, 0.2)
		slot0.tween_ = slot3:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	else
		slot0:RemoveTween()

		slot2 = LeanTween.value(slot0.m_middleContent.gameObject, slot0.m_middleContent.localPosition.x, 0, 0.2)
		slot0.tween_ = slot2:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.m_middleContent.localPosition = Vector3(slot0, 0, 0)
		end))
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_middleContent.gameObject)

		slot0.tween_ = nil
	end
end

function slot0.CloseSectionInfo(slot0)
	if slot0:IsOpenRoute("mythicSectionInfo") then
		slot0:OnMyticContentShow(false)
		JumpTools.Back()
	end

	for slot4, slot5 in ipairs(slot0.selectControllers) do
		slot5:SetSelectedIndex(0)
	end

	slot0.mainSelectController:SetSelectedIndex(0)
end

function slot0.ShowAffixInfo(slot0, slot1, slot2)
	slot0:CloseSectionInfo()
	slot0.affixinfoTrs_:SetParent(slot1)

	slot0.affixinfoTrs_.localPosition = Vector3(0, -60, 0)

	SetActive(slot0.affixinfoTrs_.gameObject, true)

	slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot0.affixcontentTrs_.transform.localPosition.y, 0)

	if slot0.endPoint_:TransformPoint(Vector3(0, 0, 0)).x <= slot0.affixcontentTrs_:TransformPoint(Vector3(0, 0, 0)).x then
		slot0.affixcontentTrs_.transform.localPosition = Vector3(slot0.affixinfoTrs_:InverseTransformPoint(slot4).x, slot3.y, 0)
	else
		slot0.affixcontentTrs_.transform.localPosition = Vector3(261.505, slot3.y, 0)
	end

	slot0.affixcontentText_.text = getAffixDesc(slot2)
	slot0.affixnameText_.text = getAffixName(slot2)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.affixcontentTrs_)

	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	slot0.countdownTimer_ = Timer.New(function ()
		SetActive(uv0.affixinfoTrs_.gameObject, false)
	end, 2, 1)

	slot0.countdownTimer_:Start()
end

function slot0.HideAffixInfo(slot0)
	if slot0.countdownTimer_ then
		slot0.countdownTimer_:Stop()

		slot0.countdownTimer_ = nil
	end

	SetActive(slot0.affixinfoTrs_.gameObject, false)
end

return slot0
