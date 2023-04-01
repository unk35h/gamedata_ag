slot0 = class("MardukSpecialRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/special/MardukSpecialTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.treeGo_)
	slot8 = slot0.GroupRenderer

	slot0.tree_:SetRenderer(handler(slot0, slot8))

	slot0.rankDataDic_ = {}
	slot2 = ActivityCfg[slot0.params_.activityId].sub_activity_list
	slot0.resultActivityIds_ = {}
	slot0.activityIds_ = slot2
	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		if ActivityCfg[slot9].sub_activity_list ~= nil and #slot10.sub_activity_list > 0 then
			table.insert(slot3, slot9)
			table.insert(slot4, BattleQuickTrainingCfg.all[slot8])
		end
	end

	slot5 = UITreeData.New()
	slot0.activityIds_ = slot3
	slot0.battleIds_ = slot4

	for slot9 = 1, #slot3 do
		slot10 = slot3[slot9]
		slot11 = ActivityCfg[slot10]
		slot13 = UITreeGroupData.New()
		slot13.id = slot10
		slot13.text = BattleQuickTrainingCfg[slot4[slot9]].name

		slot5.groupDatas:Add(slot13)
	end

	slot0.tree_:SetData(slot5)
	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))

	slot0.rankContentView_ = MardukSpecialRankContentView.New(slot0.rankContentGo_)
end

function slot0.GroupRenderer(slot0, slot1, slot2)
	slot3 = ControllerUtil.GetController(slot2.transform, "lock")

	if ActivityData:GetActivityIsOpen(slot1) then
		slot3:SetSelectedState("false")
	else
		slot3:SetSelectedState("true")
	end
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if not ActivityData:GetActivityIsOpen(slot0.activityIds_[slot1]) then
		if ActivityData:GetActivityData(slot5).stopTime < manager.time:GetServerTime() then
			ShowTips(GetTips("TIME_OVER"))
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot5).startTime)))
		end

		slot0.tree_:SelectGroup(slot0.curIndex_)

		return
	end

	slot0.curIndex_ = slot1

	slot0:GetRankData(slot1, function ()
		uv0:UpdateGroupView(uv1)
	end)
end

function slot0.GetRankData(slot0, slot1, slot2)
	ActivityAction.GetRankData(ActivityCfg[slot0.activityIds_[slot1]].sub_activity_list[1], 1, 100, function (slot0)
		slot1 = {
			total = slot0.total,
			version = slot0.version,
			myRank = uv0:CreateRankInfo(slot0.my_rank)
		}
		slot2 = {}

		for slot6, slot7 in ipairs(slot0.rank_list) do
			table.insert(slot2, uv0:CreateRankInfo(slot7))
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.rank < slot1.rank
		end)

		slot1.rankList = slot2
		uv0.rankDataDic_[uv1] = slot1

		uv2()
	end)
end

function slot0.CreateRankInfo(slot0, slot1)
	slot2 = {
		user_id = slot1.user_id,
		score = slot1.score,
		difficulty = slot1.difficulty,
		rank = slot1.rank,
		nick = slot1.nick,
		portrait = slot1.portrait,
		frame = slot1.frame,
		select_hero_id_list = {}
	}
	slot3 = slot1.team_info[1] and slot1.team_info[1].hero_info_list or {}

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot2.select_hero_id_list, {
			id = slot8.hero_id,
			skin_id = slot8.skin_id
		})
	end

	return slot2
end

function slot0.UpdateGroupView(slot0, slot1)
	slot0.rankContentView_:SetData(slot0.activityIds_[slot1], slot0.battleIds_[slot1], slot0.rankDataDic_[slot1])
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot0:ShowDefaultBar()
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot1 = 1

	for slot5 = 1, #slot0.resultActivityIds_ do
		if slot0.resultActivityIds_[slot5] == slot0.params_.subActivityId then
			slot1 = slot5
		end
	end

	slot0:GetRankData(slot1, function ()
		uv0:UpdateGroupView(uv1)
	end)
	slot0.tree_:SelectGroup(slot1)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	if slot0.rankContentView_ then
		slot0.rankContentView_:Dispose()

		slot0.rankContentView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
