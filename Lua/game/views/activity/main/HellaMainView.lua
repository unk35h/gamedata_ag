slot0 = class("HellaMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/HellaUI/HellaMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.refreshHeroTrialBtnHandler = handler(slot0, slot0.RefreshHeroTrialBtn)

	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitSubmoduleButton()
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.butterflyGo_, ActivityConst.HELLA_STORY_STAGE),
		ActivitySubmoduleItem.New(slot0.passGo_, ActivityConst.HELLA_BOSS_CHALLENGE),
		ActivitySubmoduleItem.New(slot0.talentGo_, ActivityConst.HELLA_TALENT_TREE),
		ActivitySubmoduleItem.New(slot0.tombGo_, ActivityConst.HELLA_CHESS),
		ActivitySkinTrialSubmoduleItem.New(slot0.skinTrialGo_, ActivityConst.HELLA_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(slot0.disasterGo_, ActivityConst.HELLA_SLAYER),
		ActivitySubmoduleItem.New(slot0.missGo_, ActivityConst.HELLA_PARKOUR),
		ActivitySubmoduleItem.New(slot0.campGo_, ActivityConst.HELLA_TOWER_DEFENCE),
		[BattleConst.STAGE_TYPE_NEW.HERO_TRIAL] = ActivitySubmoduleItem.New(slot0.tryGo_, ActivityConst.HELLA_HERO_TRIAL_STAGE)
	}
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(ActivityConst.HELLA_ACTIVITY)
	slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot1.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot1.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(HERO_TRIAL_UPDATE, slot0.refreshHeroTrialBtnHandler)
	slot0:RefreshHeroTrialBtn()
	slot0:RefreshUI()

	slot1 = getData("activity_movie", "hella") ~= nil

	SetActive(slot0.movie1Go_, not slot1)
	SetActive(slot0.movie2Go_, slot1)

	if slot1 then
		slot0.mainDirector_.time = 4
	else
		slot0.mainDirector_.time = 0
	end

	slot0.mainDirector_:Play()

	slot5 = "hella"
	slot6 = 1

	saveData("activity_movie", slot5, slot6)

	for slot5, slot6 in pairs(slot0.submoduleBtnList_) do
		slot6:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:OnExit()
	end

	manager.notify:RemoveListener(HERO_TRIAL_UPDATE, slot0.refreshHeroTrialBtnHandler)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.submoduleBtnList_) do
		slot5:Dispose()
	end

	slot0.submoduleBtnList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = 24,
			showShops = {
				24
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.btn_warchessBtn_, nil, function ()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040301,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

function slot0.RefreshHeroTrialBtn(slot0)
	for slot4, slot5 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		if ActivityData:GetActivityIsOpen(slot4) then
			if slot0.submoduleBtnList_[BattleConst.STAGE_TYPE_NEW.HERO_TRIAL] ~= nil then
				slot0.submoduleBtnList_[BattleConst.STAGE_TYPE_NEW.HERO_TRIAL]:Dispose()

				slot0.submoduleBtnList_[BattleConst.STAGE_TYPE_NEW.HERO_TRIAL] = nil
			end

			slot0.submoduleBtnList_[BattleConst.STAGE_TYPE_NEW.HERO_TRIAL] = ActivitySubmoduleItem.New(slot0.tryGo_, slot4)

			break
		end
	end
end

return slot0
