slot0 = class("ChessReviveItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.isOn_ = false

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.index_ = slot2
	slot0.headImg_.sprite = getSpriteViaConfig("HeroLittleIcon", slot1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0.func_(uv0.index_)
	end)
end

function slot0.RegisterListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 then
		slot0.controller_:SetSelectedState("sel")

		slot0.isOn_ = true
	else
		slot0.controller_:SetSelectedState("nor")

		slot0.isOn_ = false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
