slot0 = class("HeroDisplayExpressionView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
	slot0.dropdownItemList_ = {}
	slot0.selectHandler_ = handler(slot0, slot0.SelectPresetItem)
end

function slot0.OnShow(slot0, slot1)
	slot0.heroModel_ = slot1
	slot7 = "face"
	slot8 = slot1.transform
	slot0.skinnedMeshRenderer_ = slot0:FindCom(typeof(UnityEngine.SkinnedMeshRenderer), slot7, slot8)

	for slot7, slot8 in ipairs(HeroDisplayCfg[slot0.heroID_].skinMeshIDList) do
		if slot0.itemList_[slot7] == nil then
			slot0.itemList_[slot7] = HeroDisplayExpressionItemView.New(slot0.goItem_, slot0.transformContent_)
		end

		slot0.itemList_[slot7]:SetData(slot0.skinnedMeshRenderer_, slot7, slot8)
	end

	for slot7 = #slot3.skinMeshIDList + 1, #slot0.itemList_ do
		slot0.itemList_[slot7]:Show(false)
	end

	if HeroDisplayData:GetCacheExpressionParams().values[1] then
		for slot9, slot10 in ipairs(slot5) do
			slot0.itemList_[slot9]:SetValue(slot10)
		end
	else
		slot0:RefreshItemValue(slot0.lastPresetInext_)
	end

	SetActive(slot0.gameObject_, true)
end

function slot0.OnHide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.OnEnter(slot0, slot1)
	slot0.effectObject_ = {}
	slot0.heroID_ = slot1

	slot0:InitExpressionDropdown()
	manager.notify:RegistListener(HERO_DISPLAY_EXPRESSION_ITEM, slot0.selectHandler_)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.effectObject_) do
		Object.Destroy(slot5)
	end

	manager.notify:RemoveListener(HERO_DISPLAY_EXPRESSION_ITEM, slot0.selectHandler_)
	slot0.dropDownEffect_.options:Clear()

	slot0.effectObject_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	for slot4, slot5 in ipairs(slot0.dropdownItemList_) do
		slot5:Dispose()
	end

	slot0.dropdownItemList_ = nil
	slot0.selectHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonBg_, nil, function ()
		uv0:TryBack()
	end)
	slot0:AddToggleListener(slot0.dropDownEffect_, function (slot0)
		if slot0 == 0 then
			uv0:LoadEffect(0)
		else
			uv0:LoadEffect(HeroDisplayCfg[uv0.heroID_].effectList[slot0])
		end
	end)
	slot0:AddBtnListener(slot0.buttonPreset_, nil, function ()
		uv0:ShowDropdownPanel(true)
	end)
	slot0:AddBtnListener(slot0.buttonMask_, nil, function ()
		uv0:ShowDropdownPanel(false)
	end)
	slot0:AddBtnListener(slot0.buttonDelete_, nil, function ()
		if uv0.lastPresetInext_ <= #HeroDisplayCfg[uv0.heroID_].skinMeshPresetName + 2 then
			ShowTips("CANNOT_DELETE_PRESET")

			return
		end

		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("DELETE_PRESET"),
			OkCallback = function ()
				HeroDisplayData:InitCacheExpressionParams(uv0)
				HeroDisplayData:DeleteHeroExpressionParams(uv0, uv1)
				uv2:RemoveDropdownItem(uv1)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.InitExpressionDropdown(slot0)
	slot1 = slot0.heroID_
	slot2 = HeroDisplayCfg[slot1]

	for slot7, slot8 in ipairs(HeroDisplayData:GetHeroExpressionParams(slot1)) do
		if slot0.dropdownItemList_[slot7] == nil then
			slot0.dropdownItemList_[slot7] = HeroDisplayExpressionDropdownItem.New(slot0.goDropdownItem_, slot0.goDropdownParent_)
		end

		slot0.dropdownItemList_[slot7]:SetData(slot7, slot8.name)
	end

	if slot0.dropdownItemList_[#slot3 + 1] == nil then
		slot0.dropdownItemList_[#slot3 + 1] = HeroDisplayExpressionDropdownItem.New(slot0.goDropdownItem_, slot0.goDropdownParent_)
	end

	slot8 = #slot3 + 1
	slot9 = GetTips("SAVE_NEW_PRESET")

	slot0.dropdownItemList_[#slot3 + 1]:SetData(slot8, slot9)

	slot0.lastPresetInext_ = 1

	for slot8, slot9 in ipairs(slot0.dropdownItemList_) do
		slot9:SetSelect(slot8 == slot0.lastPresetInext_)
	end

	for slot8 = #slot3 + 2, #slot0.dropdownItemList_ do
		slot0.dropdownItemList_[slot8]:Show(false)
	end

	slot0.textPreset_.text = slot3[slot0.lastPresetInext_].name
	slot8 = UnityEngine.UI.Dropdown.OptionData.New

	slot0.dropDownEffect_.options:Add(slot8(GetTips("NONE")))

	for slot8, slot9 in ipairs(slot2.effectList) do
		slot0.dropDownEffect_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(HeroDisplayEffectCfg[slot9].name))
	end

	slot0.dropDownEffect_.value = 0
end

function slot0.AddDropdownItem(slot0, slot1)
	slot2 = slot0.heroID_
	slot3 = HeroDisplayCfg[slot2]
	slot4 = HeroDisplayData:GetHeroExpressionParams(slot2)

	slot0.dropdownItemList_[#slot4]:SetData(#slot4, slot1)

	slot5 = GetTips("SAVE_NEW_PRESET")

	if slot0.dropdownItemList_[#slot4 + 1] == nil then
		slot0.dropdownItemList_[#slot4 + 1] = HeroDisplayExpressionDropdownItem.New(slot0.goDropdownItem_, slot0.goDropdownParent_)
	end

	slot0.dropdownItemList_[#slot4 + 1]:SetData(#slot4 + 1, slot5)
end

function slot0.RemoveDropdownItem(slot0, slot1)
	slot2 = slot0.heroID_
	slot3 = HeroDisplayCfg[slot2]

	for slot8 = slot1, #HeroDisplayData:GetHeroExpressionParams(slot2) do
		slot0.dropdownItemList_[slot8]:SetData(slot8, slot4[slot8].name)
	end

	slot0.dropdownItemList_[#slot4 + 1]:SetData(i, GetTips("SAVE_NEW_PRESET"))
	slot0.dropdownItemList_[#slot4 + 2]:Show(false)
	slot0:RefreshItemValue(1)
end

function slot0.SelectPresetItem(slot0, slot1)
	slot0:ShowDropdownPanel(false)

	slot2 = slot0.heroID_
	slot3 = HeroDisplayCfg[slot2]

	if slot1 > #HeroDisplayData:GetHeroExpressionParams(slot2) then
		slot0:TrySaveData()
	else
		slot0:TrySwitchIndex(slot1)
	end
end

function slot0.RefreshItemValue(slot0, slot1)
	slot0.lastPresetInext_ = slot1

	for slot8, slot9 in ipairs(HeroDisplayData:GetHeroExpressionParams(slot0.heroID_)[slot1].values) do
		if slot0.itemList_[slot8] == nil then
			slot0.itemList_[slot8] = HeroDisplayExpressionItemView.New(slot0.goItem_, slot0.transformContent_)
		end

		slot0.itemList_[slot8]:SetValue(slot9)
	end

	slot0.dropDownEffect_.value = slot4.effectID
	slot0.textPreset_.text = slot4.name

	for slot8, slot9 in ipairs(slot0.dropdownItemList_) do
		slot9:SetSelect(slot8 == slot1)
	end
end

function slot0.ShowDropdownPanel(slot0, slot1)
	if slot1 == true then
		slot0.scrollView_.verticalNormalizedPosition = 1 - slot0.lastPresetInext_ / (#HeroDisplayData:GetHeroExpressionParams(slot0.heroID_) + 1)
	end

	SetActive(slot0.goPresetPanel_, slot1)
	SetActive(slot0.goMask_, slot1)
end

function slot0.TryBack(slot0)
	slot0:OnHide()
end

function slot0.IsChangeValue(slot0)
	if HeroDisplayData:GetHeroExpressionParams(slot0.heroID_)[slot0.lastPresetInext_].effectID ~= HeroDisplayData:GetCacheExpressionParams().effectID then
		return true
	end

	for slot9 = #slot4.values + 1, #slot5.values do
		slot4.values[slot9] = 0
	end

	return slot0:Unequal(slot4.values, slot5.values)
end

function slot0.TrySwitchIndex(slot0, slot1)
	if not slot0:IsChangeValue() then
		slot0:RefreshItemValue(slot1)

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function ()
			uv0:Back()
		end,
		closeFun = function ()
			uv0:RefreshItemValue(uv1)
		end,
		okFun = function ()
			slot0 = {
				preset = false,
				values = clone(slot3:GetCacheExpressionParams().values),
				effectID = slot1:GetCacheExpressionParams().effectID
			}
			slot3 = HeroDisplayData
			slot1 = HeroDisplayData

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function (slot0)
					return uv0:SwitchSaveData(slot0, uv1)
				end,
				delegate = function (slot0)
					if uv0:SwitchSaveData(slot0, uv1) then
						uv0:Back()
					end

					return slot1
				end
			})
		end
	})
end

function slot0.TrySaveData(slot0)
	slot1 = slot0.heroID_
	slot2 = HeroDisplayData
	slot2 = slot2:GetCacheExpressionParams()
	slot3 = {
		preset = false,
		values = clone(slot2.values),
		effectID = slot2.effectID
	}

	JumpTools.OpenPageByJump("ProposalPopup", {
		maskCloseFun = function (slot0)
			return uv0:SaveData(slot0, uv1)
		end,
		delegate = function (slot0)
			return uv0:SaveData(slot0, uv1)
		end
	})
end

function slot0.TryExitSaveData(slot0)
	if not slot0:IsChangeValue() then
		slot0:Back()

		return
	end

	JumpTools.OpenPageByJump("threeButtonBox", {
		content = GetTips("SAVE_PRESET_TIPS"),
		cancelFun = function ()
			uv0:Back()
		end,
		closeFun = function ()
			uv0:Back()
		end,
		okFun = function ()
			slot0 = uv0.heroID_
			slot1 = HeroDisplayData
			slot1 = slot1:GetCacheExpressionParams()
			slot2 = {
				preset = false,
				values = clone(slot1.values),
				effectID = slot1.effectID
			}

			JumpTools.OpenPageByJump("ProposalPopup", {
				maskCloseFun = function (slot0)
					return uv0:ExitSaveData(slot0, uv1)
				end,
				delegate = function (slot0)
					if uv0:ExitSaveData(slot0, uv1) then
						uv0:Back()
					end

					return slot1
				end
			})
		end
	})
end

function slot0.IsExceedMaxCnt(slot0)
	if GameSetting.preset_max.value[1] <= #HeroDisplayData:GetCustomExpressionParams(slot0.heroID_) then
		ShowTips("PRESET_MORE_THAN_MAX")

		return true
	end

	return false
end

function slot0.LoadEffect(slot0, slot1)
	HeroDisplayData:SetCacheExpressionEffect(slot1)

	if slot1 == 0 then
		SetActive(slot0.currentEffect_, false)

		return
	end

	if slot0.effectObject_[slot1] then
		slot0.currentEffect_ = slot0.effectObject_[slot1]

		SetActive(slot0.currentEffect_, true)
	else
		slot2 = HeroDisplayEffectCfg[slot1]
		slot0.effectObject_[slot1] = Object.Instantiate(Asset.Load("Effect/Display/" .. slot2.model), slot0:FindGo(slot2.handPointPath, slot0.heroModel_.transform).transform)
		slot5 = slot0.effectObject_[slot1].transform
		slot6 = slot2.position
		slot5.localPosition = Vector3(slot6[1], slot6[2], slot6[3])
		slot7 = slot2.rotation
		slot5.localEulerAngles = Vector3(slot7[1], slot7[2], slot7[3])
		slot0.currentEffect_ = slot0.effectObject_[slot1]
	end
end

function slot0.SwitchSaveData(slot0, slot1, slot2)
	slot2.name = slot1
	slot6 = HeroDisplayData
	slot8 = slot6

	for slot7, slot8 in ipairs(slot6.GetHeroExpressionParams(slot8, slot0.heroID_)) do
		if slot1 == slot8.name then
			if slot7 - 1 < HeroDisplayData:GetCustomStartIndex(slot3) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function ()
					HeroDisplayData:ReplaceHeroExpressionParams(uv0, uv1, uv2)
					uv3:RefreshItemValue(uv1)
					uv3:Back(2)
				end,
				CancelCallback = function ()
				end
			})

			return false
		end
	end

	if slot0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(slot3, slot2)
	slot0:AddDropdownItem(slot1)
	slot0:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(slot3))

	return true
end

function slot0.SaveData(slot0, slot1, slot2)
	slot2.name = slot1
	slot6 = HeroDisplayData
	slot8 = slot6

	for slot7, slot8 in ipairs(slot6.GetHeroExpressionParams(slot8, slot0.heroID_)) do
		if slot1 == slot8.name then
			if slot7 - 1 < HeroDisplayData:GetCustomStartIndex(slot3) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function ()
					HeroDisplayData:ReplaceHeroExpressionParams(uv0, uv1, uv2)
					uv3:RefreshItemValue(uv1)
					uv3:Back()
				end,
				CancelCallback = function ()
				end
			})

			return false
		end
	end

	if slot0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(slot3, slot2)
	slot0:AddDropdownItem(slot1)
	slot0:RefreshItemValue(#HeroDisplayData:GetHeroExpressionParams(slot3))

	return true
end

function slot0.ExitSaveData(slot0, slot1, slot2)
	slot2.name = slot1
	slot6 = HeroDisplayData
	slot8 = slot6

	for slot7, slot8 in ipairs(slot6.GetHeroExpressionParams(slot8, slot0.heroID_)) do
		if slot1 == slot8.name then
			if slot7 - 1 < HeroDisplayData:GetCustomStartIndex(slot3) then
				ShowTips("CANNOT_REPLACE_PRESET")

				return false
			end

			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("REPLACE_SAME_PRESET"),
				OkCallback = function ()
					HeroDisplayData:ReplaceHeroExpressionParams(uv0, uv1, uv2)
					uv3:Back(3)
				end,
				CancelCallback = function ()
				end
			})

			return false
		end
	end

	if slot0:IsExceedMaxCnt() then
		return false
	end

	HeroDisplayData:SaveHeroExpressionParams(slot3, slot2)
	slot0:Back()

	return true
end

return slot0
