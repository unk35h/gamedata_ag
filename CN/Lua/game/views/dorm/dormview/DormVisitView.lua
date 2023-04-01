slot0 = class("DormVisitView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormVisitUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.refreshFlag = true
	slot0.refreshTimer = Timer.New(function ()
		uv0.refreshFlag = true
	end, GameSetting.dorm_recommend_refresh_cd.value[1], 1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexTemplate), slot0.uilistGo_, DormVisitItem)
end

function slot0.OnEnter(slot0)
	slot0.groupID = slot0.groupID or 1

	slot0:RegisterEvents()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	slot0:SelGroup(slot0.groupID)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["tog_" .. slot4], function (slot0)
			if slot0 then
				uv0:SelGroup(uv1)
			end
		end)
	end

	slot0:AddDragListener(slot0.uilistGo_, function ()
	end, function ()
	end, function ()
		if uv0.loadingGo_.transform.sizeDelta.y < -1 * uv0.contentGo_.transform.anchoredPosition.y then
			if not uv0.refreshFlag then
				ShowTips(GetTips("DORM_RECOMMEND_CD"))

				return
			else
				uv0.refreshFlag = false

				uv0.refreshTimer:Start()
				DormAction:AskFurTemplateExhibitList(uv0.groupID)
			end
		end
	end)
end

function slot0.SelGroup(slot0, slot1)
	slot0.groupID = slot1
	slot0["tog_" .. slot0.groupID].isOn = true

	slot0:RefreshList()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_TEMPLATE_EXHI, function ()
		uv0:RefreshList()
	end)
end

function slot0.indexTemplate(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.visitList[slot1], slot0.groupID)
	slot2:RegisterEnterCallBack(function (slot0)
		DormitoryData:SetCurVisitUserID(slot0)

		if BackHomeCfg[DormitoryData:GetTemplateExhibitList(uv0.groupID)[slot0].architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
			DormAction:AskSingleFurTemplateExhibit(slot0, DormConst.BACKHOME_TYPE.VISITPUBLICDORM)
		else
			DormAction:AskSingleFurTemplateExhibit(slot0, DormConst.BACKHOME_TYPE.VISITPRIVATEDORM)
		end
	end)
end

function slot0.RefreshList(slot0)
	slot0.visitList = {}

	if DormitoryData:GetTemplateExhibitList(slot0.groupID) then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0.visitList, slot5)
		end

		slot0.scrollHelper_:StartScroll(#slot0.visitList)
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	if slot0.refreshTimer then
		slot0.refreshTimer:Stop()

		slot0.refreshTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
