slot0 = class("EquipBreakThroughMaterialModeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSelectDifficultyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.btnTransform_, "conName")
	slot0.chooseHandler_ = handler(slot0, slot0.ChooseMode)
	slot0.modeUIList_ = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.uiList_, EquipBreakThroughMaterialModeItem)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
	slot0.modeUIList_:StartScroll(#EquipBreakThroughMaterialDifficultyCfg.all, 1)
	slot0:RefreshUI()
	slot0:CheckMail()
end

function slot0.OnExit(slot0)
	slot0.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, slot0.chooseHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.chooseHandler_ = nil

	if slot0.modeUIList_ then
		slot0.modeUIList_:Dispose()

		slot0.modeUIList_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.chooseBtn_, nil, function ()
		if uv0.chooseIndex_ == nil then
			return
		end

		if uv0.chooseIndex_ == EquipBreakThroughMaterialData:GetSelectModeID() then
			uv0:Go("/equipBreakThroughMaterialMap", nil, true)

			return
		end

		if EquipBreakThroughMaterialData:GetSelectModeID() ~= 0 or EquipBreakThroughMaterialData:GetSelectModeID() == uv0.chooseIndex_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_RESET_DIFFICULTY"),
				OkCallback = function ()
					uv0:ClickBtn()
				end
			})

			return
		else
			uv0:ClickBtn()
		end
	end)
end

function slot0.CheckMail(slot0)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function ()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL)
			end
		})
	end
end

function slot0.ClickBtn(slot0)
	EquipBreakThroughMaterialAction.RequireEquipBTMaterialData(slot0.chooseIndex_, function ()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE)
		uv0:Go("/equipBreakThroughMaterialMap", nil, true)
	end)
end

function slot0.RefreshUI(slot0)
	slot0:ChooseMode(slot0.chooseIndex_)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.chooseIndex_)
end

function slot0.ChooseMode(slot0, slot1)
	slot0.chooseIndex_ = slot1

	if slot1 then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end
end

return slot0
