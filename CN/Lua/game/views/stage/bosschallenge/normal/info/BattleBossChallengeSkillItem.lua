slot0 = class("BattleBossChallengeSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
end

function slot0.SetText(slot0, slot1, slot2)
	slot0.textName_.text = slot1
	slot0.textDesc_.text = slot2

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transformDesc_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
