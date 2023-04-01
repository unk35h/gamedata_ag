slot0 = class("PolyhedronSetArtifactItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.id
	slot0.id = slot2
	slot0.level = slot1.level
	slot3 = PolyhedronArtifactCfg[slot2]
	slot0.m_icon.sprite = getSpriteWithoutAtlas(PolyhedronConst.ARTIFACT_ICON_PATH .. slot3.icon)
	slot4 = slot3.affix_id
	slot5 = slot3.affix_target
	slot6 = slot1.level
	slot0.m_name.text = getAffixName({
		slot4,
		slot6,
		slot5
	})
	slot0.m_des.text = getAffixDesc({
		slot4,
		slot6,
		slot5
	})
	slot0.m_levelLab.text = "LV." .. slot6
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
