slot0 = class("HeroArchiveToggle", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(slot1, slot1.transform.parent.transform)
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0, slot1)
	slot0.func_ = slot1

	slot0:AddToggleListener(slot0.noumenonTgl_, function (slot0)
		if slot0 then
			uv0.func_(uv0.heroID_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	SetActive(slot0.gameObject_, true)

	slot0.heroID_ = slot1
	slot0.selecttextText_.text = HeroCfg[slot1].name
	slot0.selecticonImg_.sprite = getSpriteViaConfig("HeroLittleIcon", HeroTools.HeroUsingSkinInfo(slot0.heroID_).id)
	slot0.noumenonTgl_.isOn = slot2

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.selectTrans_)
end

function slot0.OnExit(slot0)
	slot0.noumenonTgl_.isOn = false

	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
