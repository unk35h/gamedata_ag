slot0 = class("DormUnLockRoomConfirmView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormUnlockPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.roomScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormRoomUnLockItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.roomID = slot0.params_.roomID

	slot0:RefreshHeroList()
	slot0:RegisterEvents()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_HERO_OCCUPY, function (slot0)
		JumpTools.Back()
		JumpTools.OpenPageByJump("dormPrivateOccupySuccessView", {
			archiveID = slot0[1]
		})
	end)
end

function slot0.RefreshHeroList(slot0)
	slot0.archiveList = {}

	for slot5, slot6 in ipairs(DormData:GetCanUseHeroInDorm()) do
		if not DormitoryData:GetDormIDViaArchive(slot6) and GameSetting.dorm_hero_set_level.value[1] <= DormData:GetHeroInfo(slot6):GetHeroFavorability() then
			table.insert(slot0.archiveList, slot6)
		end
	end

	slot0.roomScroll:StartScroll(#slot0.archiveList)

	if #slot0.archiveList == 0 then
		slot0.textText_.text = GetTips("DORM_HERO_SET_NULL")
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.archiveList[slot1])
	slot2:PlaceHeroCallBack(function (slot0)
		ShowMessageBox({
			content = string.format(GetTips("DORM_HERO_SET_CHECK"), HeroRecordCfg[slot0].name),
			OkCallback = function ()
				if DormData:GetHeroInfo(uv0).canUseHero[1] then
					DormAction:DeployHeroInRoom(uv1.roomID, {
						slot1
					}, DormEnum.DormDeployType.Occupy)
				else
					Debug.LogError("未找到可以使用的角色id")
				end
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.Dispose(slot0)
	if slot0.roomScroll then
		slot0.roomScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
