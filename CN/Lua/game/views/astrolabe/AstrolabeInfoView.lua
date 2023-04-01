slot0 = class("AstrolabeInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	if slot1 then
		slot3 = HeroAstrolabeCfg[slot1.id]
		slot0.desText_.text = string.format("<size=32><color=#FFFFFF>%s——%s\n\n</color></size>", GetI18NText(slot3.suit_name), GetI18NText(slot3.name)) .. GetI18NText(SkillTools.GetAstrolabeDesc(slot1.id, slot1.heroId, slot2))
	end
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
