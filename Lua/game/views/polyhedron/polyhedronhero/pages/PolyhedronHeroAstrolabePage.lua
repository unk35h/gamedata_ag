slot0 = class("PolyhedronHeroAstrolabePage", NewHeroAstrolabePage)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.m_cultureBtn, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			pageIndex = 5,
			hid = uv0.heroInfo_.id
		})
	end)
	SetActive(slot0.m_cultureBtn.gameObject, false)
end

function slot0.OnEnter(slot0, slot1)
	slot0.extra_ = slot1
	slot0.isForeign_ = slot1 and slot1.isForeign
	slot0.isTemp_ = slot1 and slot1.isTemp
	slot0.isPolyhedron_ = slot1 and slot1.isPolyhedron
	slot0.isPreview_ = slot1 and slot1.isPreview

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:OnEnter(slot0.extra_)
	end

	slot0.isSelfController_:SetSelectedState("true")
end

function slot0.SelectItem(slot0, slot1)
	if slot0.extra_ and not slot0.isPolyhedron_ then
		return
	end

	slot2 = slot1:GetItemInfo()

	JumpTools.OpenPageByJump("/astrolabeAdjust", {
		heroId = slot0.heroInfo_.id,
		selectPos = {
			slot2.posX,
			slot2.posY
		},
		extra = {
			isPolyhedron = true
		}
	})
end

return slot0
