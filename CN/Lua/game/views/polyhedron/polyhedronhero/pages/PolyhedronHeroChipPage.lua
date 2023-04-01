slot0 = class("PolyhedronHeroChipPage", NewHeroChipPage)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.m_cultureBtn, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			pageIndex = 6,
			hid = uv0.heroInfo_.id
		})
	end)
end

function slot0.UpdateView(slot0)
	uv0.super.UpdateView(slot0)
	slot0.isForeignController_:SetSelectedState("true")
	SetActive(slot0.m_cultureBtn.gameObject, false)
end

return slot0
