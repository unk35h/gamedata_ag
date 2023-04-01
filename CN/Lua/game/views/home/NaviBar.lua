slot0 = class("NaviBar", ReduxView)
slot1 = import("game.const.TaskConst")
slot2 = import("game.const.ViewConst")
slot3 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0)
end

function slot0.UIName(slot0)
	return "UI/NaviBarUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitUI(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener("navibar/topbtn/btn_userinfo", nil, function ()
		gameContext:ClearHistroy()
		uv0.GoToSystem("/userinfo", nil, uv1.SYSTEM_ID.BACK_HOUSE)
	end)
	slot0:AddBtnListener("navibar/topbtn/btn_document", nil, function ()
	end)
	slot0:AddBtnListener("navibar/topbtn/btn_close", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_hero", nil, function ()
		gameContext:ClearHistroy()
		uv0.GoToSystem("/herolist", nil, uv1.SYSTEM_ID.HERO)
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_mission", nil, function ()
		gameContext:ClearHistroy()
		uv0.GoToSystem("/task", {
			taskIndex = uv1.TASK_TYPE.DAILY
		}, uv2.SYSTEM_ID.TASK_PLOT)
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_battle", nil, function ()
		gameContext:ClearHistroy()
		uv0.GoToSystem("/chapterMap", {
			chapterToggle = 1
		}, uv1.SYSTEM_ID.BATTLE)
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_shop", nil, function ()
		gameContext:ClearHistroy()
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_mail", nil, function ()
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_lounge", nil, function ()
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_guild", nil, function ()
		gameContext:ClearHistroy()
	end)
	slot0:AddBtnListener("navibar/buildingbtn/btn_search", nil, function ()
		gameContext:ClearHistroy()
		uv0.GoToSystem("/draw", nil, uv1.SYSTEM_ID.DRAW)
	end)
	slot0:AddBtnListener("mask", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListenerScale("btn_return", nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListenerScale("btn_last", nil, function ()
		uv0:Go("/home")
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
