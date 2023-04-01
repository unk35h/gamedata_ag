slot0 = class("EquipAttrItem", ReduxView)
slot1 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.attr_ = slot0:FindCom(typeof(Text), "name")
	slot0.num_ = slot0:FindCom(typeof(Text), "num")
	slot0.bg_ = slot0:FindGo("bg")

	slot0:BindCfgUI()
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot3 = slot1.value

		if PublicAttrCfg[slot1.key].percent and slot2.percent == 1 then
			slot3 = slot1.value / 10 .. "%"
		end

		slot0.attr_.text = slot2.name
		slot0.num_.text = slot3

		if slot1.index then
			slot0:ShowBg(slot1.index % 2 == 1)
		end
	end
end

function slot0.ShowBg(slot0, slot1)
	SetActive(slot0.bg_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
