slot0 = class("SignToggleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot1

	if slot2:RedPointKey() then
		manager.redPoint:bindUIandKey(slot0.transform_, slot2:RedPointKey())
	end

	slot0.m_title.text = slot2:Title()
	slot0.m_selectTitle.text = slot2:Title()
	slot0.m_icon.sprite, slot0.m_selectIcon.sprite = slot2:Image()

	if PlayerData:GetPlayerInfo().userLevel < slot2:GetLimitLevel() then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.SetSelect(slot0, slot1)
	if slot0.index == slot1 then
		slot0.selectController:SetSelectedIndex(1)
	else
		slot0.selectController:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
	uv0.super.Dispose(slot0)
end

return slot0
