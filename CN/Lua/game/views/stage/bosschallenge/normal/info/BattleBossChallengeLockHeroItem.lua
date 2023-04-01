slot0 = class("BattleBossChallengeLockHeroItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.RefreshHeroItem(slot0, slot1)
	slot0.imageIcon_.sprite = HeroTools.GetSmallHeadSprite(slot1)
end

function slot0.SetActive(slot0, slot1, slot2)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RefreshHeroItem(slot2)
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
