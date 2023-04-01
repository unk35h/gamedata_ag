slot0 = class("SkillSelectItem", ReduxView)
slot1 = import("game.const.EquipConst")
slot2 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0.bg_ = slot0:FindGo("bg")
	slot0.icon_ = slot0:FindCom(typeof(Image), "icon")
	slot0.name_ = slot0:FindCom(typeof(Text), "name")
	slot0.numGo_ = slot0:FindGo("num")

	if slot0.numGo_ then
		slot0.num_ = slot0:FindCom(typeof(Text), "num")
	end

	slot0.maskGo_ = slot0:FindGo("mask")

	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Init(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		if slot1.id ~= 0 then
			slot2 = EquipSkillCfg[slot1.id]
			slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", slot2.icon)
			slot0.name_.text = slot2.name
		else
			slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", "sifting_all")
			slot0.name_.text = GetTips("ALL")
		end
	end
end

function slot0.SetIndex(slot0, slot1)
	slot0.transform_:SetSiblingIndex(slot1)
end

function slot0.SetBottomText(slot0, slot1)
	if slot0.num_ then
		slot0.num_.text = slot1

		if slot0.maskGo_ then
			SetActive(slot0.maskGo_, slot1 == 0)
		end
	end
end

function slot0.RefreshPos(slot0, slot1)
	slot0:SetBottomText(uv0.GetEquipSkillNum(slot0.info_.id, nil, slot1))
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.info_ = nil
	slot0.clickFunc = nil

	uv0.super.Dispose(slot0)
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

return slot0
