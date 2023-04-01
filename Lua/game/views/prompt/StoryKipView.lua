slot0 = class("StoryKipView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.textTyper_ = slot0.m_content.transform:GetComponent("TextTypeWrite")
	slot0.skipBtnCon_ = ControllerUtil.GetController(slot0.transform_, "skip")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.m_sureBtn, nil, function ()
		uv0:Back()

		if uv0.handler_ then
			uv0.handler_()

			uv0.handler_ = nil
		end
	end)
	slot0:AddBtnListener(slot0.m_cancelBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_maskBtn, nil, function ()
		if uv0.textTyper_:isTypeing() then
			uv0.textTyper_:ShowAllText()
		elseif uv0.handler_ then
			uv0.handler_()

			uv0.handler_ = nil
		end
	end)
end

function slot0.SetCallback(slot0, slot1)
	slot0.handler_ = slot1
end

function slot0.SetContentTitle(slot0, slot1, slot2)
	slot0.content_ = slot2
	slot0.title_ = slot1

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.skipBtnCon_:SetSelectedState(0)

	slot1 = slot0.textTyper_

	slot1:StartTyping(slot0.content_ or "", function ()
		uv0.skipBtnCon_:SetSelectedState(1)
	end)

	slot0.m_title.text = slot0.title_ or ""
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
