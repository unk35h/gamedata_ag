slot0 = class("GameOperationSettingView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "page"
	slot0.pageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.classes_ = {
		GameMobileOperationView,
		GameGamepadOperationView,
		GameKeyboardOperationView
	}
	slot0.gameObjects_ = {
		slot0.mobileGo_,
		slot0.gamepadGo_,
		slot0.keyboardGo_
	}
	slot0.pages_ = {}

	for slot4 = 1, 3 do
		table.insert(slot0.pages_, slot0.classes_[slot4].New(slot0.gameObjects_[slot4]))
	end

	slot0.toggles_ = {
		slot0.toggle1_,
		slot0.toggle2_,
		slot0.toggle3_
	}

	slot0:OnEnter()
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SwitchToPage(uv1)
			end
		end)
	end
end

function slot0.SwitchToPage(slot0, slot1)
	slot5 = slot1 - 1

	slot0.pageController_:SetSelectedIndex(slot5)

	for slot5, slot6 in pairs(slot0.pages_) do
		slot6:UpdatePageData()
	end
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:OnExit()
	end
end

function slot0.SaveData(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:SaveData()
		end
	end
end

function slot0.CheckDataChange(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			if slot5:CheckDataChange() then
				return true
			end
		end
	end

	return false
end

function slot0.RecoverTmpData(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:RecoverTmpData()
		end
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
