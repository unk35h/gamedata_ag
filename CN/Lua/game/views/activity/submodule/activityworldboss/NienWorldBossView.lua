slot0 = class("NianBeastBossView", ReduxView)

function slot0.UIName(slot0)
	return "UI/EmptyDream/WorldBoss/EDream_WorldBoss"
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

	slot0.rewardItems = {}
	slot0.commonItem = CommonItem.New(slot0.m_coinItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_startBtn, nil, function ()
		uv0:Go("/sectionSelectHeroActivityWorldBoss", {
			section = ActivityWorldBossData:GetStageId(uv0.activity_id),
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS,
			activityID = uv0.activity_id
		})
	end)
	slot0:AddBtnListener(slot0.m_shopBtn, nil, function ()
		slot1, slot2 = ShopTools.IsShopOpen(({
			32
		})[1])

		if slot1 then
			JumpTools.GoToSystem("/shop", {
				shopId = slot0[1],
				showShops = slot0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif slot2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif slot2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	slot0:AddBtnListener(slot0.m_skillBtn, nil, function ()
		JumpTools.OpenPageByJump("ActivityWorldBossSkill", {
			bossID = ActivityWorldBossCfg[uv0.activity_id].boss_id[1]
		})
	end)
	slot0:AddBtnListener(slot0.m_itemBtn, nil, function ()
		uv0.activity_id = ActivityConst.NIEN_WORLD_BOSS

		ShowPopItem(POP_SOURCE_ITEM, {
			ActivityWorldBossCfg[uv0.activity_id].coin_id,
			1
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SPRING_FESTIVAL_MONSTER_DESCRIPE")
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("activityWorldBoss")

	slot0.activity_id = ActivityConst.NIEN_WORLD_BOSS

	ActivityWorldBossAction.QueryBossData(slot0.activity_id)
	slot0:RefreshUI()

	if ActivityWorldBossCfg[slot0.activity_id].pre_story_id and not manager.story:IsStoryPlayed(slot2) then
		slot3 = manager.story

		slot3:StartStoryById(slot2, function (slot0)
		end)
	end

	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityWorldBossCfg[slot0.activity_id]
	slot2 = ActivityWorldBossData:GetLeftHealthPoint(slot0.activity_id)
	slot0.m_healthSlider.value = slot2 / 1000
	slot10 = slot2 / 10
	slot0.m_bossName.text = CollectMonsterCfg[slot1.boss_id[1]].name .. " " .. math.ceil(slot10) .. "%"
	slot6 = slot0.m_rewardContent.rect.width

	for slot10 = 1, #slot1.health_reward_list do
		if not slot0.rewardItems[slot10] then
			slot0.rewardItems[slot10] = NiewWorldBossRewardItem.New(Object.Instantiate(slot0.m_rewardItem, slot0.m_rewardContent), slot6)
		end

		slot0.rewardItems[slot10]:SetData(slot0.activity_id, slot10)
		slot0.rewardItems[slot10]:SetActive(true)
	end

	for slot10 = slot5 + 1, #slot0.rewardItems do
		slot0.rewardItems[slot10]:SetActive(false)
	end

	slot0.commonItem:RefreshData({
		number = 1,
		id = slot1.coin_id
	})
	slot0.commonItem:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.coin_id)
	end)

	slot0.m_coinMax.text = "/" .. ActivityWorldBossData:GetMaxCoinNum(slot0.activity_id)
	slot0.m_coinCount.text = ActivityWorldBossData:GetCointCount(slot0.activity_id)

	if ActivityWorldBossData:GetAffix(slot0.activity_id) then
		SetActive(slot0.m_affixImg.gameObject, true)

		slot0.m_affixDes.text = getAffixDesc(slot9)
		slot0.m_affixImg.sprite = getAffixSprite(slot9)
	else
		slot0.m_affixDes.text = ""

		SetActive(slot0.m_affixImg.gameObject, false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItems) do
		slot5:Dispose()
	end

	slot0.rewardItems = {}

	slot0.commonItem:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnActivityWorldBossUpdate(slot0)
	slot0:RefreshUI()
end

return slot0
