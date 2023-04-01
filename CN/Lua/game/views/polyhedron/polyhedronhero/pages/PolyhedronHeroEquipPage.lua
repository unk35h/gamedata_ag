slot0 = class("PolyhedronHeroEquipPage", NewHeroEquipPage)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:HideMaskMessage()
	end)

	slot1 = slot0.equipInfoView_

	slot1:RegistCallBack(function (slot0)
		if slot0.prefab_id or uv0.extra_ then
			uv0:EquipClick(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.m_cultureBtn, nil, function ()
		uv0:Go("/newHero", {
			isEnter = true,
			pageIndex = 4,
			hid = uv0.heroInfo_.id
		})
	end)
	SetActive(slot0.m_cultureBtn.gameObject, false)
end

function slot0.EquipClick(slot0, slot1)
	uv0.super.EquipClick(slot0, slot1)
	slot0.foreignEquipInfoView_:SetState("equipped")
end

return slot0
