slot0 = class("EnchantmentItemView", ReduxView)
slot1 = {
	"icon_ee_boss_b",
	"icon_ee_boss_a",
	"icon_ee_boss_s"
}
slot2 = {
	"bg_ee_boss_b",
	"bg_ee_boss_a",
	"bg_ee_boss_s"
}

function slot0.GetCfg(slot0, slot1, slot2)
	slot0.stageName_ = BattleEnchantmentStageCfg[slot1].name
	slot0.rareSprite_ = getSprite("Atlas/BattleStage", uv0[slot2] .. SettingData:GetCurrentLanguageKey())
	slot0.rareBack_ = getSpriteViaConfig("Stage", uv1[slot2])
	slot0.cost_ = BattleEnchantmentStageCfg[slot1].cost
	slot0.dropList_ = getRewardFromDropCfg(BattleEnchantmentStageCfg[slot1].drop_lib_id, false)
	slot0.heroAffix_ = getHeroAffixs(BattleEnchantmentStageCfg[slot1].affix_type)
	slot0.enemyAffix_ = BattleEnchantmentStageCfg[slot1].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[slot1].affix_type) or BattleEnchantmentStageCfg[slot1].affix_type_in_map
	slot0.stageImage_ = BattleEnchantmentStageCfg[slot1].hd_image
end

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.itemTem_ = slot2
	slot0.func_ = slot3
	slot0.stageID_ = 0
	slot0.itemS = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.starbtnBtn_, nil, function ()
		JumpTools.OpenPopUp("enchantmentMultiPop", {
			stageID = uv0.stageID_
		})
	end)
	slot0:AddBtnListener(slot0.heroaffixBtn_, nil, function ()
		uv0.func_(uv0.heroaffixiconImg_.transform, uv0.heroAffix_[1])
	end)
	slot0:AddBtnListener(slot0.enemyaffixBtn_, nil, function ()
		uv0.func_(uv0.enemyaffixiconImg_.transform, uv0.enemyAffix_[1])
	end)
end

function slot0.AddListener(slot0, slot1)
	slot0:AddToggleListener(slot0.toggle_, slot1)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.stageID_ = slot1
	slot0.rare_ = slot2

	slot0:GetCfg(slot1, slot2)

	slot0.difficultImg_.sprite = slot0.rareSprite_
	slot0.sectionimageImg_.sprite = slot0.rareBack_
	slot0.nameText_.text = slot0.stageName_
	slot0.costText_.text = slot0.cost_
	slot0.bossImg_.sprite = getSpriteWithoutAtlas(string.format("Textures/ChapterPaint/EquipEnchantment/%s", slot0.stageImage_))

	if slot0.heroAffix_ and slot0.heroAffix_ ~= "" and slot0.heroAffix_[1] then
		slot0.heroaffixText_.text = getAffixName(slot0.heroAffix_[1])
		slot0.heroaffixiconImg_.sprite = getAffixSprite(slot0.heroAffix_[1])
	else
		slot0.heroaffixText_.text = ""
		slot0.heroaffixiconImg_.sprite = nil
	end

	if slot0.enemyAffix_ and slot0.enemyAffix_ ~= "" and slot0.enemyAffix_[1] then
		slot0.enemyaffixText_.text = getAffixName(slot0.enemyAffix_[1])
		slot0.enemyaffixiconImg_.sprite = getAffixSprite(slot0.enemyAffix_[1])
	else
		slot0.enemyaffixText_.text = ""
		slot0.enemyaffixiconImg_.sprite = nil
	end

	for slot6, slot7 in pairs(slot0.dropList_) do
		if not slot0.itemS[slot6] then
			slot0.itemS[slot6] = CommonItem.New(Object.Instantiate(slot0.itemTem_, slot0.contentTrs_))

			slot0.itemS[slot6]:RegistCallBack(function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.realNum
				})
			end)
			slot0.itemS[slot6]:RefreshData({
				id = slot7[1],
				number = slot7[2]
			})
			slot0.itemS[slot6]:HideNum()
		else
			slot0.itemS[slot6]:RefreshData({
				id = slot7[1],
				number = slot7[2]
			})
			slot0.itemS[slot6]:HideNum()
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.itemS do
		slot0.itemS[slot4]:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
