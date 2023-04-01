slot0 = class("ChapterChallengeContentView", import("..ChapterBaseContentView"))

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	uv0.super.OnCtor(slot0, slot1, slot2)

	slot0.parent_view = slot3
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.showDropDownConrtoller = ControllerUtil.GetController(slot0.transform_, "showDropDown")
	slot0.demo_list = LuaList.New(handler(slot0, slot0.IndexDemoItem), slot0.m_list, ChapterDemoItem)
	slot0.demo_lock_controller = ControllerUtil.GetController(slot0.m_demoBtn.transform, "lock")
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_dropDownBtn, nil, function ()
		if uv0.showDropDownConrtoller:GetSelectedState() == "hide" then
			uv0.showDropDownConrtoller:SetSelectedState("show")
		else
			uv0.showDropDownConrtoller:SetSelectedState("hide")
		end
	end)
	slot0:AddBtnListener(slot0.m_challengeBtn, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")
		uv0:OnDropDownClick(1)
	end)
	slot0:AddBtnListener(slot0.m_demoBtn, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")

		if not uv0:IsLockDemo(true) then
			uv0:OnDropDownClick(2)
		end
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0.showDropDownConrtoller:SetSelectedState("hide")
	end)
end

function slot0.IsLockDemo(slot0, slot1)
	if PlayerData:GetPlayerInfo().userLevel < 35 and slot1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot2))
	end

	return slot3
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.select = slot0.parent_view.params_.challenge_select or 1

	if manager.guide:IsPlaying() then
		slot0.scrollView_.horizontalNormalizedPosition = 0
	end

	if not ActivityData:GetActivityIsOpen(ActivityConst.CHALLENGE_DEMO) then
		slot0.select = 1
	end

	slot1 = slot0.demo_lock_controller

	slot1:SetSelectedIndex(slot0:IsLockDemo() and 1 or 0)
	slot0.showDropDownConrtoller:SetSelectedState("hide")
	slot0:RefreshDropDown()
	manager.redPoint:bindUIandKey(slot0.m_dropDownBtn.transform, RedPointConst.COMBAT_CHALLENGE)
	manager.redPoint:bindUIandKey(slot0.m_challengeBtn.transform, RedPointConst.CHALLENGE_COMMON)
	manager.redPoint:bindUIandKey(slot0.m_demoBtn.transform, RedPointConst.CHALLENGE_DEMO)
	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)

	for slot5, slot6 in pairs(slot0.demo_list:GetItemList()) do
		slot6:UnBindRedPoint()
	end

	slot0.showDropDownConrtoller:SetSelectedState("hide")
	manager.redPoint:unbindUIandKey(slot0.m_dropDownBtn.transform, RedPointConst.COMBAT_CHALLENGE)
	manager.redPoint:unbindUIandKey(slot0.m_challengeBtn.transform, RedPointConst.CHALLENGE_COMMON)
	manager.redPoint:unbindUIandKey(slot0.m_demoBtn.transform, RedPointConst.CHALLENGE_DEMO)

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.RefreshDropDown(slot0)
	slot0.m_dropDownLab.text = slot0.select == 1 and GetTips("CHAPTER_CHALLENGE_1") or GetTips("CHAPTER_CHALLENGE_2")

	slot0.selectController:SetSelectedIndex(slot0.select == 1 and 0 or 1)
end

function slot0.OnDropDownClick(slot0, slot1)
	if slot1 == 2 then
		slot0.select = slot1
	else
		slot0.select = slot1
	end

	slot0.parent_view.params_.challenge_select = slot0.select

	slot0:RefreshDropDown()
end

function slot0.RefreshMapItems(slot0)
	for slot6 = #slot0.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		if slot2[slot6] ~= BattleConst.DAMAGE_TEST_CHAPTER_ID or not OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.DAMAGE_TEST) then
			table.insert(slot0.itemList_, slot0:CreateItem(slot7))
		end
	end

	slot0.demos = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.DEMO]

	slot0.demo_list:StartScroll(#slot0.demos)
end

function slot0.Display(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.itemList_) do
		if slot7:GetLockState() then
			table.insert(slot2, slot7)
		else
			table.insert(slot1, slot7)
		end
	end

	slot6 = slot2

	table.insertto(slot1, slot6)

	for slot6, slot7 in ipairs(slot1) do
		slot7:SetSiblingIndex(slot6)
	end

	slot0.scrollView_.enabled = false

	slot0:BreakDisplay()

	slot3 = 1
	slot0.timer_ = Timer.New(function ()
		uv0[uv1]:Show(true)

		if uv1 == #uv0 then
			uv2.scrollView_.enabled = true
		end

		uv1 = uv1 + 1
	end, 0.03, #slot1)

	slot0.timer_:Start()
end

function slot0.CreateItem(slot0, slot1)
	slot2 = nil

	if not ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]] then
		CustomLog.Log(debug.traceback(string.format("nil")))
	end

	return (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER or ChapterChallengeTownItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or ChapterChallengeBossItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC or ChapterChallengeMythicItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX or ChapterChallengeMatrixItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING and slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING or ChapterChallengeTeachItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS or ChapterChallengeWarChessItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAMAGE_TEST or ChapterChallengeDamageTestItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and (slot4.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS or ChapterChallengeAbyssItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)) and ChapterChallengeItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)
end

function slot0.CreateDemoItem(slot0, slot1)
	slot2 = nil

	return (slot1 ~= 601 or ChapterDemoOnlineItem.New(slot0.mapItem_, slot0.itemParent_, slot1)) and ChapterChallengeItemView.New(slot0.mapItem_, slot0.itemParent_, slot1)
end

function slot0.IndexDemoItem(slot0, slot1, slot2)
	slot2:SetData(slot0.demos[slot1])
end

function slot0.RefrenTime(slot0)
	if slot0.select == 2 then
		for slot5, slot6 in pairs(slot0.demo_list:GetItemList()) do
			slot6:RefrenTime()
		end
	end
end

return slot0
