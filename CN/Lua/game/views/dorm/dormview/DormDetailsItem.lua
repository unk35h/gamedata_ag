slot0 = class("DormDetailsItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.levelNum.text = slot3
	slot0.comfortNum.text = slot2
	slot0.heroName.text = HeroRecordCfg[slot1].name
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
