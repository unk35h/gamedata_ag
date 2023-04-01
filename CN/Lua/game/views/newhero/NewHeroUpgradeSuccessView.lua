slot0 = class("NewHeroUpgradeSuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroUpgradeSuccessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.fromPropValueTexts_ = {
		slot0.fromValue1_,
		slot0.fromValue2_,
		slot0.fromValue3_
	}
	slot0.toPropValueTexts_ = {
		slot0.toValue1_,
		slot0.toValue2_,
		slot0.toValue3_
	}
	slot0.propNames_ = {
		slot0.propName1_,
		slot0.propName2_,
		slot0.propName3_
	}
	slot0.propIndexes_ = {
		1,
		2,
		3
	}

	for slot4 = 1, 3 do
		slot0.propNames_[slot4].text = PublicAttrCfg[slot0.propIndexes_[slot4]].name
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
		uv0.params_.callback()
	end)
end

function slot0.OnEnter(slot0)
	slot0.oldLv_ = slot0.params_.oldLv
	slot0.oldAttr_ = slot0.params_.oldAttr
	slot0.heroInfo_ = HeroData:GetHeroList()[slot0.params_.heroId]
	slot0.newAttr_ = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, EquipTools.CalHeroEquipAttribute(slot0.heroInfo_.equip, slot0.heroInfo_.id))

	HeroTools.CalFinalAttribute(slot0.newAttr_)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot4 = "%d"
	slot0.toLevelText_.text = string.format(slot4, slot0.heroInfo_.level)

	for slot4 = 1, 3 do
		slot0.fromPropValueTexts_[slot4].text = slot0.oldAttr_[slot4]
		slot0.toPropValueTexts_[slot4].text = slot0.newAttr_[slot4]
	end

	slot0:PlayHeroTalk(slot0.heroInfo_.id)
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "expup")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, HeroConst.LEVEL_UPGRADE_VOICE_CD, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	slot0.isTalkCD_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
