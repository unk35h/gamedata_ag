slot0 = class("DrawTenTimesRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.shareStartHandler_ = handler(slot0, slot0.ShareStart)
	slot0.shareEndHandler_ = handler(slot0, slot0.ShareEnd)

	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_START, slot0.shareStartHandler_)
	manager.notify:RegistListener(SHAER_DAW_TEN_TIMES_END, slot0.shareEndHandler_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemController_ = ControllerUtil.GetController(slot0.transform_, "item")
	slot0.switchController_ = ControllerUtil.GetController(slot0.transform_, "switch")
	slot0.rateController_ = ControllerUtil.GetController(slot0.transform_, "rare")
	slot0.starController_ = ControllerUtil.GetController(slot0.transform_, "star")
	slot0.item = CommonItem.New(slot0.m_item)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1
	slot3 = ItemCfg[slot1.id]
	slot4 = slot3.type
	slot5 = slot3.display_rare

	slot0.starController_:SetSelectedIndex(math.min(slot5, 5))

	if slot5 >= 5 then
		slot0.rateController_:SetSelectedIndex(0)
	elseif slot5 >= 4 then
		slot0.rateController_:SetSelectedIndex(1)
	else
		slot0.rateController_:SetSelectedIndex(2)
	end

	SetActive(slot0.m_newTag, slot1.newTag)

	if slot4 == ItemConst.ITEM_TYPE.HERO then
		slot0.itemController_:SetSelectedIndex(0)

		slot0.m_camp.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[HeroCfg[slot2].race].icon)
		slot0.m_portrait.sprite = getSpriteWithoutAtlas("Textures/Character/Icon/" .. slot2)

		if slot1.convert then
			slot0.switchController_:SetSelectedIndex(1)
			slot0.item:RefreshData(slot1)
			slot0.m_switchAnimator:Play("CommonItem_zhuanhua", 0, 0)

			slot0.timer = Timer.New(function ()
				uv0.item:RefreshData(uv1.convert)

				uv0.timer = nil
			end, 1, 1)

			slot0.timer:Start()
		else
			slot0.switchController_:SetSelectedIndex(0)
		end
	elseif slot4 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.itemController_:SetSelectedIndex(1)

		slot0.m_camp.sprite = getSprite("Atlas/CampItem", RaceEffectCfg[WeaponServantCfg[slot2].race].icon)
		slot0.m_weaponName.text = string.split(slot3.name or "", "·")[1]
		slot0.m_weaponImg.sprite = getSpriteWithoutAtlas(SpritePathCfg.ServantIcon.path .. slot3.icon)
	end
end

function slot0.ShareStart(slot0)
	if ItemCfg[slot0.data_.id].type == ItemConst.ITEM_TYPE.HERO then
		slot0.switchController_:SetSelectedIndex(0)
	end
end

function slot0.ShareEnd(slot0)
	if ItemCfg[slot0.data_.id].type == ItemConst.ITEM_TYPE.HERO and slot1.convert then
		slot0.switchController_:SetSelectedIndex(1)
	end
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_START, slot0.shareStartHandler_)
	manager.notify:RemoveListener(SHAER_DAW_TEN_TIMES_END, slot0.shareEndHandler_)

	slot0.shareStartHandler_ = nil
	slot0.shareEndHandler_ = nil

	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnExit(slot0)
	slot0.switchController_:SetSelectedIndex(0)
end

return slot0
