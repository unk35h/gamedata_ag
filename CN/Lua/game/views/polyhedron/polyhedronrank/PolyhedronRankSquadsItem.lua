slot0 = class("PolyhedronRankSquadsItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.SetData(slot0, slot1, slot2)
	if HeroStandardSystemCfg[slot1.id] ~= nil then
		slot0.heroID_ = HeroStandardSystemCfg[slot1.id].hero_id
	else
		slot0.heroID_ = slot1.id
	end

	slot0.typeController_:SetSelectedIndex(slot2 and 1 or 0)

	slot0.nameText_.text = HeroCfg[slot0.heroID_].name
	slot0.portraitImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. slot0.heroID_)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

return slot0
