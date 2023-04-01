slot0 = class("MatrixProcessRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.m_des1 = slot0.m_des1Go:GetComponent("ExtendText")
	slot0.extendScrollRect = slot0.m_des1Go:GetComponent("ScrollRect")
	slot0.selectedController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "selected")
	slot0.typeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot4 = "rare"
	slot0.rareController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.astrolabeImgs_ = {}

	for slot4 = 1, 3 do
		table.insert(slot0.astrolabeImgs_, slot0["m_astrolabeImg" .. slot4])
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.SetDesc(slot0, slot1)
	slot0.m_des1:Hide()
	slot0.m_des1:SetText(slot1)

	slot0.m_des2.text = slot1
	slot0.extendScrollRect.verticalNormalizedPosition = 1
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.index = slot2
	slot3 = MatrixItemCfg[slot1]
	slot0.m_name1.text = slot3.name
	slot0.m_name2.text = slot3.name

	slot0:SetDesc(slot0:GetItemDes(slot1))
	slot0.rareController_:SetSelectedIndex(slot3.rare - 1)

	slot5 = slot3.matrix_item_type

	slot0.typeController_:SetSelectedIndex(slot5 - 1)

	if slot5 == MatrixConst.ITEM_TYPE.ASTROLABE then
		slot0:UpdateAstrolabePreview()

		slot0.m_suit_name.text = slot3.name
	elseif slot5 == MatrixConst.ITEM_TYPE.EQUIP then
		slot0.m_equipImg.sprite = MatrixTools.GetMatrixItemSprite(slot1)
	elseif slot5 == MatrixConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.m_weaponImg.sprite = MatrixTools.GetMatrixItemSprite(slot1)

		if MatrixTools.GetWeaponSpecHero(slot3.params[1]) ~= 0 then
			-- Nothing
		end
	elseif slot5 == MatrixConst.ITEM_TYPE.TREASURE then
		slot0.m_treasureImg.sprite = MatrixTools.GetMatrixItemSprite(slot1)
	elseif slot5 == MatrixConst.ITEM_TYPE.ITEM then
		slot0.m_itemImg.sprite = MatrixTools.GetMatrixItemSprite(slot1)
	elseif slot5 == MatrixConst.ITEM_TYPE.EFFECT then
		slot0.m_buffImg.sprite = MatrixTools.GetMatrixItemSprite(slot1)
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.UpdateAstrolabePreview(slot0)
	if MatrixItemCfg[slot0.id].matrix_item_type ~= MatrixConst.ITEM_TYPE.ASTROLABE then
		return
	end

	slot3 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1.params[1]]
	slot4 = math.floor(slot1.params[1] / 1000)
	slot12 = slot0:GetHeroSkin(slot4)
	slot0.m_heroImg.sprite = getSpriteViaConfig("HeroLittleIcon", slot12)
	slot11 = slot0:GetHeroData(slot4):GetAstrolabeNum(slot1.params[1]) + 1
	slot6 = math.min(3, slot11)

	for slot11, slot12 in ipairs(slot0.astrolabeImgs_) do
		if slot11 <= slot6 then
			SetActive(slot12.gameObject, true)

			slot12.sprite = MatrixTools.GetMatrixItemSprite(slot0.id)
		else
			SetActive(slot12.gameObject, false)
		end
	end

	if slot6 > 0 then
		slot8 = slot3[slot6]

		slot0:SetDesc(GetCfgDescription(AstrolabeEffectCfg[slot8].desc[1], 1))

		slot12 = HeroAstrolabeCfg[slot8]
		slot0.m_name1.text = slot12.name
		slot0.m_name2.text = slot12.name
	else
		slot0:SetDesc(slot1.desc)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.GetHeroData(slot0, slot1)
	return MatrixData:GetHeroData(slot1)
end

function slot0.GetHeroSkin(slot0, slot1)
	return MatrixData:GetHeroSkin(slot1)
end

function slot0.GetItemDes(slot0, slot1)
	return MatrixTools.GetMatrixItemDes(slot1)
end

return slot0
