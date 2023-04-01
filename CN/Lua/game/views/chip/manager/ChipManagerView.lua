slot0 = class("ChipManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Chip/ChipUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chipManagerUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipManagerItem), slot0.uiList_, slot0:GetChipManagerItem())
	slot0.chipManagerLockView_ = ChipManagerLockView.New(slot0.lockPanel_)
	slot0.chipManagerUnlockView_ = slot0:GetManagerUnlockView().New(slot0.regulatePanel_)
	slot0.toggleController_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)

	slot0.handler_ = handler(slot0, slot0.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.chipManagerList_ = slot0:GetChipManagerList()
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0.chipManagerUIList_:StartScroll(#slot0.chipManagerList_, table.keyof(slot0.chipManagerList_, slot0.defaultSelectID_))
	slot0:RefreshUI()
	slot0:InitToggle()

	slot0.storyTime = Time.realtimeSinceStartup
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, slot0.handler_)
	slot0:RecordStay(slot0.toggleController_:GetSelectedState())
end

function slot0.AddListeners(slot0)
	for slot4 = 1, 2 do
		slot5 = slot0[string.format("toggle%s_", slot4)].onValueChanged

		slot5:AddListener(function (slot0)
			if slot0 then
				if uv0 == 1 then
					OperationRecorder.Record("chipManager", "pageDetail")
				elseif uv0 == 2 then
					OperationRecorder.Record("chipManager", "pageStory")
				end

				if string.format("%s", uv0 - 1) ~= uv1.toggleController_:GetSelectedState() then
					uv1:RecordStay(slot1)
				end

				uv1.toggleController_:SetSelectedState(string.format("%s", uv0 - 1))

				if uv0 == 1 then
					UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv1.skillPanel_)
					UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv1.info_)
				end
			end
		end)
	end
end

function slot0.RemoveListeners(slot0)
	for slot4 = 1, 2 do
		slot0[string.format("toggle%s_", slot4)].onValueChanged:RemoveAllListeners()
	end
end

function slot0.InitToggle(slot0)
	slot0.toggle1_.isOn = true
end

function slot0.RefreshUI(slot0)
	slot0:RefreshManagerInfo()
	slot0:RefreshLockState()
end

function slot0.OnUnlockChipManager(slot0)
	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot3 = slot0.chipManagerList_[slot1]

	slot2:SetChipManagerID(slot3)
	slot2:RefreshUI(slot3 == slot0.defaultSelectID_)
end

function slot0.RefreshManagerInfo(slot0)
	slot1 = ChipCfg[slot0.defaultSelectID_]
	slot0.chipManagerName_.text = slot1.suit_name
	slot0.skillText_.text = slot1.desc
	slot0.descText_.text = slot1.profile
	slot0.icon_.sprite = getSpriteViaConfig("ChipPortrait", slot1.portrait)
	slot0.textStory_.text = slot1.story

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillPanel_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.info_)
end

function slot0.RefreshLockState(slot0)
	slot2 = table.keyof(slot0:GetUnlockChipManagerList(), slot0.defaultSelectID_) == nil

	SetActive(slot0.regulatePanel_, not slot2)
	SetActive(slot0.lockPanel_, slot2)

	if slot2 then
		slot0.chipManagerLockView_:SetChipManagerID(slot0.defaultSelectID_)
	else
		slot0.chipManagerUnlockView_:SetChipManagerID(slot0.defaultSelectID_)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:RemoveListeners()
	slot0.chipManagerLockView_:Dispose()
	slot0.chipManagerUnlockView_:Dispose()

	if slot0.chipManagerUIList_ then
		slot0.chipManagerUIList_:Dispose()

		slot0.chipManagerUIList_ = nil
	end
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(ChipData:GetEnabledChipManagerID())
end

function slot0.GetUnlockChipManagerList(slot0)
	return ChipData:GetUnlockChipManagerIDList()
end

function slot0.GetManagerUnlockView(slot0)
	return ChipManagerUnlockView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerItem
end

function slot0.RecordStay(slot0, slot1)
	slot2 = math.floor((Time.realtimeSinceStartup - slot0.storyTime) * 1000)

	if slot1 == "1" then
		OperationRecorder.RecordStayView("STAY_VIEW_AI_STORY", slot2, slot0.defaultSelectID_)
	end

	slot0.storyTime = Time.realtimeSinceStartup
end

return slot0
