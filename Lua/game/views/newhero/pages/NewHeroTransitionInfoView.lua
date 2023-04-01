slot0 = class("NewHeroTransitionInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.set_ = {
		"I",
		"II",
		"III",
		"IV",
		"V",
		"VI"
	}
	slot0.listCon_ = ControllerUtil.GetController(slot0.transform_, "list")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.indexCon_ = ControllerUtil.GetController(slot0.transform_, "index")
	slot0.extraCon_ = ControllerUtil.GetController(slot0.transform_, "extra")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/transitionSkill", {
			index = uv0.index_,
			heroID = uv0.heroID_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.data_ = slot2
	slot0.index_ = slot1
	slot0.isAdd_ = slot5
	slot0.extra_ = slot6
	slot0.heroID_ = slot4

	slot0.indexCon_:SetSelectedState(slot1)
	slot0.lockCon_:SetSelectedState(slot3 and "unlock" or "lock")
	slot0.extraCon_:SetSelectedState(slot0.extra_ and "true" or "false")
	slot0:RefreshData()
end

function slot0.RefreshData(slot0)
	for slot4, slot5 in ipairs(slot0.data_) do
		slot6 = slot5.skill_id
		slot7 = slot5.skill_level
		slot0["name_" .. slot4].text = EquipSkillCfg[slot6].name
		slot0["level_" .. slot4].text = GetTips("LEVEL") .. slot7
		slot0["affix_" .. slot4].sprite = getEquipSkillSprite(slot6)
		slot0["desc_" .. slot4].text = EquipTools.GetSkillDescWithoutNext(slot6, slot7, slot0.heroID_)

		SetActive(slot0["item_" .. slot4], true)
	end

	for slot4 = #slot0.data_ + 1, 2 do
		SetActive(slot0["item_" .. slot4], false)
	end

	slot0.title_.text = string.format(GetTips("EXCLUSIVE_CORE"), slot0.set_[slot0.index_])
	slot0.lockText_.text = string.format(GetTips("EQUIP_SKILL_LOCK"), slot0.set_[slot0.index_], GameSetting.exclusive_open_need.value[1])

	slot0.listCon_:SetSelectedState(#slot0.data_ > 0 and "active" or "empty")
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
