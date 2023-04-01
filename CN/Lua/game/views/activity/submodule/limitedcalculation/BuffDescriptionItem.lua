slot0 = class("BuffDescriptionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.levelCon_ = ControllerUtil.GetController(slot0.transform_, "level")
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.affix_ = slot1
	slot0.title_.text = AffixTypeCfg[slot0.affix_[1]].name

	slot0.levelCon_:SetSelectedState(slot0.affix_[2])

	slot0.desc_.text = getAffixDesc(slot0.affix_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
