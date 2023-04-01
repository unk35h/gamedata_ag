slot0 = class("MatrixSelectHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = 0

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.m_statetController, "state")
	slot0.captainController_ = ControllerUtil.GetController(slot0.m_statetController, "captain")
	slot0.lockController = ControllerUtil.GetController(slot0.m_statetController, "lock")
	slot0.levelController = ControllerUtil.GetController(slot0.m_statetController, "level")
end

function slot0.CheckHeroLock(slot0, slot1)
	slot2 = GameSetting.matrix_singularity_hero_level_limited.value[1]

	if not HeroData:GetHeroData(slot1) or slot3.unlock ~= 1 then
		return true, GetTips("MATRIX_SINGULARITY_HERO_UNLOCK")
	elseif slot3.level < slot2 then
		return true, string.format(GetTips("MATRIX_SINGULARITY_HERO_LEVEL_UNLOCK"), slot2)
	end

	return false
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.difficulty == 3 then
			slot0, slot1 = uv0:CheckHeroLock(uv0.heroId)

			if slot0 then
				ShowTips(slot1)

				return
			end
		end

		if uv0.clickFunc then
			uv0.clickFunc()
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4)
	slot0.heroStandardId = slot1

	if not HeroStandardSystemCfg[slot1] then
		return
	end

	slot6 = slot5.hero_id
	slot0.m_icon.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[MatrixData:GetHeroSkin(slot6) or slot6].picture_id)
	slot0.m_name.text = HeroCfg[slot6].name
	slot0.m_tip.text = slot5.hero_desc or ""
	slot0.difficulty = slot4
	slot0.heroId = slot6

	if slot4 == 3 then
		slot10 = HeroData:GetHeroData(slot6)

		if slot0:CheckHeroLock(slot6) then
			slot2 = 2

			slot0.lockController:SetSelectedIndex(1)
			slot0.levelController:SetSelectedIndex(0)
		else
			slot0.lockController:SetSelectedIndex(0)
			slot0.levelController:SetSelectedIndex(1)

			slot0.m_levelLab.text = slot10.level
		end

		slot0.m_clickBtn.interactable = true
	else
		slot0.lockController:SetSelectedIndex(0)
		slot0.levelController:SetSelectedIndex(0)

		slot10 = slot0.m_clickBtn
		slot11 = slot2 == 0 or slot2 == 1
		slot10.interactable = slot11
	end

	slot0.stateController_:SetSelectedIndex(slot2)
	slot0.captainController_:SetSelectedIndex(slot3 and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
