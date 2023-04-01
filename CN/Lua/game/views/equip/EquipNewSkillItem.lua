slot0 = class("EquipNewSkillItem", ReduxView)
slot1 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:InitUI()
	slot0:Init()
end

function slot0.SetIsEnchant(slot0, slot1, slot2)
	slot0.isEnchant_ = true
	slot0.index_ = slot1
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "locked")

	slot0:AddBtnListener(slot0.lockbtn_, nil, function ()
		uv0(uv1.index_)
	end)
end

function slot0.SetLockStatus(slot0, slot1)
	if slot1 then
		slot0.lockController_:SetSelectedState("true")
	else
		slot0.lockController_:SetSelectedState("false")
	end
end

function slot0.RefreshData(slot0, slot1, slot2, slot3, slot4)
	slot0.data_ = slot1
	slot0.info_ = slot2
	slot0.lvmax_ = slot3
	slot0.isFullDes_ = slot4 == nil and true or slot4

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.Render(slot0)
	slot0:RefreshUI(slot0.info_)
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot2 = EquipSkillCfg[slot1.id]
		slot0.icon_.sprite = getSprite("Atlas/EquipSkillIconAtlas", slot2.icon)
		slot0.name_.text = slot2.name

		if slot1.level < (slot1.unlockLevel or 0) then
			slot0.unlockLv_.text = string.format(GetTips("EQUIP_SKILL_LOCK_LEVEL"), slot1.unlockLevel)

			SetActive(slot0.unlockGo_, true)
		else
			SetActive(slot0.unlockGo_, false)
		end

		if slot0.canvasGroup_ then
			slot0.canvasGroup_.alpha = slot1.level < slot3 and 0.7 or 1
		end

		slot4 = slot0.lvmax_ and "/" .. slot2.lvmax or ""

		if slot1.isAdd then
			if slot0.isFullDes_ then
				slot0.lv_.text = "<color=#E57725>" .. GetTips("LEVEL") .. slot1.num .. slot4 .. "</color>"
			else
				slot0.lv_.text = GetTips("LEVEL") .. "<color=#E57725>" .. slot1.num .. "</color>" .. slot4
			end
		else
			slot0.lv_.text = GetTips("LEVEL") .. slot1.num .. slot4
		end

		slot7 = string.format(GetI18NText(slot2.desc), tostring(slot2.upgrade / slot2.percent * (slot2.lvmax < slot1.num and slot2.lvmax or slot1.num)))

		if slot2.desc_spec_value ~= nil and slot2.desc_spec_value ~= "" then
			slot7 = string.gsub(slot7, tostring(slot6), slot2.desc_spec_value[slot1.num])
		end

		slot0.des_.text = slot7

		if slot0.content_ then
			slot0.content_.localPosition = Vector3(slot0.content_.localPosition.x, 0, 0)
		end
	end
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
