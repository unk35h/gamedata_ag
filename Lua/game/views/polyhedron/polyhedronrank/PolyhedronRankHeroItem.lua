slot0 = class("PolyhedronRankHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.heroID_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.heroID_ = slot1
	slot0.scoreText_.text = PolyhedronData:GetMyHeroRankList()[slot1] and slot2.rankData.score or 0
	slot0.nameText_.text = HeroCfg[slot0.heroID_].name
	slot0.portraitImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. slot0.heroID_)
end

function slot0.SetSelect(slot0, slot1)
	if slot1 == slot0.heroID_ then
		slot0.selectController_:SetSelectedState("true")
	else
		slot0.selectController_:SetSelectedState("false")
	end
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

return slot0
