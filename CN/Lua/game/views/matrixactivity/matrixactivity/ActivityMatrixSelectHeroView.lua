slot0 = class("ActivityMatrixSelectHeroView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeSelectCharacterUI"
end

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityMatrixSelectHeroItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		slot1 = ActivityMatrixCfg[uv0.matrix_activity_id].hero_template_id
		slot2 = -1
		slot3 = false
		slot4 = nil

		if uv0.heros[uv0.selectIndex].hero_type == 1 then
			for slot10, slot11 in ipairs(ActivityMatrixHeroStandardTemplateCfg.get_id_list_by_template_id[slot1]) do
				if ActivityMatrixHeroStandardTemplateCfg[slot11].hero_id == slot5.id then
					slot2 = slot12.standard_id

					break
				end
			end

			slot4 = #HeroData:GetHeroData(slot5.id).using_astrolabe > 0
			slot9 = HeroTools.GetIsSuitNumCut(slot7)

			for slot14 = #EquipTools.CountActiveSuit(slot7.equip), 1, -1 do
				if slot10[slot14].num < EquipTools.GetSuitNeedNum(slot10[slot14].id, slot9) then
					table.remove(slot10, slot14)
				end
			end

			slot3 = #slot10 > 0
		else
			slot4 = #HeroTools.GetVirtualHeroByCfg(slot5.id).using_astrolabe > 0
			slot8 = HeroTools.GetIsSuitNumCut(slot6)
			slot9 = {}

			for slot13, slot14 in pairs(EquipTools.GetConstructVirtualEquips(slot2)) do
				if slot14.equip_id ~= 0 then
					if slot9[EquipCfg[slot14.prefab_id].suit] then
						slot9[slot15.suit].num = slot9[slot15.suit].num + 1
					else
						slot9[slot15.suit] = {
							num = 1,
							id = slot15.suit
						}
					end
				end
			end

			slot10 = {}

			for slot14, slot15 in pairs(slot9) do
				table.insert(slot10, slot15)
			end

			for slot14 = #slot10, 1, -1 do
				if slot10[slot14].num < EquipTools.GetSuitNeedNum(slot10[slot14].id, slot8) then
					table.remove(slot10, slot14)
				end
			end

			slot3 = #slot10 > 0
		end

		if not slot2 or slot2 == -1 then
			ShowTips("ERROR_NO_TEMPLATE")

			return
		end

		slot6 = nil

		if not slot3 and not slot4 then
			slot6 = GetTips("ACTIVITY_MATRIX_LACK_ALL")
		elseif not slot3 then
			slot6 = GetTips("ACTIVITY_MATRIX_LACK_EQUIP")
		elseif not slot4 then
			slot6 = GetTips("ACTIVITY_MATRIX_LACK_ASTROLABE")
		end

		slot7 = handler(uv0, function ()
			if uv0.type == 1 then
				ActivityMatrixAction.QueryStartMatrix({
					{
						hero_standard_system_id = uv1,
						hero_type = uv2.hero_type
					}
				}, uv3.matrix_activity_id, {})
			elseif uv0.type == 2 then
				uv3:Go("activityMatrixSelectAffix", {
					matrix_activity_id = uv3.matrix_activity_id,
					select_hero_list = {
						{
							hero_standard_system_id = uv1,
							hero_type = uv2.hero_type
						}
					}
				})
			else
				ShowTips("ERROR_BAD_ARG")
			end
		end)

		if slot6 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = slot6,
				OkCallback = slot7
			})
		else
			slot7()
		end
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function slot0.OnEnter(slot0)
	slot0.matrix_activity_id = slot0.params_.matrix_activity_id
	slot0.selectIndex = -1

	if not ActivityMatrixCfg[slot0.matrix_activity_id] then
		slot0.heroList:StartScroll(0)

		return
	end

	slot0.heros = {}

	for slot6, slot7 in ipairs(slot1.hero_trial) do
		table.insert(slot0.heros, {
			hero_type = 2,
			id = slot7
		})
	end

	slot3 = slot1.race_list

	for slot8, slot9 in pairs(HeroData:GetHeroList()) do
		slot10 = HeroCfg[slot8]

		if slot9.unlock == 1 and slot10 and table.indexof(slot3, slot10.race) then
			table.insert(slot0.heros, {
				hero_type = 1,
				id = slot8
			})
		end
	end

	slot0.heroList:StartScroll(#slot0.heros)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.RefreshUI(slot0)
	if slot0.selectIndex == -1 then
		slot0.m_btn.interactable = false
	else
		slot0.m_btn.interactable = true
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetIndex(slot1)

	if slot0.heros[slot1].hero_type == 1 then
		slot2:SetData(slot3.id)
	else
		slot2:SetStandardData(slot3.id)
	end

	slot2:SetSelect(slot0.selectIndex)
	slot2:RegistCallBack(handler(slot0, slot0.OnHeroItemClick))
end

function slot0.OnHeroItemClick(slot0, slot1)
	slot0.selectIndex = slot1

	for slot6, slot7 in pairs(slot0.heroList:GetItemList()) do
		slot7:SetSelect(slot0.selectIndex)
	end

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.heroList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
