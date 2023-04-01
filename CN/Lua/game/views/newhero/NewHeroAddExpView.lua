slot0 = class("NewHeroAddExpView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroPromotion/HeroAddExpUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0.cutExpForReward_ = 0

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.items_ = {}

	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		slot6 = slot0[string.format("itemGo%d_", slot4)]

		SetActive(slot6, true)

		slot7 = CommonItem.New(slot6)

		table.insert(slot0.items_, slot7)
		slot7:RefreshData({
			selectNum_ = 0,
			id = slot5,
			number = slot0:GetNumber(slot5)
		})
		slot7:RegistCallBack(function (slot0)
			if slot0.number <= slot0.selectNum_ or uv0.cutExp_ > 0 then
				return
			end

			slot0.selectNum_ = slot0.selectNum_ + 1

			uv0:UpdatePreview()
		end)
		slot7:RegistGaryCallBack(function (slot0)
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function ()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end)
		slot7:RegistCutCallBack(function (slot0)
			slot0.selectNum_ = slot0.selectNum_ - 1

			uv0:UpdatePreview()
		end)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0.cutExpForReward_ = uv0.cutExp_

		if #MaterialTools.materialGiveBack(uv0.cutExp_, ItemConst.STR_ITEM.HERO) > 0 then
			uv0:Go("materialPreview", {
				content = GetTips("HERO_STRENGTH_EXP_OVERFLOW"),
				OkCallback = function ()
					uv0:SendAddExpToServer()
				end,
				itemList = slot0
			})

			return
		end

		uv0:SendAddExpToServer()
	end)
	slot0:AddBtnListener(slot0.oneKeyBtn_, nil, function ()
		if uv0:HaveMaterial() then
			uv0:OnKeyLevelUp()
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("NO_HERO_EXP_MATERIAL"),
				OkCallback = function ()
					JumpTools.JumpToPage(ItemCfg[GameSetting.hero_exp_props_id_list.value[1]].source[1])
				end
			})
		end
	end)
end

slot1 = 0
slot2 = {}

function slot0.SendAddExpToServer(slot0)
	uv0 = slot0.heroInfo_.level
	uv1 = HeroTools.CaculateHeroAttribute(slot0.heroInfo_, EquipTools.CalHeroEquipAttribute(slot0.heroInfo_.equip, slot0.heroInfo_.id))

	HeroTools.CalFinalAttribute(uv1)

	slot2 = {}

	for slot6, slot7 in ipairs(slot0.items_) do
		if slot7:GetItemInfo().selectNum_ > 0 then
			table.insert(slot2, {
				id = slot8.id,
				num = slot8.selectNum_
			})
		end
	end

	HeroAction.AddHeroExp(slot0.heroInfo_.id, slot2)
end

function slot0.OnAddHeroExp(slot0, slot1)
	if isSuccess(slot1.result) then
		slot2 = slot0.nextLv_

		HeroAction.AddHeroExpSuccess(slot0.heroInfo_.id, slot0.nextLv_, slot0.finalExp_)

		if not slot0:HaveMaterial() or slot0.curLvMax_ <= slot0.nextLv_ or manager.guide:IsPlaying() then
			slot0:Back()
		else
			slot0:SelectFirstMaterial()
			slot0:UpdatePreview()
		end

		if uv0 < slot2 then
			JumpTools.OpenPageByJump("newHeroUpgradeSuccess", {
				heroId = slot0.heroInfo_.id,
				oldLv = uv0,
				oldAttr = uv1,
				callback = function ()
					if #MaterialTools.materialGiveBack(uv0.cutExpForReward_, ItemConst.STR_ITEM.HERO) > 0 then
						getReward(slot0)
					end
				end
			})
		end
	end
end

function slot0.UpdateOKBtn(slot0)
	slot0.okBtn_.enabled = false

	for slot4, slot5 in ipairs(slot0.items_) do
		if slot5:GetItemInfo().selectNum_ > 0 then
			slot0.okBtn_.enabled = true

			break
		end
	end
end

function slot0.OnKeyLevelUp(slot0)
	slot0:QuickSelectList()
	slot0:UpdatePreview()
end

function slot0.UpdatePreview(slot0)
	slot0.fromLevelText_.text = string.format("%d", slot0.heroInfo_.level)
	slot0.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_)
	slot1 = 0
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.items_) do
		slot8 = slot7:GetItemInfo()
		slot1 = slot1 + ItemCfg[slot8.id].param[1] * slot8.selectNum_
		slot8.number = slot0:GetNumber(slot8.id)

		slot7:RefreshData({
			id = slot8.id,
			number = slot8.number,
			selectNum_ = slot8.selectNum_
		})

		if slot8.number == 0 then
			slot2 = slot2 + 1
		end

		slot12 = slot7
		slot10 = slot7.ShowSelect

		if slot8.selectNum_ == 0 then
			-- Nothing
		end

		slot10(slot12, slot8.selectNum_)
		slot7:SetGrey(slot8.number == 0 and "true" or "false")
	end

	ControllerUtil.GetController(slot0.upGradeGo_.transform, "select"):SetSelectedState(slot1 == 0 and "false" or "true")
	ControllerUtil.GetController(slot0.oneKeyBtn_.transform, "select"):SetSelectedState(slot2 == #slot0.items_ and "false" or "true")

	slot5, slot6, slot7, slot0.finalExp_, slot9 = LvTools.CheckHeroExp(slot0.heroInfo_.level, slot0.heroInfo_.exp + slot1, slot0.curLvMax_)
	slot0.nextLv_ = slot5
	slot0.cutExp_ = slot9
	slot0.addExpText_.text = string.format("+%d", slot1 - slot9)
	slot0.toLevelText_.text = string.format("%d", slot5)
	slot10 = GameLevelSetting[slot5].hero_level_exp1
	slot0.progressText_.text = string.format("%d/%d", slot6, slot10)
	slot0.currentProgressBar_.value = (slot0.heroInfo_.exp - LvTools.LevelToExp(slot0.heroInfo_.level, "hero_level_exp1")) / slot10
	slot0.previewProgressBar_.value = slot6 / slot10

	if slot0.heroInfo_.level < slot5 then
		slot0.currentProgressBar_.value = 0
	end

	SetActive(slot0.maxText_, slot0.curLvMax_ <= slot5)
end

function slot0.HaveMaterial(slot0)
	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if MaterialData:GetMaterialList()[slot5] and MaterialData:GetMaterialList()[slot5].num > 0 then
			return true
		end
	end

	return false
end

function slot0.SelectFirstMaterial(slot0)
	slot1 = true

	for slot5 = #slot0.items_, 1, -1 do
		slot0.items_[slot5]:ShowSelect()

		slot6 = slot0.items_[slot5]:GetItemInfo()
		slot6.selectNum_ = 0

		if uv0:GetNumber(slot6.id) > 0 and slot1 then
			slot1 = false
			slot6.selectNum_ = 1

			slot0.items_[slot5]:ShowSelect(slot6.selectNum_)
		end

		slot0.items_[slot5]:RefreshData(slot6)
	end

	slot0:UpdatePreview()
end

function slot0.OnEnter(slot0)
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)

	slot0:SelectFirstMaterial()
	slot0:UpdateOKBtn()
	slot0:RegistEventListener(MATERIAL_MODIFY, handler(slot0, slot0.OnMaterialModify))
	slot0:RegistEventListener(MATERIAL_DELETE, handler(slot0, slot0.OnMaterialModify))
end

function slot0.GetNumber(slot0, slot1)
	return MaterialData:GetMaterialList()[slot1] and MaterialData:GetMaterialList()[slot1].num or 0
end

function slot0.OnMaterialModify(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.items_) do
		if slot6:GetItemInfo().id == slot1 then
			slot6:RefreshData({
				selectNum_ = 0,
				id = slot1,
				number = slot0:GetNumber(slot1)
			})
		end
	end
end

function slot0.QuickSelectList(slot0)
	slot1 = LvTools.LevelToExp(slot0.curLvMax_, "hero_level_exp1") - slot0.heroInfo_.exp

	for slot5 = #slot0.items_, 1, -1 do
		slot6 = slot0.items_[slot5]:GetItemInfo()
		slot7 = ItemCfg[slot6.id].param[1]

		if slot1 - math.max(math.min(math.ceil(slot1 / slot7), slot6.number), 0) * slot7 < 0 and slot5 > 1 then
			slot9 = 0

			for slot13 = 1, slot5 - 1 do
				slot14 = slot0.items_[slot13]:GetItemInfo()
				slot9 = slot9 + ItemCfg[slot14.id].param[1] * slot14.number
			end

			if slot9 >= slot1 + slot7 and slot8 > 0 then
				slot8 = slot8 - 1
				slot1 = slot1 + slot7
			end
		end

		slot6.selectNum_ = slot8

		slot0.items_[slot5]:ShowSelect(slot8)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.items_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.items_ then
		for slot4, slot5 in ipairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
