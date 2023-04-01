slot0 = class("", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(slot1, slot1.transform.parent.transform)
	slot0.transform_ = slot1.transform

	SetActive(slot0.gameObject_, true)
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
	slot0.textinfoText_.text = GetCfgDescription(AffixTypeCfg[WarchessItemCfg[slot2].params[1][1]].description[1], WarchessItemCfg[slot2].params[1][2])
	slot0.textnameText_.text = WarchessItemCfg[slot2].name
	slot0.iconitemImg_.sprite = getSprite("Atlas/BattleFlag", WarchessItemCfg[slot2].icon)
	slot7 = WarchessItemCfg[slot2].item_rare
	slot0.itemrareImg_.sprite = getSprite("Atlas/BattleFlag", "board_warcheese_sq_" .. slot7)
	slot0.rarebgImg_.sprite = getSprite("Atlas/BattleFlag", "bg_bfi_top_" .. slot7)
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.selecttglTgl_, function (slot0)
		uv0.func(slot0, uv0.index_)
		OperationRecorder.Record("chess", "select_artifact")
	end)
end

function slot0.RegisterListener(slot0, slot1)
	slot0.func = slot1
end

function slot0.ResetToggle(slot0)
	slot0.selecttglTgl_.isOn = false
end

function slot0.SetSelectState(slot0, slot1)
	slot0.controller_:SetSelectedState(slot1 and 1 or 3)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
