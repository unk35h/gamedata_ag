slot0 = class("DormHeroDeployView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormPersonnelAllocationUI"
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

	slot0.characterScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormCharacterItem)
end

function slot0.OnEnter(slot0)
	slot0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot0.maxNum = GameSetting.dorm_lobby_hero_max.value[1]
	else
		slot0.maxNum = DormConst.PRIVATE_CHARACTER_MAX_NUM
	end

	slot0.maxnumText_.text = "/" .. slot0.maxNum

	slot0:RefreshDormHeroList()
	slot0:RegisterEvents()
	slot0:RefreshPlaceHeroNum()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.dataList_[slot1], slot0.selHeroID, slot1)
	slot2:OnPointerDown(function (slot0)
		if uv0.duringGrab then
			uv0.selHeroID = nil
		else
			uv0.selHeroID = slot0
		end

		uv0.characterScroll:Refresh()
	end)
	slot2:RecallHero(function (slot0)
		if DormData:GetCurrectSceneID() == DormConst.PUBLIC_DORM_ID then
			slot3 = {}
			slot5 = DormData:GetHeroTemplateInfo(slot0):GetHeroId()

			for slot9, slot10 in ipairs(DormitoryData:GetDormHerosByArchitecture(slot1)) do
				if slot10 ~= slot5 then
					table.insert(slot3, slot10)
				end
			end

			DormAction:DeployHeroInRoom(slot1, slot3, DormEnum.DormDeployType.ReCall)
		else
			DormAction:RecallHeroInPrivateDorm(slot1)
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function ()
		uv0.characterScroll:Refresh()
		uv0:RefreshPlaceHeroNum()
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_RELEASED, function ()
		uv0.uilistGo_:GetComponent("ScrollRectEx").horizontal = true

		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.DownCharacter)

		uv0.duringGrab = false
	end)
	slot0:RegistEventListener(DORM_DRAG_HERO_SUCCESS, function ()
		uv0.characterScroll:Refresh()

		uv0.uilistGo_:GetComponent("ScrollRectEx").horizontal = false
		uv0.selHeroID = nil
		uv0.duringGrab = true
	end)
	slot0:RegistEventListener(ON_DORM_CHARACTER_GRAB_STARTED, function ()
		DormTools:PlayDormAudioEffect(DormConst.DORM_AUDIO_EFFECT.UpCharacter)
	end)
end

function slot0.AddUIListener(slot0)
	slot1 = slot0.uilistSrex_.ExitScrollArea

	slot1:AddListener(function ()
		if uv0.duringGrab then
			return
		end

		if uv0.selHeroID then
			if DormData:GetHeroInfo(DormData:GetHeroArchiveID(uv0.selHeroID)):GetHeroState() == DormEnum.DormHeroState.InCanteenRntrust then
				ShowTips(GetTips("DORM_HERO_WORK_IN_CANTEEN"))

				return
			end

			if uv0:CheckCharacterNumMax() then
				slot3 = DormData:GetCurrectSceneID()
				slot4 = DormitoryData:GetDormHerosByArchitecture(slot3)
				slot5 = DormitoryData:GetDormArchivesByArchitecture(slot3)

				if BackHomeCfg[slot3].type == DormConst.BACKHOME_TYPE.PublicDorm then
					for slot9, slot10 in ipairs(slot5) do
						if slot10 == slot0 then
							ShowTips(GetTips("DORM_HERO_SAME_SET"))

							return
						end
					end

					slot6 = {}

					for slot10, slot11 in ipairs(slot4) do
						table.insert(slot6, slot11)
					end

					table.insert(slot6, uv0.selHeroID)
					DormTools:GenerateHeroByDrag(uv0.selHeroID)
					DormAction:DeployHeroInRoom(slot3, slot6, DormEnum.DormDeployType.Place)
				elseif BackHomeCfg[slot3].type == DormConst.BACKHOME_TYPE.PrivateDorm then
					if slot2 == DormEnum.DormHeroState.InPublicDorm or slot2 == DormEnum.DormHeroState.OutDorm then
						DormTools:GenerateHeroByDrag(uv0.selHeroID)
						DormAction:RecallHeroInPrivateDorm(slot3)

						return
					elseif slot2 == DormEnum.DormHeroState.InPrivateDorm then
						ShowTips(GetTips("DORM_HERO_SAME_SET"))

						return
					end
				end
			else
				ShowTips(GetTips("DORM_LOBBY_SET_MAX"))
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.backBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshDormHeroList(slot0)
	slot0.dataList_ = {}
	slot0.dataList_ = DormTools:GetBackHomeCanUseHeroList()

	CommonTools.UniversalSortEx(slot0.dataList_, {
		ascend = true,
		map = function (slot0)
			if DormData:GetHeroTemplateInfo(slot0):GetHeroState() ~= DormEnum.DormHeroState.InCanteenRntrust then
				return 1
			else
				return 2
			end
		end
	}, {
		map = function (slot0)
			return DormData:GetHeroArchiveID(slot0)
		end
	}, {
		map = function (slot0)
			return slot0
		end
	})
	slot0.characterScroll:StartScroll(#slot0.dataList_)
end

function slot0.CheckCharacterNumMax(slot0)
	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList then
			if slot0.maxNum <= #slot1 then
				return false
			else
				return true
			end
		end
	else
		return true
	end
end

function slot0.RefreshPlaceHeroNum(slot0)
	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList then
			slot0.curnumText_.text = #slot1
		else
			slot0.curnumText_.text = 0
		end
	elseif DormData:GetHeroInfo(DormitoryData:GetDormSceneData(slot0.roomID).archiveIDList[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
		slot0.curnumText_.text = 1
	else
		slot0.curnumText_.text = 0
	end
end

function slot0.Dispose(slot0)
	if slot0.characterScroll then
		slot0.characterScroll:Dispose()
	end

	slot0.uilistSrex_.ExitScrollArea:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
