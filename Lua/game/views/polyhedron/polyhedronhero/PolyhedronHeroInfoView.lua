slot0 = class("PolyhedronHeroInfoView", NewHeroInfoView)

function slot0.UpdateView(slot0)
	slot0.nameText_.text = slot0.heroCfg_.name
	slot0.subNameText_.text = slot0.heroCfg_.suffix

	if HeroData:GetHeroData(slot0.heroInfo_.id).unlock == 0 then
		slot0.isUnlockController_:SetSelectedIndex(0)
		slot0:UpdateLockedView()
	elseif not PolyhedronData:GetPolyhedronHeroUnlock(slot1) then
		slot0.isUnlockController_:SetSelectedIndex(2)
		slot0:UpdateLockedView()

		slot0.m_polyhedronHeroDes.text = slot0.heroCfg_.hero_desc
		slot0.m_polyhedronUnlockIcon.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS)

		if not slot0.textStateController_ then
			slot0.textStateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "textState")
		end

		slot0.textStateController_:SetSelectedState(CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) > 0 and "true" or "false")

		slot0.m_polyhedronUnlockNum.text = 1
	else
		slot0.isUnlockController_:SetSelectedIndex(1)
		slot0:UpdateUnlockedView()
	end

	slot0.pieceEnoughController_:SetSelectedIndex(2)
	slot0.campController_:SetSelectedState(tostring(slot0.heroCfg_.race))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_polyhedronUnlockBtn, nil, function ()
		PolyhedronAction.QueryUnlockHero(uv0.heroCfg_.id)
	end)
	slot0:AddBtnListener(slot0.m_powerBtn, nil, function ()
		JumpTools.OpenPageByJump("heroAttribute", {
			heroID = uv0.heroInfo_.id,
			extra = {
				isPolyhedron = true
			}
		})
	end)
	slot0:AddBtnListener(slot0.campBgBtn_, nil, function ()
		JumpTools.OpenPageByJump("heroRaceDetails")
	end)
end

function slot0.OnPolyhedronHeroUnlock(slot0)
	JumpTools.GoToSystem("/polyhedronHero", nil, ViewConst.SYSTEM_ID.HERO)
end

return slot0
