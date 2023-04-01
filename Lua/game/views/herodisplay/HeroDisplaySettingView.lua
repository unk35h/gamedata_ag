slot0 = class("HeroDisplaySettingView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot2 = GetTips("LEFT_TOP")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))

	slot2 = GetTips("LEFT_BOTTOM")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))

	slot2 = GetTips("RIGHT_TOP")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))

	slot2 = GetTips("RIGHT_BOTTOM")

	slot0.dropDownLogo_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))
	slot0.dropDownCard_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(slot2))
end

function slot0.OnEnter(slot0)
	slot1 = HeroDisplayData:GetSetting()
	slot0.dropDownLogo_.value = slot1.logoPos
	slot0.toggleCard_.isOn = slot1.cardShow
	slot0.dropDownCard_.value = slot1.cardPos
	slot0.toggleLevel_.isOn = slot1.cardShowLv
	slot0.toggleUID_.isOn = slot1.cardShowUID

	slot0:RefreshInteractable(slot1.cardShow)
end

function slot0.RefreshInteractable(slot0, slot1)
	slot0.dropDownCard_.interactable = slot1
	slot0.toggleLevel_.interactable = slot1
	slot0.toggleUID_.interactable = slot1

	manager.effect:SetGrey(slot0.imageUID_, not slot1)
	manager.effect:SetGrey(slot0.imageLv_, not slot1)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonCancel_, nil, function ()
		uv0:OnExit()
		SetActive(uv0.gameObject_, false)
	end)
	slot0:AddBtnListener(slot0.buttonOk_, nil, function ()
		HeroDisplayData:SaveSetting({
			logoPos = uv0.dropDownLogo_.value,
			cardShow = uv0.toggleCard_.isOn,
			cardPos = uv0.dropDownCard_.value,
			cardShowLv = uv0.toggleLevel_.isOn,
			cardShowUID = uv0.toggleUID_.isOn
		})
		uv0:OnExit()
		SetActive(uv0.gameObject_, false)
	end)
	slot0:AddToggleListener(slot0.dropDownLogo_, function (slot0)
		if uv0.dropDownCard_.value == slot0 then
			if slot0 == 0 then
				uv0.dropDownCard_.value = 1
			else
				uv0.dropDownCard_.value = 0
			end
		end
	end)
	slot0:AddToggleListener(slot0.dropDownCard_, function (slot0)
		if uv0.dropDownLogo_.value == slot0 then
			if slot0 == 0 then
				uv0.dropDownLogo_.value = 1
			else
				uv0.dropDownLogo_.value = 0
			end
		end
	end)
	slot0:AddToggleListener(slot0.toggleCard_, function (slot0)
		uv0:RefreshInteractable(slot0)
	end)
end

return slot0
