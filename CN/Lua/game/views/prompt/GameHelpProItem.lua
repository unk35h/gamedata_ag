slot0 = class("GameHelpProItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.indexController_ = ControllerUtil.GetController(slot0.transform_, "index")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot1 == 1 then
		slot0.indexController_:SetSelectedIndex(0)
	elseif slot3 == slot1 then
		slot0.indexController_:SetSelectedIndex(2)
	else
		slot0.indexController_:SetSelectedIndex(1)
	end

	getSpriteWithoutAtlasAsync(slot2, function (slot0)
		uv0.m_icon.sprite = slot0
	end)
end

return slot0
