slot0 = class("ChessMutiBattleView", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessTeamToPrepareUI"
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

	slot0.changehandler_ = handler(slot0, slot0.OnChangeBtnClick)
	slot0.confirmhandler_ = handler(slot0, slot0.OnConfirmBtnClick)
	slot0.changeindex_1 = 0
	slot0.changeindex_2 = 0
	slot0.heroList_ = LuaList.New(handler(slot0, slot0.indexHeroList), slot0.uilistGo_, ChessMutiBattleItemView)
end

function slot0.OnChangeBtnClick(slot0, slot1)
	if slot0.changeindex_1 == 0 then
		slot0.changeindex_1 = slot1

		for slot6, slot7 in pairs(slot0.heroList_:GetItemList()) do
			slot7:OnChangeRefreshStatus(slot1)
		end

		SetActive(slot0.btn_warbeganGo_, false)
	else
		slot0:ResetStatus()
	end
end

function slot0.OnConfirmBtnClick(slot0, slot1)
	slot0.changeindex_2 = slot1

	if slot0.changeindex_1 ~= 0 and slot0.changeindex_2 ~= 0 then
		BattleTeamData:SwapTeam(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS, slot0.activityID_, nil, slot0.changeindex_1, slot0.changeindex_2)
		slot0.heroList_:StartScroll(slot0.times_)
	end

	slot0:ResetStatus()
end

function slot0.ResetStatus(slot0)
	slot0.changeindex_1 = 0
	slot0.changeindex_2 = 0

	for slot5, slot6 in pairs(slot0.heroList_:GetItemList()) do
		slot6:ResetState()
	end

	SetActive(slot0.btn_warbeganGo_, true)
end

function slot0.indexHeroList(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.battleList_[slot1], slot0.typeList_[slot1], slot0.activityID_, #slot0.battleList_)
	slot2:RegionHandler(slot0.changehandler_, slot0.confirmhandler_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_warbeganBtn_, nil, function ()
		if not ChessTools.CheckCanEnterMutiBattle(uv0.times_, uv0.activityID_) then
			ShowTips("ERROR_MULTIPLE_BATTLES_REQUIREMENT")

			return
		end

		WarChessAction.SetMutiTeam(uv0.xz_.x, uv0.xz_.z, uv0.times_, uv0.activityID_, function ()
			slot0 = {}

			for slot4 = 1, uv0.times_ do
				slot0[slot4] = BattleChessStageTemplate.New(uv0.battleList_[slot4], uv0.activityID_, {
					teamID = slot4,
					teamLength = #uv0.battleList_
				})

				if slot4 > 1 then
					slot0[slot4 - 1]:SetNextStage(slot0[slot4])
				end
			end

			BattleController.GetInstance():LaunchBattle(slot0[1])
		end)
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")

	slot0.times_ = slot0.params_.times
	slot0.battleList_ = slot0.params_.battleList
	slot0.activityID_ = slot0.params_.activityID
	slot0.xz_ = slot0.params_.xz
	slot0.typeList_ = slot0.params_.typeList
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.changeindex_1 ~= 0 then
			uv0:ResetStatus()
		else
			JumpTools.Back()
		end
	end)
	slot0.heroList_:StartScroll(slot0.times_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:ResetStatus()
end

function slot0.Dispose(slot0)
	if slot0.heroList_ then
		slot0.heroList_:Dispose()

		slot0.heroList_ = nil
	end

	slot0.changehandler_ = nil
	slot0.confirmhandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
