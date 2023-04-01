slot0 = class("NewHeroSkinItem", ReduxView)

function slot0.isUnlock(slot0, slot1)
	for slot7, slot8 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot1].hero)) do
		if slot8 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isSelect(slot0, slot1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[slot1].hero).id == slot1 then
		return true
	end

	return false
end

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetDelegate(slot0, slot1)
	slot0.delegate_ = slot1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "sel")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		uv0:delegate_()
	end)
end

function slot0.Show(slot0, slot1, slot2)
	slot0.skinID_ = slot1
	slot0.index_ = slot2
	slot0.skinState_ = slot0:SkinState()

	slot0:RefreshUI()
end

function slot0.PlayAni(slot0, slot1)
	if slot0.aniTimer_ then
		slot0.aniTimer_:Stop()

		slot0.aniTimer_ = nil
	end

	slot0.itemAni_.enabled = false
	slot0.itemTrs_.localPosition = Vector3(slot0.itemTrs_.localPosition.x, -562, slot0.itemTrs_.localPosition.z)
	slot0.aniTimer_ = Timer.New(function ()
		uv0.itemAni_.enabled = true

		uv0.itemAni_:Play("aniSkinUI_item")
	end, slot1, 1)

	slot0.aniTimer_:Start()
end

function slot0.RefreshUI(slot0)
	slot1 = SkinCfg[slot0.skinID_]
	slot0.roleImg_.sprite = getSpriteViaConfig("HeroIcon", slot1.picture_id)
	slot0.nameText_.text = slot1.name

	if slot0:isUnlock(slot0.skinID_) then
		slot0.itemCanvasgroup_.alpha = 1

		SetActive(slot0.noselectGo_, false)
	else
		slot0.itemCanvasgroup_.alpha = 0.5

		SetActive(slot0.noselectGo_, true)
	end

	if slot0:isSelect(slot0.skinID_) then
		SetActive(slot0.iconGo_, true)
	else
		SetActive(slot0.iconGo_, false)
	end

	slot2 = RedPointConst.HERO_SKIN_ID_EXTEND .. slot0.skinID_

	if slot0.skinState_ == 5 or manager.redPoint:getTipBoolean(slot2) then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.SkinState(slot0)
	if slot0:isUnlock(slot0.skinID_) then
		if slot0:isSelect(slot0.skinID_) then
			return 1
		end

		return 2
	else
		if HeroTools.CanChangeSkin(slot0.skinID_) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(slot0.skinID_) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(slot0.skinID_) then
			return 4
		end

		return 3
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot0.controller_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.Dispose(slot0)
	if slot0.aniTimer_ then
		slot0.aniTimer_:Stop()

		slot0.aniTimer_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
