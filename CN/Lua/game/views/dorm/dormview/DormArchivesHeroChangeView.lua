slot0 = class("DormArchivesHeroChangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HouseUI/TempUi/DormTempSameHeroChange"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.heroIDList[slot1], slot0.selheroID)
	slot2:RegisterClickCallBack(function (slot0)
		uv0.selheroID = slot0

		uv0.heroScroll:Refresh()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.cancelbtnBtn_, nil, function ()
		JumpTools:back()
	end)
	slot0:AddBtnListenerScale(slot0.confirmbtnBtn_, nil, function ()
		slot1 = {}

		table.insert(slot1, uv0.selheroID)
		DormAction:DeployHeroInRoom(DormData:GetCurrectSceneID(), slot1, DormEnum.DormDeployType.ReCall)
		JumpTools:back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID = slot0.params_.heroID or 0

	slot0:UpdataHerolList(slot0.heroID)
	slot0.heroScroll:StartScroll(#slot0.heroIDList)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function slot0.UpdataHerolList(slot0, slot1)
	if HeroRecordCfg[DormData:GetHeroArchiveID(slot1)] then
		slot0.heroIDList = HeroRecordCfg[slot2].hero_id
	else
		Debug.LogError("不存在角色档案信息")
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
