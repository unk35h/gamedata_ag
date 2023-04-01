slot0 = class("ChessLogItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "conName")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = WarchessContentCfg[slot2]
	slot0.textinfoText_.text = slot3.content
	slot0.textnameText_.text = slot3.name
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("Textures/Story/Character/" .. WarchessLevelCfg[WarChessData:GetCurrentWarChessMapData().mapId].log_icon)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
