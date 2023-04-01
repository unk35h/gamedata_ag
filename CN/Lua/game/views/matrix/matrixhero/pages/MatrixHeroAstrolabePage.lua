slot1 = class("MatrixHeroAstrolabePage", import("game.views.newHero.pages.NewHeroAstrolabePage"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.m_content)

	slot0.infoSGo_ = {}
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.adjustBtn_, nil, function ()
		JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
			heroId = uv0.heroInfo_.id,
			selectPos = {
				0
			}
		})
	end)
end

function slot1.OnEnter(slot0)
end

function slot1.SelectItem(slot0, slot1)
	slot2 = slot1:GetItemInfo()

	JumpTools.OpenPageByJump("matrixOrigin/matrixAstrolabeAdjust", {
		heroId = slot0.heroInfo_.id,
		selectPos = {
			slot2.posX,
			slot2.posY
		}
	})
end

function slot1.SetMatirxHeroInfo(slot0, slot1)
	slot0.heroId_ = slot1
	slot2 = slot0:GetHeroData(slot1)
	slot4 = nil
	slot0.heroInfo_ = (not slot2:GetIsOwnerHero() or GetPracticalData(slot2:GetEntrySnapShot())) and GetVirtualData(slot2:GetStandardId())
	slot0.heroInfo_.using_astrolabe = slot2:GetAstrolabeEffectList()
	slot0.heroInfo_.unlocked_astrolabe = HeroAstrolabeCfg.all
	slot0.heroInfo_.servantId = slot2:GetWeaponServantEffect()

	slot0:UpdateView()

	slot0.m_countLab.text = #slot2:GetAstrolabeEffectList() .. "/" .. slot0:GetAstrolabeMaxCount()
end

function slot1.UpdateNotice(slot0)
end

function slot1.RefreshAstrolabeEffect(slot0)
	slot3 = #AstrolabeTools.GetAcitveEffect(slot0.heroInfo_.using_astrolabe) > 0
	slot4 = ""

	for slot8 = 1, slot2 do
		slot15 = GetI18NText
		slot4 = slot4 .. string.format("<size=32><color=#FFFFFF>%s\n\n</color></size>", slot15(HeroAstrolabeCfg[HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1[slot8].id][1]].suit_name))

		for slot15 = 1, slot1[slot8].num do
			slot4 = slot4 .. GetI18NText(SkillTools.GetAstrolabeDescByServant(slot9[slot15], slot0.heroInfo_.servantId)) .. (slot15 == slot11 and "" or "\n\n")
		end

		slot4 = slot4 .. (slot8 == slot2 and "" or "\n\n")
	end

	SetActive(slot0.nullGo_, not slot3)
	SetActive(slot0.desGo_, slot3)

	slot0.desText_.text = slot4
end

function slot1.GetHeroAstrolabeInfoView(slot0)
	return MatrixHeroAstrolabeInfoView
end

function slot1.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot1.GetAstrolabeMaxCount(slot0)
	return MatrixData:GetAstrolabeMaxCount()
end

return slot1
