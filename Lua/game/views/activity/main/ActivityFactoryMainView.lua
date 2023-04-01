ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivityFactoryMainView", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/MardukUI/main/MarduckMainUI"
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.storyGo_, ActivityConst.FACTORY_STORY),
		ActivitySubmoduleItem.New(slot0.leftBtn2_, ActivityConst.FACTORY_MARDUK),
		ActivitySubmoduleItem.New(slot0.rightBtn4_, ActivityConst.FACTORY_INFINITY_POOL_TASK),
		ActivitySubmoduleItem.New(slot0.rightBtn5_, ActivityConst.FACTORY_SEQUENTIAL_BATTLE),
		ActivitySubmoduleItem.New(slot0.rightBtn6_, ActivityConst.FACTORY_SURVIVE_SOLO),
		ActivitySubmoduleItem.New(slot0.ptGo_, ActivityConst.FACTORY_PT),
		ActivitySubmoduleItem.New(slot0.leftBtn1_, ActivityConst.FACTORY_TOWERGAME),
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.FACTORY_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(slot0.heroSkinGo_, ActivityConst.FACTORY_SKIN_TRIAL),
		ActivitySubmoduleItem.New(slot0.soloBtn7_, ActivityConst.FACTORY_SOLO_CHALLENGE)
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.FACTORY_ACTIVITY
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot0.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(slot1.startTime, "!%Y %m.%d"), manager.time:STimeDescS(slot1.stopTime, "!%m.%d"))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.subPlotBtn_, nil, function ()
		JumpTools.Jump2SubPlot(6010005, false)
	end)
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
end

return slot0
