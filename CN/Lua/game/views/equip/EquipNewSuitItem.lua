slot0 = class("EquipNewSuitItem", ReduxView)
slot1 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.index_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Init(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = EquipSuitCfg[slot1.id]
		slot0.name_.text = slot2.name
		slot6 = uv0.GetSuitNeedNum(slot1.id, HeroTools.GetIsSuitNumCut(HeroData:GetHeroList()[_G.EQUIPING_HERO_ID]))
		slot0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), slot2.need)
		slot0.desc_.text = uv0.GetEffectDesc(slot2.suit_effect[1])
	end
end

function slot0.RefreshLayout(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.descTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.trs_)
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.select_, slot1)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
