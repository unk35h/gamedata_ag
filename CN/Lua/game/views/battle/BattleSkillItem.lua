slot0 = class("BattleSkillItem", ReduxView)
slot1 = import("game.const.HeroConst")

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.info_ = slot3

	SetActive(slot0.gameObject_, true)
	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.typeIcon_ = slot0:FindCom(typeof(Image), "type")
	slot0.lvText_ = slot0:FindCom(typeof(Text), "level")
	slot0.nameText_ = slot0:FindCom(typeof(Text), "name")
	slot0.desText_ = slot0:FindCom(typeof(Text), "des")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.lvText_.text = "LEVEL " .. (slot1.lv or 1)
end

return slot0
