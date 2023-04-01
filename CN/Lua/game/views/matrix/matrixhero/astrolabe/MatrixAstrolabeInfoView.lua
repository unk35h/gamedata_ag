slot1 = class("MatrixAstrolabeInfoView", import("game.views.astrolabe.AstrolabeInfoView"))

function slot1.RefreshUI(slot0, slot1, slot2)
	if slot1 then
		slot3 = HeroAstrolabeCfg[slot1.id]
		slot0.desText_.text = string.format("<size=32><color=#FFFFFF>%s——%s\n\n</color></size>", GetI18NText(slot3.suit_name), GetI18NText(slot3.name)) .. GetI18NText(SkillTools.GetAstrolabeDescByServant(slot1.id, slot2))
	end
end

return slot1
