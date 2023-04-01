slot0 = class("AttributeItem", ReduxView)
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
	slot0.icon_ = slot0:FindCom(typeof(Image), "icon")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot3 = math.floor(slot1.value)

		if PublicAttrCfg[slot1.key].percent and slot2.percent == 1 then
			slot3 = slot1.value / 10 .. "%"
		end

		slot0.num_.text = slot3
		slot0.numNoAdd_ = slot3

		if slot1.race == slot1.heroId then
			slot5 = math.floor(slot1.value * (GameSetting.equip_hero_strengthen_num.value[1] - 1))

			if slot2.percent and slot2.percent == 1 then
				slot5 = math.floor(slot1.value * slot4 / 10) .. "%"
			end

			slot0.numAdd_ = slot3 .. "[+" .. slot5 .. "]"
		elseif slot1.race and slot1.race ~= 0 then
			slot4 = math.floor(slot1.value * 0.2)

			if slot2.percent and slot2.percent == 1 then
				slot4 = math.floor(slot1.value / 10 * 0.2) .. "%"
			end

			slot0.numAdd_ = slot3 .. "[+" .. slot4 .. "]"
		else
			slot0.numAdd_ = slot3
		end

		slot0.attr_.text = slot2.name
		slot0.icon_.sprite = getSprite("Atlas/Common", slot2.icon)
	end
end

function slot0.ShowAdd(slot0, slot1)
	if slot1 then
		slot0.num_.text = slot0.numAdd_
	else
		slot0.num_.text = slot0.numNoAdd_
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
