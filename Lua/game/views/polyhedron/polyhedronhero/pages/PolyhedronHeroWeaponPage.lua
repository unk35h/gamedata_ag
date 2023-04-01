slot0 = class("PolyhedronHeroWeaponPage", NewHeroWeaponPage)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_cultureBtn, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			pageIndex = 3,
			hid = uv0.heroInfo_.id
		})
	end)
	SetActive(slot0.m_cultureBtn.gameObject, false)
end

function slot0.RefreshWeapon(slot0)
	uv0.super.RefreshWeapon(slot0)
	SetActive(slot0.moduleView_.gameObject, false)
end

return slot0
