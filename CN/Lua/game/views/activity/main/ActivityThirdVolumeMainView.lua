ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivityThirdVolumeMainView", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/VolumeMainUI"
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySkinTrialSubmoduleItem.New(slot0.heroSkinGo_, ActivityConst.VOLUME_SKIN_TRIAL_STAGE),
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.HADES_HERO_TRIAL_STAGE),
		ActivitySubmoduleItem.New(slot0.musicGame_, ActivityConst.VOLUME_III_PT),
		ActivitySubmoduleItem.New(slot0.windGame_, ActivityConst.VOLUME_III_COWBOY),
		ActivitySubmoduleItem.New(slot0.cakeGame_, ActivityConst.MOONBO),
		ActivitySubmoduleItem.New(slot0.mainStory_, ActivityConst.MAIN_STORY_CHAPTER_10),
		ActivitySubmoduleItem.New(slot0.impressionGo_, ActivityConst.VOLUME_SLAYER),
		ActivitySubmoduleItem.New(slot0.losterStory_, ActivityConst.VOLUME_MATRIX),
		ActivitySubmoduleItem.New(slot0.puzzleGo_, ActivityConst.ACTIVITY_PUZZLE)
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.THIRD_VOLUME_ACTIVITY
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.textTime_.text = string.format("%s\n            %s", manager.time:STimeDescS(slot1.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(slot1.stopTime, "!%Y.%m.%d %H:%M"))
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	if gameContext:IsBack("/thirdVolumeMain") > 0 then
		slot0.animator_:Play("VolumeMainUI", -1, 1)
		SetActive(slot0.particleGo_, false)
	else
		SetActive(slot0.particleGo_, true)
	end

	MoonBoData:FreshTime()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[uv0:GetActivityID()].activity_theme]) do
			table.insert(slot1, ActivityShopCfg[slot6].shop_id)
		end

		slot2, slot3 = ShopTools.IsShopOpen(slot1[1])

		if slot2 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot1[1],
				showShops = slot1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.chessBtn_, nil, function ()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return slot0
