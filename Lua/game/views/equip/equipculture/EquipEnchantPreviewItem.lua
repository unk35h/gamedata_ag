slot0 = class("EquipEnchantPreviewItem", ReduxView)

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

	slot0.stateController_ = ControllerUtil.GetController(slot0.m_stateController, "conName")
	slot0.skillItemList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btnSure, nil, function ()
		uv0:OnEnchantConfirmClick(true)
	end)
	slot0:AddBtnListener(slot0.m_btnCancel, nil, function ()
		uv0:OnEnchantConfirmClick(false)
	end)
end

function slot0.OnEnchantConfirmClick(slot0, slot1)
	EquipAction.QueryEquipEnchantConfirm(slot0.equipId, slot0.enchatPos, slot1, slot0.index)
end

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.index = slot1
	slot0.equipId = slot2
	slot0.enchatPos = slot3
	slot0.equipData = slot6

	slot0:RefreshSkill(slot4, slot5)
end

function slot0.SetState(slot0, slot1)
	slot0.stateController_:SetSelectedIndex(slot1 and 0 or 1)
end

function slot0.RefreshText(slot0, slot1)
	slot0.m_maskNum.text = "" .. slot1
end

function slot0.RefreshSkill(slot0, slot1, slot2)
	slot3 = #slot1
	slot4 = slot0.equipData.enchant[slot0.enchatPos]
	slot5 = slot1[1] and slot1[2] and slot1[1].id == slot1[2].id

	for slot9 = 1, 2 do
		if slot9 > #slot0.skillItemList then
			slot10 = Object.Instantiate(slot0.m_skillItem, slot0.m_skillParent)
			slot0.skillItemList[slot9] = EquipNewSkillItem.New(slot0, slot10)
			slot11 = slot0.skillItemList[slot9]

			slot11:RegistCallBack(function (slot0)
				if uv0.skllCallBack and slot0 then
					slot1 = deepClone(slot0)
					slot1.lv = EquipSkillCfg[slot1.id].lvmax < slot1.num and slot4.lvmax or slot3

					uv0.skllCallBack(uv0.skillItemList[uv1], slot1)
				end
			end)

			slot0.skillItemList[slot9].EmptyController = ControllerUtil.GetController(slot10.transform, "empty")
		end

		if slot1[slot9] then
			slot1[slot9].level = slot2
			slot1[slot9].hideMaxLevel = true
			slot10 = 0
			slot11 = 0

			if EquipTools.GetEquipedHeroId(slot0.equipData.equip_id) ~= 0 then
				slot11 = HeroTools.GetHeroEquipSkillAddLevel(HeroData:GetHeroData(slot12))

				for slot18, slot19 in ipairs(HeroTools.GetHeroEquipS(slot12)) do
					if EquipData:GetEquipData(slot19.equip_id) then
						slot10 = slot10 + slot20:GetSkillLevel(slot1[slot9].id)
					end
				end
			else
				slot10 = slot0.equipData:GetSkillLevel(slot1[slot9].id)
			end

			if slot4 then
				for slot16, slot17 in ipairs(slot4) do
					if slot17.id == slot1[slot9].id then
						slot10 = slot10 - slot17.num
					end
				end
			end

			deepClone(slot1[slot9]).num = (slot5 and slot10 + 2 or slot10 + 1) + slot11
			slot13.isAdd = slot11 == 1

			slot0.skillItemList[slot9]:RefreshData(slot0, slot13, true, false)
			slot0.skillItemList[slot9].EmptyController:SetSelectedIndex(0)
		else
			slot0.skillItemList[slot9]:RefreshData(slot0, nil)
			slot0.skillItemList[slot9].EmptyController:SetSelectedIndex(1)
		end

		slot0.skillItemList[slot9]:Show(true)
	end
end

function slot0.RegistSkillClickCallBck(slot0, slot1)
	slot0.skllCallBack = slot1
end

function slot0.Dispose(slot0)
	if slot0.skillItemList then
		for slot4, slot5 in ipairs(slot0.skillItemList) do
			slot5:Dispose()
		end

		slot0.skillItemList = {}
	end

	uv0.super.Dispose(slot0)
end

return slot0
