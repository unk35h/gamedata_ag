slot0 = class("DormPreviewTemplateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/BackHouseUI/Dorm/PreviewBtnUI"
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

function slot0.OnEnter(slot0)
	slot0.templateID = slot0.params_.templateID
end

function slot0.OnExit(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.backBtn_, nil, function ()
		DormTools:CancelPreviewDormSceneTemplate(DormData:GetCurrectSceneID())
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.useBtn_, nil, function ()
		slot1 = DormitoryData:GetDormTemplateInfo(uv0.templateID)
		slot2, slot3 = DormTools:CheckFurNumSuitTemplate(uv0.templateID, DormData:GetCurrectSceneID())
		slot4 = slot1.wallID
		slot5 = slot1.floorID

		if not slot2 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_NOT_ENOUGH"),
				OkCallback = function ()
					slot0, slot1, slot2 = DormTools:ReduceTemplateLackFurInfoS(uv0.templateID, uv1)

					DormTools:GenFurListInCurRoom(slot0)
					DormTools:ChangeDormFloorOrWall(slot1)
					DormTools:ChangeDormFloorOrWall(slot2)
					DormitoryData:CacheWallAndFloorInfo(slot2, slot1)
					DormTools:ConfirmUseTemplateInRoom(uv0.templateID, uv2, uv3, slot0)
				end,
				CancelCallback = function ()
					DormTools:CancelPreviewDormSceneTemplate(DormData:GetCurrectSceneID())
				end
			})
		else
			DormitoryData:CacheWallAndFloorInfo(slot5, slot4)
			DormTools:ConfirmUseTemplateInRoom(uv0.templateID, slot0, slot2, nil)
		end

		JumpTools.OpenPageByJump("/dorm")
		DormTools:GenerateHeroWhenEnterScene()
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
