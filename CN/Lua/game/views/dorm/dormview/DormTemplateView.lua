slot0 = class("DormTemplateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/DormEditschemeUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexTemplate), slot0.uilistUilist_, DormFurTemplateItem)
	slot0.templateID = nil
end

function slot0.OnEnter(slot0)
	slot0.canPreview = slot0.params_.canPreview

	if slot0.canPreview == nil then
		slot0.canPreview = true
	end

	slot0.pos = slot0.params_.pos or slot0.pos
	slot0.params_.pos = nil

	slot0:RefreshDormFurTemplateList()
	slot0:RegisterEvents()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_TEMPLATE_CHANGE, function ()
		uv0:RefreshDormFurTemplateList()
	end)
	slot0:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function ()
		uv0:RefreshDormFurTemplateList()
	end)
end

function slot0.indexTemplate(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.templateData[slot1], slot1, slot0.canPreview)
	slot2:RegisterUseTemplateCallBack(function (slot0)
		if not uv0.canPreview or slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		slot2 = DormitoryData:GetDormTemplateInfo(slot0)
		slot3, slot4 = DormTools:CheckFurNumSuitTemplate(slot0, DormData:GetCurrectSceneID())

		DormTools.HideAllCharacter()

		if not slot3 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_NOT_ENOUGH"),
				OkCallback = function ()
					slot0, slot1, slot2 = DormTools:ReduceTemplateLackFurInfoS(uv0, uv1)

					DormTools:GenFurListInCurRoom(slot0)
					DormTools:ChangeDormFloorOrWall(slot1)
					DormTools:ChangeDormFloorOrWall(slot2)
					DormitoryData:CacheWallAndFloorInfo(slot2, slot1)
					DormTools:ConfirmUseTemplateInRoom(uv0, uv2, uv3, slot0)
					ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
					JumpTools.OpenPageByJump("/dorm")
				end,
				CancelCallback = function ()
				end
			})
		elseif slot2 then
			DormTools:GenFurListInCurRoom(slot2.furnitureInfoS)
			DormTools:ChangeDormFloorOrWall(slot2.wallID)
			DormTools:ChangeDormFloorOrWall(slot2.floorID)
			DormitoryData:CacheWallAndFloorInfo(slot2.floorID, slot2.wallID)
			DormTools:ConfirmUseTemplateInRoom(slot0, slot1, slot3)
			ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
			JumpTools.OpenPageByJump("/dorm")
		else
			print("未找到模板信息，id为" .. slot0)
		end

		DormTools:GenerateHeroWhenEnterScene()
	end)
	slot2:RegisterPreviewCallBack(function (slot0, slot1)
		if not uv0.canPreview then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		uv0.pos = slot1

		DormTools:PreviewDormSceneTemplate(slot0)
		JumpTools.OpenPageByJump("/dormPreviewTemplateView", {
			templateID = slot0
		})
	end)
	slot2:SaveTemplateCallBack(function (slot0, slot1)
		if DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID()).roomInfo.furnitureInfoS.Length == 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_SET"))

			return
		end

		if slot1 then
			uv0.pos = slot1

			if slot0 > 0 then
				ShowMessageBox({
					isTop = true,
					content = GetTips("DORM_MOULD_COVER"),
					OkCallback = function ()
						slot0 = DormData:GetCurrectSceneID()

						DormTools:SaveDormSceneTemplate(uv0, BackHomeCfg[slot0].type, DormitoryData:GetDormTemplateInfo(uv0):GetTemplateName(), slot0, uv1)
					end,
					CancelCallback = function ()
					end
				})
			else
				slot4 = DormData:GetCurrectSceneID()

				DormTools:SaveDormSceneTemplate(DormitoryData:GetCanUseTemplateID(), BackHomeCfg[slot4].type, string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(slot1)), slot4, slot1)
			end
		end
	end)
	slot2:ReviseNameCallBack(function (slot0, slot1)
		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		uv0.pos = slot1

		JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
			template_ID = slot0
		})
	end)
	slot2:DelTemplateCallBack(function (slot0, slot1)
		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_DELETE_TEMPLATE"),
			OkCallback = function ()
				uv0.pos = uv1

				DormAction:DeleteFurTemplate(uv2)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.RefreshDormFurTemplateList(slot0)
	if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot2 = DormConst.BACKHOME_TYPE.PublicDorm
	elseif slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot2 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	slot0.templateData = {}
	slot3 = nil
	slot3 = (slot2 ~= DormConst.BACKHOME_TYPE.PublicDorm or DormConst.DORM_TEMPLATE_NUM_MAX) and DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX

	for slot7 = 1, slot3 do
		if DormitoryData:GetDormTemplateInfoByPosID(slot7, slot2) then
			table.insert(slot0.templateData, slot8)
		else
			table.insert(slot0.templateData, -1)
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.templateData)

	if slot0.pos then
		slot0.scrollHelper_:ScrollToIndex(slot0.pos, true, false)
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
