slot0 = class("ChessBagItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot3 = slot2.id
	slot0.artifactID_ = slot3
	slot0.textinfoText_.text = GetCfgDescription(AffixTypeCfg[WarchessItemCfg[slot3].params[1][1]].description[1], WarchessItemCfg[slot3].params[1][2])
	slot0.textnameText_.text = WarchessItemCfg[slot3].name
	slot0.iconitemImg_.sprite = getSprite("Atlas/BattleFlag", WarchessItemCfg[slot3].icon)
	slot8 = WarchessItemCfg[slot3].item_rare
	slot0.itemrareImg_.sprite = getSprite("Atlas/BattleFlag", "board_warcheese_sq_" .. slot8)
	slot0.rarebgImg_.sprite = getSprite("Atlas/BattleFlag", "bg_bfi_top_" .. slot8)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.battleflagitemBtn_, nil, function ()
		uv0.func_(uv0.index_)
	end)
end

function slot0.RegisterListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.SetSelectedState(slot0, slot1)
	slot0.controller_:SetSelectedState(slot1 and 1 or 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
