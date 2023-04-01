slot0 = class("OsirisRecallItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_button, nil, function ()
		slot0 = manager.story

		slot0:StartStoryById(uv0.id, function ()
		end)
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1

	if PlayerData:GetPlayerInfo().storylist[slot1] or false then
		slot0.m_button.interactable = true

		slot0.stateController:SetSelectedIndex(0)
	else
		slot0.m_button.interactable = false

		slot0.stateController:SetSelectedIndex(1)
	end

	slot0.m_name.text = StoryCfg[slot1] and slot4.name or ""
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
