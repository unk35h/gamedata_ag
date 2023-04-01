slot0 = class("EquipNewHeroSkillItem2", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_({
				skillID = uv0.skillID_,
				lv = uv0.level_,
				race = uv0.heroID_,
				isAdd = uv0.isAdd_
			})
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.data_ = slot1
	slot0.skillID_ = slot2
	slot0.level_ = slot3
	slot0.isAdd_ = slot4
	slot0.heroID_ = slot5

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = EquipSkillCfg[slot0.skillID_]

	if slot0.isAdd_ == 1 then
		slot0.skillLv_.text = "<color=#E57725>" .. GetTips("LEVEL") .. slot0.level_ + slot0.isAdd_ .. "</color>"
	else
		slot0.skillLv_.text = GetTips("LEVEL") .. slot0.level_
	end

	slot0.skillName_.text = slot1.name
	slot0.skillDesc_.text = EquipTools.GetSkillDesc(slot0.skillID_, slot0.level_, slot0.heroID_)
	slot0.skillIcon_.sprite = getEquipSkillSprite(slot0.skillID_)
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.select_, slot1)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	slot0.clickFunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
